/** 
  * @desc this file will contains the routes for goals api
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file goals.js
*/

const express = require('express');
const GoalService = require('../../services/GoalService');
const NotificationService = require('../../services/NotificationService');
const UserService = require('../../services/UserService');
const completionService = require('../../services/CompletionService');
const customHelper = require('../../helpers/custom_helper');
const formValidator = require('validator');
const current_datetime = require('date-and-time');
var cron = require('node-cron');
const jwt = require('jsonwebtoken')
// verifytoken middleware
const verifyToken = require('./verifytoken');

// Create route object
let router =  express.Router();

// Get API secret
const config = require('../../config/config');

// Create goal model object
var goalSerObject = new GoalService();

// Create user model object
var userSerObject = new UserService();

// Create user model object
var completionSerObject = new completionService();

var notificationObject = new NotificationService();

// Get user setting detail
router.get('/getgoalsettings', verifyToken, function(req, res, next) {

	goalSerObject.getGoalSettings(function(err, settingData)
	{
		if(err)
		{
			res.send({
				status: 500,
				message: 'There was a problem finding the user setting.',
			});
		}
		else
		{
			if(settingData)
			{
				goalSerObject.getGoalSettings(function(err, GetquestionWithOption) {
					if(err) {
						res.send({
							status: 404,
							message: "Something Went Wrong"
						})
					} else {
						if(GetquestionWithOption) {
							res.send({
								status: 200,
								settings: GetquestionWithOption,
							});
						} else {
							res.send({
								status: 504,
								message: "Option is not found"
							})
						}
					}
				})
			}
			else
			{
				res.send({
					status: 404,
					message: 'Question is not found.',
				});
			}
		}
	});
});

// Get user setting detail
router.get('/getgoalsettingsanswer/:goal_id', verifyToken, function(req, res, next) {
	let user_id = jwt.decode(req.headers['x-access-token']).id;
	let goal_id = req.params.goal_id;
	goalSerObject.getGoalSettings(function(err, settingData)
	{
		if(err)
		{
			res.send({
				status: 500,
				message: 'There was a problem finding the user setting.',
			});
		}
		else
		{
			if(settingData)
			{
				goalSerObject.getGoalSettingsAnswer(user_id, goal_id,function(err, GetquestionWithOption) {
					if(err) {
						res.send({
							status: 404,
							message: "something went wrong"
						})
					} else {
						if(GetquestionWithOption) {
							res.send({
								status: 200,
								settings: GetquestionWithOption,
							});
						} else {
							res.send({
								status: 504,
								message: "Quetionaries is not avaliable."
							})
						}
					}
				})
			}
			else
			{
				res.send({
					status: 404,
					message: 'Question is not found.',
				});
			}
		}
	});
});

// Save user setting detail
router.post('/savegoalsettings', verifyToken, function(req, res) {
	let user_id     = jwt.decode(req.headers['x-access-token']).id

	// if(!question_id) 
	// {
	// 	return res.send({
	// 		status: 400,
	// 		message: 'Question Id is required.',
	// 	});
	// }

	// if(!formValidator.isInt(question_id))   
	// {
	// 	return res.send({
	// 		status: 400,
	// 		message: 'Please enter a valid question id.',
	// 	});
	// }

	// if(!answer) 
	// {
	// 	return res.send({
	// 		status: 400,
	// 		message: 'Answer is required',
	// 	});
	// }
	req.body.map(response => {
		// Check setting question exists or not
		goalSerObject.getGoalSettingsQuestionById(response.question_id, function(err, goalQuestionData) 
		{
			if(err)
			{
				res.send({
					status: 500,
					message: 'something went wrong',
				});
			}
			else
			{
				if(goalQuestionData) 
				{
					let goalSettingData = {
						'question_id': response.question_id,
						'answer': response.answer,
						'user_id': user_id,
						'custom_answer': response.custom_answer ? response.custom_answer : null
					};
					goalSerObject.saveSettings(goalSettingData, function(err, goalSettingDataSaved)
					{
						if(err)
						{
							res.send({
								status: 500,
								message: 'something went wrong',
							});
						}
						else
						{
							userSerObject.updateUserStage(7, user_id, function(err, updatedStage) {
								if(updatedStage) {
									userSerObject.getPartnerById(user_id, function(err, patnerData) {
										if(err) {
											res.send({
												status: 400,
												message: "something went wrong"
											})
										} else {
											if(patnerData) {
												res.send({
													status:200,
													message: "Question answer is saved successfully",
													user_stage: updatedStage.stage,
												})
											} else {
												res.send({
													status: 504,
													messgae: "Patner is not found"
												})
											}
										}
									})
								}

							})
						}
					});
				}
				else
				{
					return res.send({
						status: 400,
						message: 'Question is not found',
					});
				}
			}
		});
	})
});

// Compare user security code
router.post('/checkuseruniquecode', verifyToken, function(req, res) {

	let user_id     = req.body.user_id;
	let unique_code = req.body.unique_code;

	if(!user_id) 
	{
		return res.send({
			status: 400,
			message: 'User Id is required.',
		});
	}

	if(!formValidator.isInt(user_id))   
	{
		return res.send({
			status: 400,
			message: 'Please enter a valid user id.',
		});
	}

	if(!unique_code) 
	{
		return res.send({
			status: 400,
			message: 'Unique code is required.',
		});
	}

	if(!formValidator.isAlpha(unique_code))   
	{
		return res.send({
			status: 400,
			message: 'Please enter a valid unique code.',
		});
	}

	// Check user exists or not
	userSerObject.getUserById(user_id, function(err, userData) 
	{
		if(err)
		{
			res.send({
				status: 500,
				message: 'something went wrong',
			});
		}
		else
		{
			if(userData) 
			{
				// Check security code exists or not
				userSerObject.checkUniqueCode(unique_code, function(err, uniqueCodeData) 
				{
					if(err)
					{
						res.send({
							status: 500,
							message: 'something went wrong',
						});
					}
					else
					{
						if(uniqueCodeData) 
						{
							if(user_id==uniqueCodeData.id)
							{
								return res.send({
									status: 400,
									message: 'Partner-Id should be different.',
								});
							}

							let monthlyGoalData = {
								'partner_one_id': user_id,
								'partner_two_id': uniqueCodeData.id,
							};
							goalSerObject.checkParterLink(monthlyGoalData, function(err, partnerData) 
							{
								if(err)
								{
									res.send({
										status: 500,
										message: 'something went wrong',
									});
								}
								else
								{

									if(partnerData) 
						            {
										userSerObject.getUserById(uniqueCodeData.id, function(err, response) {
											if(err) {
												return res.send({
													status: 400,
													message: 'Your patner is not found',
												});
											} else {
												if(response) {
													if(response.stage !== 3) {
														return res.send({
															status: 200,
															message: 'Please Wait, Your parten is not entered code!'
														})
													}
													if(response.stage === 3) {
														// userSerObject.freeSecurityCodes(monthlyGoalData, function(err, freeSecurityData){
															userSerObject.updateUserStage(4, user_id, function(err, userStageupdatedata) {
																if(userStageupdatedata) {
																	return res.send({
																		status: 400,
																		message: 'These users are already linked.',
																		stage: userStageupdatedata.stage
																	})
																}
															});
														// }
													}
												} else {
													res.send({
														status: 504,
														message: "Patner is not found"
													})
												}
											}
										});
									}
									else
									{
										userSerObject.updateUserStage(3, user_id, function(err, userStageupdatedata) {
											if(userStageupdatedata) {
												goalSerObject.createPartnerMapping(monthlyGoalData, function(err, createMonthlyData)
												{
													if(err)
													{
														res.send({
															status: 500,
															message: 'something went wrong',
														});
													}
													else
													{
														if(createMonthlyData) 
														{
															userSerObject.getUserById(uniqueCodeData.id, function(err, response) {
																if(err) {
																	return res.send({
																		status: 400,
																		message: 'Your patner is not found',
																	});
																} else {
																	if(response) {
																		if(response.stage !== 3) {
																			return res.send({
																				status: 200,
																				message: 'Please Wait, Your parten is not entered code!',
																				FCMID: uniqueCodeData.fcmid
																			})
																		}
																		if(response.stage === 3) {
																			// userSerObject.freeSecurityCodes(monthlyGoalData, function(err, freeSecurityData){
																			userSerObject.updateUserStage(4, user_id, function(err, userStageupdatedata) {
																				if(userStageupdatedata) {
																					userSerObject.updateUserStage(4, monthlyGoalData.partner_two_id, function(err, updatepatnerStage){
																						if(updatepatnerStage) {
																							return res.send({
																								status: 200,
																								message: 'Paring sucessfully',
																								stage: userStageupdatedata.stage,
																								FCMID: uniqueCodeData.fcmid
																							})
																						}
																					})
																				}
																			});
																			// }
																		}
																	} else {
																		res.send({
																			status: 504,
																			message: "Something went Wrong"
																		})
																	}
																}
															});
														}
														else
														{
															return res.send({
																status: 400,
																message: 'Something went wrong.',
															});
														}
													}
												});
											} else {
												res.send({
													status:400,
													message:'something went wrong'
												})
											}
										});
									}
								}
							});
						}
						else
						{
							return res.send({
								status: 400,
								message: "Your Partner's code does not match",
							});
						}
					}
				});
			}
			else
			{
				return res.send({
					status: 400,
					message: 'User is not found',
				});
			}
		}
	});
});

// Get partner mapping
router.post('/getpartnermapping', verifyToken, function(req, res) {

	let partner_one_id = req.body.partner_one_id;
	let partner_two_id = req.body.partner_two_id;

	if(!partner_one_id) 
	{
		return res.send({
			status: 400,
			message: 'First partner id is required.',
		});
	}

	if(!formValidator.isInt(partner_one_id))   
	{
		return res.send({
			status: 400,
			message: 'Please enter a valid first partner id.',
		});
	}

	if(!partner_two_id) 
	{
		return res.send({
			status: 400,
			message: 'Second partner Id is required.',
		});
	}

	if(!formValidator.isInt(partner_two_id))   
	{
		return res.send({
			status: 400,
			message: 'Please enter a valid second partner id.',
		});
	}

	let partneMappingData = {
		'partner_one_id': partner_one_id,
		'partner_two_id': partner_two_id
	};

	goalSerObject.checkParterLink(partneMappingData, function(err, partnersData)
	{
		if(partnersData.status)
		{
			if(err)
			{
				res.send({
					status: 500,
					message: 'something went wrong',
				});
			}
			else
			{
				if(partnerData) {
					res.send({
						status: 200,
						partnerMappingData: partnersData,
					});
				} else {
					res.send({
						status: 504,
						message: "Something went is wrong"
					})
				}
			}
		}
		else
		{
			res.send({
				status: 403,
				message: 'This mapping has been expired',
			});
		}
	});
});

// Create monthly goal
router.post('/createmonthlygoal', verifyToken, function(req, res) {

	// let partner_mapping_id = req.body.partner_mapping_id;
	let user_id  = jwt.decode(req.headers['x-access-token']).id;
	let connect_number     = req.body.connect_number;
	// let percentage         = req.body.percentage;/
	let intimate_account_time = req.body.intimate_account_time;
	let intimate_request_time = req.body.intimate_request_time;
	let intimate_time = req.body.intimate_time;
	let initiator_count = req.body.initiator_count;
	let initiator_count1 = req.body.initiator_count1;


	if(!user_id) 
	{
		return res.send({
			status: 400,
			message: 'User id is required.',
		});
	}

	if(!formValidator.isInt(user_id))   
	{
		return res.send({
			status: 400,
			message: 'Please enter a valid user id.',
		});
	}

	if(!connect_number) 
	{
		return res.send({
			status: 400,
			message: 'Please enter a valid information.',
		});
	}

	if(!formValidator.isInt(connect_number))   
	{
		return res.send({
			status: 400,
			message: 'Please enter a valid information.',
		});
	}

	if(!intimate_account_time) 
	{
		return res.send({
			status: 400,
			message: 'Please enter a valid information.',
		});
	}

	if(!intimate_request_time) 
	{
		return res.send({
			status: 400,
			message: 'Please enter a valid information.',
		});
	}

	if(!intimate_time) 
	{
		return res.send({
			status: 400,
			message: 'Please enter a valid information.',
		});
	}

	if(!initiator_count) 
	{
		return res.send({
			status: 400,
			message: 'Please enter a valid information.',
		});
	}

	if(!initiator_count1) 
	{
		console.log(initiator_count1)
		return res.send({
			status: 400,
			message: 'Please enter a valid information.',
		});
	}
	// Check goal exists or not
	goalSerObject.checkParternstage(user_id, function(err, partnerMappingData) 
	{
		if(err)
		{
			res.send({
				status: 500,
				message: 'something went wrong',
			});
		}
		else
		{
			if(partnerMappingData) 
			{
				userSerObject.getUserById(partnerMappingData.partner_two_id, function(err, partenerData) {
					if(err) {
						res.send({
							status: 400,
							message: 'Invalid partner id provided',
						});
					} else {
						if(partenerData) {
							if(partenerData.stage === 5) {
								res.send({
									status: 400,
									message: 'Please Wait! The goal setup is already in progress by your partner.',
								});
							} else {
								var user_checker = 0
								if(partnerMappingData.partner_one_id==user_id) 
								{
									user_checker++;
								}

								if(partnerMappingData.partner_two_id==user_id) 
								{
									user_checker++;
								}

								if(user_checker==0)
								{
									res.send({
										status: 400,
										message: 'Invalid partner id provided',
									});
								}
								else
								{
									userSerObject.updateUserStage(5, user_id, function(er, updateedstage){})
									const now = new Date();
									var   parter_id = 0;
									if(partnerMappingData.partner_one_id!=user_id)
									{
										parter_id = partnerMappingData.partner_one_id;
									}
									if(partnerMappingData.partner_two_id!=user_id)
									{
										parter_id = partnerMappingData.partner_two_id;
									}
									// var initiator_count = customHelper.h_getNumberOfTimesPercentage(connect_number, percentage);
									// var partner_percentage = 100 - percentage;
									// var partner_initiator_count = connect_number - initiator_count;
									let monthlyGoalData = {
										'partner_mapping_id': partnerMappingData.id,
										'user_id': user_id,
										'month_start': current_datetime.format(now, 'YYYY-MM-DD'),
										'month_end': customHelper.h_get30daysAdvanceDate(),
										'connect_number': connect_number,
										// 'percentage': percentage,
										'initiator_count': initiator_count,
										'initiator_count1': initiator_count1,
										'status': 1,
										'intimate_time': intimate_time,
										'intimate_request_time': intimate_request_time,
										'intimate_account_time': intimate_account_time,
										'partner_id': parter_id,
										// 'partner_percentage': partner_percentage,
										'partner_initiator_count': initiator_count,
									};
									goalSerObject.createMonthlyGoal(monthlyGoalData, function(err, monthlyGoalDataSaved)
									{
										if(err)
										{
											userSerObject.updateUserStage(4, parter_id, function(er, updateedstage){})
											res.send({
												status: 500,
												message: 'something went wrong.',
											});
										}
										else
										{
											userSerObject.getUserById(parter_id, function(err, GetpatnerData) {
												if(err) {
													res.send({
														status:400,
														message: "Something went Wrong"
													})
												} else {
													if(GetpatnerData) {
														userSerObject.updateUserStage(6, user_id, function(err, updatedStage) {
															if(updatedStage) {
																userSerObject.getPartnerById(user_id, function(err, patnerData) {
																	if(err) {
																		res.send({
																			status: 400,
																			message: "something went wrong"
																		})
																	} else {
																		if(patnerData) {
																			userSerObject.updateUserStage(6, patnerData.id, function(err, updateedstage){
																				const [time, modifier] = monthlyGoalDataSaved.intimate_request_time.split(' ');
																				let [hours, minutes] = time.split(':');
																				if (hours === '12') {
																				hours = '00';
																				}
																				if (modifier === 'PM') {
																				hours = parseInt(hours, 10) + 12;
																				}
																				var night = new Date(
																					now.getFullYear(),
																					now.getMonth(),
																					now.getDate(),
																					hours, minutes, 0
																					);
																					var date = new Date();
																				var month = date.getMonth() + 1;
																				var year = date.getFullYear();
																				date.get
																				// var month = current_datetime.format(night, 'MM', true);
																				// var year = current_datetime.format(night, 'YYYY', true);
																				// minutes = current_datetime.format(night, 'mm', true);
																				// hours = current_datetime.format(night, 'HH', true);
																				// console.log(minutes, hours)
																				var lastDay = new Date(date.getFullYear(), date.getMonth() + 1, 0).getDate();
																				var current_date = date.getDate();
																				let remaing = lastDay - current_date;
																				let day = parseInt(new Date(year, month, 0).getDate() / monthlyGoalDataSaved.connect_number);
																				if(day <= 0) {
																					day = 1
																				}
																				cron.schedule(`${parseInt(minutes)} ${hours} */${day} * *`, () => {
																					// cron.schedule(`* * * * *`, (err, ress) => {

																					goalSerObject.getGoalDetails(updatedStage.id, updateedstage.id, function(err, monthlyGoal_data) {
																						if(err) {
																							res.send({
																								status:404,
																								message: "Something went wrong!"
																							})
																						} else {
																							if(monthlyGoal_data) {
																								let PR;
																								if (monthlyGoal_data.complete_count == 0) {
																									PR = 100;
																								} else {
																									PR = (monthlyGoal_data.complete_count / monthlyGoal_data.connect_number) * 100;
																								}
																								let Notificationmessage = {
																									PR: PR,
																									remaing_days: remaing,
																								}
																								notificationObject.notification(updatedStage.fcmid, Notificationmessage, function(err, response) {
																									let notification1 = {
																										user_id: updatedStage.id,
																										goal_id: monthlyGoalDataSaved.id,
																										device_id: updatedStage.fcmid,
																										notification_id: response.results[0].message_id,
																									}
																									notificationObject.saveNotification(notification1, function(err, response) {
																									})
																								})
																								notificationObject.notification(updateedstage.fcmid, Notificationmessage,function(err, response) {
																									let notification1 = {
																										user_id: updateedstage.id,
																										goal_id: monthlyGoalDataSaved.id,
																										device_id: updateedstage.fcmid,
																										notification_id: response.results[0].message_id,
																									}
																									notificationObject.saveNotification(notification1, function(err, response) {})
																								})
																							}
																						}
																					})
																				});
																				if(updateedstage) {
																					res.send({
																						status: 200,
																						message: 'The monthly goal has been successfully created.',
																						stage: updatedStage.stage,
																						fcmid: GetpatnerData.fcmid,
																						Patner1_first_name: updatedStage.first_name,
																						Patner1_last_name: updatedStage.last_name,
																						patner1_stage: updatedStage.stage,
																						Patner2_first_name:updateedstage.first_name,
																						Patner2_last_name:updateedstage.last_name,
																						patner2_stage: updateedstage.stage
																					});
																				}
																			})
																		} else {
																			res.send({
																				status: 504,
																				messgae: "partner is not found"
																			})
																		}
																	}
																} )
															}
														})
													} else {
														res.send({
															status: 504,
															messgae: "Patner is not found"
														})
													}
												}
											})
										}
									});
								}
							}
						} else {
							res.send({
								status: 504,
								messgae: "Patner is not found"
							})
						}
					}
				})
                // check if user-id is found or not in partner mapping table
			}
			else
			{
				return res.send({
					status: 400,
					message: 'This mapping has been expired',
				});
			}
		}
	});
});

// Checking user enter goal page or not
router.post('/CheckingStage', verifyToken, function(req, res) {
	let user_id  = jwt.decode(req.headers['x-access-token']).id;
	if(!user_id) {
		return res.send({
			status: 400,
			message: 'User id is required.',
		});
	}
	userSerObject.getUserById(user_id, function(err, userDetails) {
		if(err) {
			res.send({
				status: 400,
				message:"something went wrong"
			})
		} else {
			if(userDetails) {
				goalSerObject.getPartnerData(user_id, function(err, partnerMappingData) 
				{
					if(err) {
						res.send({
							status: 500,
							message: 'something went wrong',
						});
					} else {
						if(partnerMappingData) {
							userSerObject.getUserById(partnerMappingData.partner_two_id, function(err, partenerData) {
								if(err) {
									res.send({
										status: 400,
										message: 'Invalid partner id provided',
									});
								} else {
									if(partenerData) {
										if(partenerData.stage === 5 && userDetails.stage === 4) {
											res.send({
												status: 400,
												message: 'Please Wait, Your partner is already setting goal',
											});
										} else {
											if(partenerData.stage === 4 && userDetails.stage === 4) {
												userSerObject.updateUserStage(5, user_id, function(err, updatestageData) {
													if(updatestageData) {
														res.send({
															status: 200,
															message: 'Sucessfully enter goal page',
															stage: updatestageData.stage
														})
													} else {
														res.send({
															status: 400,
															message: 'Something Went wrong',
														})
													}
												}) 
											}
											if(partenerData.stage === 6 && userDetails.stage === 4) {
												res.send({
													status: 200,
													message: 'Goal already created',
													userStage: userDetails.stage,
													patner_stage: partenerData.stage
												})
											}
											if(partenerData.stage === 7 && userDetails.stage === 4) {
												res.send({
													status: 200,
													message: 'Questionaries Saved',
													userStage: userDetails.stage,
													patner_stage: partenerData.stage
												})
											}
											if(partenerData.stage < 4) {
												res.send({
													status:400,
													messgae: "Paring is not save successfully",
													user_stage: userDetails.stage
												})
											}
											if(userDetails.stage > 4) {
												res.send({
													status:200,
													message: "User stage already updated",
													user_stage: userDetails.stage,
													patner_stage:partenerData.stage
												})
											}
											if(partenerData.stage === 4 && userDetails.stage < 4) {
												userSerObject.updateUserStage(4, userDetails.id, function(err, updatestageData) {
													if(updatestageData) {
														userSerObject.updateUserStage(5, user_id, function(err, updatestageData) {
															if(updatestageData) {
																res.send({
																	status: 200,
																	message: 'Sucessfully enter goal page',
																	stage: updatestageData.stage
																})
															} else {
																res.send({
																	status: 400,
																	message: 'Something Went wrong',
																})
															}
														}) 
													} else {
														res.send({
															status: 400,
															message: 'Something Went wrong',
														})
													}
												}) 
											}
										}
									} else {
										res.send({
											status: 504,
											message: "partner is not found"
										})
									}
								}
							});
						} else {
							res.send({
								status: 504,
								message: "Paring is not found"
							})
						}
					}
				});
			} else {
				res.send({
					status: 504,
					message: "User is not found"
				})
			}
		}
	})
})

// Update monthly goal
router.post('/updatemonthlygoal/:goal_id', verifyToken, function(req, res) {
	let user_id = jwt.decode(req.headers['x-access-token']).id;
	let goal_id            = req.params.goal_id;
	let connect_number     = req.body.connect_number;
	// let percentage         = req.body.percentage;
	let intimate_account_time = req.body.intimate_account_time;
	let intimate_request_time = req.body.intimate_request_time;
	let intimate_time = req.body.intimate_time;
	let initiator_count = req.body.initiator_count;
	let initiator_count1 = req.body.initiator_count1;
	if(!goal_id) 
	{
		return res.send({
			status: 400,
			message: 'Goal Id is required.',
		});
	}

	if(!formValidator.isInt(goal_id))   
	{
		return res.send({
			status: 400,
			message: 'Please enter a valid goal id.',
		});
	}

	if(!connect_number) 
	{
		return res.send({
			status: 400,
			message: 'Connect number is required.',
		});
	}

	if(!formValidator.isInt(connect_number))   
	{
		return res.send({
			status: 400,
			message: 'Please enter a valid connect number.',
		});
	}
	if(!intimate_account_time) 
	{
		return res.send({
			status: 400,
			message: 'Intimate Account Time is required.',
		});
	}

	if(!intimate_request_time) 
	{
		return res.send({
			status: 400,
			message: 'Intimate Request Time is required.',
		});
	}

	if(!intimate_time) 
	{
		return res.send({
			status: 400,
			message: 'Intimate time is required.',
		});
	}

	if(!initiator_count) 
	{
		return res.send({
			status: 400,
			message: 'Initiator count is required.',
		});
	}

	if(!initiator_count1) 
	{
		console.log(initiator_count1)
		return res.send({
			status: 400,
			message: 'Initiator count 1 is required.',
		});
	}
	// if(!percentage) 
	// {
	// 	return res.send({
	// 		status: 400,
	// 		message: 'Percentage is required.',
	// 	});
	// }

	// if(!formValidator.isInt(percentage))   
	// {
	// 	return res.send({
	// 		status: 400,
	// 		message: 'Please enter a valid percentage.',
	// 	});
	// }

	// Check goal exists or not
	goalSerObject.getGoalById(goal_id, function(err, goalData) 
	{
		if(err)
		{
			res.send({
				status: 500,
				message: 'something went wrong',
			});
		}
		else
		{
			if(goalData)
			{
				userSerObject.getPartnerById(user_id, function(err, partnerResponse) {
					if(err) {
						res.send({
							status: 400,
							message: "something went wrong"
						})
					} else {
						if(partnerResponse) {
							if(goalData.status)
							{
								let monthlyGoalData = {
									'partner_mapping_id': goalData.partner_mapping_id,
									'user_id': user_id,
									'connect_number': connect_number,
									'initiator_count': initiator_count,
									'initiator_count1': initiator_count1,
									'status': 1,
									'intimate_time': intimate_time,
									'intimate_request_time': intimate_request_time,
									'intimate_account_time': intimate_account_time,
									'id': goal_id,
									'partner_initiator_count': initiator_count,
								};
								goalSerObject.updateMonthlyGoal(monthlyGoalData, function(err, monthlyGoalDataSaved)
								{
									if(err)
									{
										res.send({
											status: 500,
											message: 'something went wrong.',
										});
									}
									else
									{
									if(monthlyGoalDataSaved) {
										userSerObject.getUserById(partnerResponse.id, function(err, GetpatnerData) {
											if(err) {
												res.send({
													status:400,
													message: "Something went Wrong"
												})
											} else {
												if(GetpatnerData) {
													userSerObject.getUserById(user_id, function(err, usersData) {
														if(err) {
															res.send({
																status: 404,
																messgae: "Something Went wrong"
															})
														} else {
															if(usersData) {
																const [time, modifier] = monthlyGoalDataSaved.intimate_request_time.split(' ');
																let [hours, minutes] = time.split(':');
																if (hours === '12') {
																hours = '00';
																}
																if (modifier === 'PM') {
																hours = parseInt(hours, 10) + 12;
																}
																var date = new Date();
																var month = date.getMonth() + 1;
																var year = date.getFullYear();
																let day = parseInt(new Date(year, month, 0).getDate() / monthlyGoalDataSaved.connect_number);
																if(day <= 0) {
																	day = 1
																}
																cron.schedule(`${parseInt(minutes)} ${hours} */${day} * *`, () => {
																	// cron.schedule(`* * * * *`, (err, ress) => {
																		notificationObject.notification(GetpatnerData.fcmid, function(err, response) {
																			let notification1 = {
																				user_id: GetpatnerData.id,
																				goal_id: monthlyGoalDataSaved.id,
																				device_id: GetpatnerData.fcmid,
																				notification_id: response.results[0].message_id,
																			}
																			notificationObject.saveNotification(notification1, function(err, response) {
																			})
																		})
																		notificationObject.notification(usersData.fcmid, function(err, response) {
																			let notification1 = {
																				user_id: usersData.id,
																				goal_id: monthlyGoalDataSaved.id,
																				device_id: usersData.fcmid,
																				notification_id: response.results[0].message_id,
																			}
																			notificationObject.saveNotification(notification1, function(err, response) {})
																		})
																}, {timezone: "Asia/Kolkata"});
																res.send({
																	status: 200,
																	message: 'The monthly goal has been updated.',
																	patner_fcmid: partnerResponse.fcmid
																});
															} else {
																res.send({
																	status: 504,
																	messgae: "user is not found"
																})
															}
														}
													})
												} else {
													res.send({
														status: 504,
														messgae: "Patner is not found"
													})
												}
											}
										})
										
										} else {
											res.send({
												status: 504,
												message: "Goal is not update"
											})
										}
									}
								});
							}
							else
							{
								return res.send({
									status: 400,
									message: 'This goal is not active',
								});
							}
						} else {
							res.send({
								status: 400,
								message: "partner not found"
							})
						}
					}
				})
			}
			else
			{
				return res.send({
					status: 400,
					message: 'This goal is not valid',
				});
			}
		}
	});
});

// Get monthly goal detail
router.get('/getmonthlygoaldetail', verifyToken, function(req, res, next) {

	let user_id  = jwt.decode(req.headers['x-access-token']).id;

	if(!user_id)
	{
		return res.send({
			status: 400,
			message: 'User Id is required.',
		});
	}

	goalSerObject.getPartnerData(user_id, function(err, patnerData) {
		if(patnerData) {
			goalSerObject.getGoalDetails(patnerData.partner_one_id, patnerData.partner_two_id, function(err, goalCompleteData)
			{
				if(err)
				{
					res.send({
						status: 500,
						message: 'Something went wrong please try after some time.',
					});
				}
				else
				{
					if(goalCompleteData) {
						userSerObject.getUserById(user_id, function(err, loginUserData) {
							if(loginUserData) {
								userSerObject.getPartnerById(user_id, function(err, patnerData, id) {
									if(patnerData) {
										let currentGoalData = {
											id: goalCompleteData.id,
											partner_mapping_id: goalCompleteData.partner_mapping_id,
											user_id: goalCompleteData.user_id,
											goal_identifier: goalCompleteData.goal_identifier,
											month_start: goalCompleteData.month_start,
											month_end: goalCompleteData.month_end,
											connect_number: goalCompleteData.connect_number,
											initiator_count: goalCompleteData.user_id === user_id ? goalCompleteData.initiator_count : goalCompleteData.initiator_count1,
											initiator_count1: goalCompleteData.user_id === user_id ? goalCompleteData.initiator_count1 : goalCompleteData.initiator_count,
											intimate_time: goalCompleteData.intimate_time,
											intimate_request_time: goalCompleteData.intimate_request_time,
											intimate_account_time: goalCompleteData.intimate_account_time,
											complete_count: goalCompleteData.complete_count,
											complete_percentage: goalCompleteData.complete_percentage,
											status: goalCompleteData.status,
											create_time: goalCompleteData.create_time,
											update_time: goalCompleteData.update_time,
											user1_first_name:loginUserData.first_name,
											user1_last_name:loginUserData.last_name,
											user2_first_name:patnerData.first_name,
											user2_last_name:patnerData.last_name
										}
										res.send({
											status: 200,
											result: currentGoalData,
										});
									} 
									else {
										res.send({
											status: 400,
											message: "partner is not found"
										})
									}
								})
							} else {
								res.send({
									status: 400,
									message: "user is not found"
								})
							}
						})
					} else {
						res.send({
							status: 504,
							message: "Something went wrong please try after some time."
						})
					}
				}
			});
		}
		if(err) {
			res.send({
				status: 400,
				message: "Something Went Wrong"
			})
		}
	})
});

// Get monthly goal history
router.get('/getmonthlygoalhistory/:user_id', verifyToken, function(req, res, next) {

	let user_id  = req.params.user_id;
	if(!user_id) 
	{
		return res.send({
			status: 400,
			message: 'Goal Id is required.',
		});
	}

	if(!formValidator.isInt(user_id))   
	{
		return res.send({
			status: 400,
			message: 'Please enter a valid goal id.',
		});
	}

	goalSerObject.getAllGoalsHistoryByUserID(user_id, function(err, goalHistoryData)
	{
		if(err)
		{
			res.send({
				status: 500,
				message: 'There was a problem finding the goal history.',
			});
		}
		else
		{
			if(goalHistoryData)
			{
				res.send({
					status: 200,
					message: goalHistoryData,
				});
			}
			else
			{
				res.send({
					status: 404,
					message: 'No goal history found.',
				});
			}
		}
	});
});

// Add Questionalries option from admin panel
router.post('/saveOptions', verifyToken, function(req, res) {
	let title = req.body.title;
	let question_id = req.body.question_id;
	if(!title) {
		res.send({
			status: 400,
			message: "Title is required"
		})
	}
	if(question_id) {
		res.send({
			status: 400,
			message: "Question Id is required"
		})
	}
	if(!formValidator.isInt(question_id))   
	{
		return res.send({
			status: 400,
			message: 'Please enter a valid Question Id.',
		});
	}
	goalSerObject.setQuestionOptions(title, question_id, function(err, Options) {
		if(err) {
			res.send({
				status: 400,
				messgae: "Something went wrong!"
			})
		} else {
			if(Options) {
				res.send({
					status: 200,
					message: "Options save successfully",
					result: Options
				})
			} else {
				res.send({
					status: 504,
					messgae: "option is not saved"
				})
			}
		}
	})
})

// Get Questionaries option
router.get('/getOption', verifyToken, function(req, res) {
	goalSerObject.GetQuestionOption(function(err, GetOptions) {
		if(GetOptions) {
			res.send({
				status: 200,
				result: GetOptions
			})
		}
		if(err) {
			res.send({
				status: 400,
				messgae: "Something went wrong!"
			})
		}
	})
})

router.post('/saveQuestionaries', verifyToken, function(req, res) {
	let question_title = req.body.question_title;
	let question_descripation = req.body.question_descripation;
	let iscustom = req.body.iscustom;
	if(!question_title) {
		res.send({
			status: 400,
			message: "Question Title is required"
		})
	}
	if(!question_descripation) {
		res.send({
			status: 400,
			message: "Quetion descripation is required"
		})
	}
	let questions = {
		question_title: question_title,
		question_descripation: question_descripation,
		iscustom: iscustom
	}
	goalSerObject.saveQuestionaries(questions, function(err, response) {
		if(err) {
			res.send({
				status: 400,
				messgae: "Something went Wrong!"
			})
		} else {
			if(response) {
				res.send({
					status:200,
					message: "Question save successfully",
					result: response
				})
			}
		}
	})
})
router.get('/CheckQuetionariesFlag', verifyToken, function(req, res) {
	let user_id  = jwt.decode(req.headers['x-access-token']).id;
	if(!user_id) {
		return res.send({
			status: 400,
			message: 'User id is required.',
		});
	}
	goalSerObject.getPartnerData(user_id, function(err, partnerMappingData) 
	{
		if(err) {
			res.send({
				status: 500,
				message: 'something went wrong',
			});
		} else {
			if(partnerMappingData) {
				userSerObject.getUserById(partnerMappingData.partner_two_id, function(err, partenerData) {
					if(err) {
						res.send({
							status: 400,
							message: 'Invalid partner id provided',
						});
					} else {
						if(partenerData) {
							setTimeout(() => {
								if(partenerData.stage === 7) {
									res.send({
										status: 400,
										message: 'Please Wait, Your partner is already working on questionaries',
									});
								} else {
									userSerObject.updateUserStage(7, user_id, function(err, updatestageData) {
										if(updatestageData) {
											res.send({
												status: 200,
												message: 'Sucessfully enter questionaries page',
												stage: updatestageData.stage
											})
										} else {
											res.send({
												status: 400,
												message: 'Something Went wrong',
											})
										}
									})
								}
							}, 1000)
						} else {
							res.send({
								status: 504,
								message: "Partner is not found"
							})
						}
					}
				});
			} else {
				res.send({
					status: 504,
					messgae: "something went wrong"
				})
			}

		}
	});
})

// Update goal setting detail
router.put('/updateGoalSetting/', verifyToken, function(req, res) {
	let user_id     = jwt.decode(req.headers['x-access-token']).id;

	// if(!answer) 
	// {
	// 	return res.send({
	// 		status: 400,
	// 		message: 'Answer is required',
	// 	});
	// }
	//Check goal exists or not

	req.body.map(response => {
		// Check setting question exists or not
		goalSerObject.getGoalSettingsQuestionById(response.question_id, function(err, goalQuestionData) 
		{
			if(err)
			{
				res.send({
					status: 500,
					message: 'something went wrong',
				});
			}
			else
			{
				if(goalQuestionData) 
				{
					let goalSettingData = {
						'question_id': response.question_id,
						'answer': response.answer,
						'user_id': user_id,
						'id': response.question_answer_id,
						'custom_answer': response.custom_answer ? response.custom_answer : null
					};
					goalSerObject.updatesetting(goalSettingData, function(err, goalSettingDataupdated)
					{
						if(err)
						{
							res.send({
								status: 400,
								message: 'something went wrong',
							});
						}
						else
						{
							if(goalSettingDataupdated) {
								res.send({
									status: 200,
									message: 'updated sucessfully',
								});
							} else {
								res.send({
									status: 504,
									message: "Something went wrong"
								})
							}
						}
					});
				}
				else
				{
					return res.send({
						status: 400,
						message: 'No goal setting found',
					});
				}
			}
		});
	})
});

// Update Complete goal count
router.put('/updateCompletedGoal', verifyToken, function(req,res) {
	let user_id = jwt.decode(req.headers['x-access-token']).id;
	let answer1 = req.body.didYouConnectLastNight;
	let answer2 = req.body.WhoInitiative;
	if(!answer1) 
	{
		return res.send({
			status: 400,
			message: 'Please select an option for continue.',
		});
	}
	userSerObject.getPartnerById(user_id, function(err, partner_data) {
		if(err) {
			res.send({
				status:400,
				message: "something went wrong!"
			})
		} else {
			if(partner_data) {
				goalSerObject.getGoalDetails(user_id, partner_data.id, function(err, monthly_goal_data) {
					if(err) {
						res.send({
							status:400,
							message: "something went wrong!"
						})
					} else {
						if(monthly_goal_data) {
							goalSerObject.getPartnerData(user_id, function(err, patner_mapping_data) {
								if(err) {
									res.sendF({
										status: 400,
										message: "something went wrong"
									})
								} else {
									if(patner_mapping_data) {
										if(answer1 === "true") {
											if(!answer2)
											{
												return res.send({
													status: 400,
													message: 'Please select an option for continue.',
												});
											}
											let userID ;
											if(answer2 === "true") {
												userID = user_id;
											} else {
												userID = partner_data.id
											}
											let comepletion_goal = {
												user_id: userID,
												goal_id: monthly_goal_data.id,
												partner_mapping_id: patner_mapping_data.id,
												didYouConnectLastNight: answer1,
												WhoInitiative: answer2
											}
											let completeData = {
												id: monthly_goal_data.id,
												complete_count: parseInt(monthly_goal_data.complete_count) + 1,
												contribution1: monthly_goal_data.user_id === user_id ? parseInt(monthly_goal_data.contribution1) + 1 : parseInt(monthly_goal_data.contribution1),
												contribution2: monthly_goal_data.user_id === user_id ? parseInt(monthly_goal_data.contribution2) : parseInt(monthly_goal_data.contribution2) +1,
											}
											goalSerObject.updateCompleteCount(completeData, function(err, update_monthly_data) {
												if(err) {
													res.send({
														status:400,
														message: err
													})
												} else {
													if(update_monthly_data) {
														completionSerObject.saveCompletionGoal(comepletion_goal, function(err, save_data) {
															if(err) {
																res.send({
																	status: 504,
																	message: "something Went Wrong"
																})
															} else {
																if(save_data) {
																	res.send({
																		status: 200,
																		message: "Update successfully"
																	})
																} else {
																	res.send({
																		status: 504,
																		message: "something Went Wrong"
																	})
																}
															}
														})
													} else {
														res.send({
															status: 504,
															message: "something Went Wrong"
														})
													}
												}
											})
										} else {
											res.send({
												status: 200,
												message: "You did not connect last night"
											})
										}
									} else {
										res.send({
											status: 504,
											message: "Something went wrong! please try again."
										})
									}
								}
								})
						} else {
							res.send({
								status: 400,
								message: "Goal is not found. please setup a goal first."
							})
						}
					}
				})
			} else {
				res.send({
					status: 504,
					message: "partner is not found"
				})
			}
		}
	})

})

router.get('/previousMonthlyGoal', verifyToken, function(req, res) {
	let user_id = jwt.decode(req.headers['x-access-token']).id;

	userSerObject.getPartnerById(user_id, function(err, partner_data) {
		if(err) {
			res.send({
				status:400,
				message: "something went wrong!"
			})
		} else {
			if(partner_data) {
				goalSerObject.GetPreviousMonthyGoalById(user_id, partner_data.id, function(err, previous_monthly_goal_data) {
					if(err) {
						res.send({
							status:400,
							message: "something went wrong!"
						})
					} else {
						userSerObject.getUserById(user_id, function(err, userdata) {
							if(err) {
								res.send({
									status:400,
									message: "User is not found."
								})
							} else {
								if(userdata) {
									userSerObject.getPartnerById(user_id, function(err, patnerData) {
										if(patnerData) {
											if(previous_monthly_goal_data) {
												let dashboard = {
													connect_number: previous_monthly_goal_data.connect_number,
													initiator_count1: previous_monthly_goal_data.user_id === user_id ? previous_monthly_goal_data.initiator_count : previous_monthly_goal_data.initiator_count1,
													initiator_count2: previous_monthly_goal_data.user_id === user_id ? previous_monthly_goal_data.initiator_count1 : previous_monthly_goal_data.initiator_count ,
													complete_count: previous_monthly_goal_data.complete_count,
													contribution1: previous_monthly_goal_data.user_id === user_id ? previous_monthly_goal_data.contribution1 : previous_monthly_goal_data.contribution2 ,
													contribution2: previous_monthly_goal_data.user_id === user_id ? previous_monthly_goal_data.contribution2 : previous_monthly_goal_data.contribution1 ,
													patner1_user_id: userdata.id,
													patner1_first_name:userdata.first_name,
													patner1_last_name:userdata.last_name,
													patner1_gender: userdata.gender,
													patner1_profile_image: userdata.profile_image ? `${config.site_url}profile_images/${userdata.profile_image}`: null,
													patner2_user_id: patnerData.id,
													patner2_first_name:patnerData.first_name,
													patner2_last_name:patnerData.last_name,
													patner2_gender: patnerData.gender,
													patner2_profile_image: patnerData.profile_image ? `${config.site_url}profile_images/${patnerData.profile_image}`: null
												}
												res.send({
													status:200,
													result:dashboard
												})
												} else {
													let dashboard = {
														connect_number: '0',
														initiator_count1: '0',
														initiator_count2: '0',
														complete_count: '0',
														contribution1: '0',
														contribution2: '0',
														patner1_user_id: userdata.id,
														patner1_first_name:userdata.first_name,
														patner1_last_name:userdata.last_name,
														patner1_gender: userdata.gender,
														patner1_profile_image: userdata.profile_image ? `${config.site_url}profile_images/${userdata.profile_image}`: null,
														patner2_user_id: patnerData.id,
														patner2_first_name:patnerData.first_name,
														patner2_last_name:patnerData.last_name,
														patner2_gender: patnerData.gender,
														patner2_profile_image: patnerData.profile_image ? `${config.site_url}profile_images/${patnerData.profile_image}`: null
													}
													res.send({
														status: 200,
														result: dashboard
													})
												}
											}
											if(err) {
												res.send({
													status:400,
													messgae: "partner is not found"
												})
											}
										})
								} else {
									res.send({
										status: 504,
										message: "User is not found"
									})
								}
							}
						})
					}
				})
			} else {
				res.send({
					status: 504,
					message: "partner is not found"
				})
			}
		}
	})

})

module.exports = router;
