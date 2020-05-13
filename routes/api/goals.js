/** 
  * @desc this file will contains the routes for goals api
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file goals.js
*/

const express = require('express');
const goalService = require('../../services/GoalService');
const notificationService = require('../../services/notification');
const userService = require('../../services/UserService');
const customHelper = require('../../helpers/custom_helper');
const formValidator = require('validator');
const current_datetime = require('date-and-time');
var cron = require('node-cron');
const jwt = require('jsonwebtoken')
// verifytoken middleware
const verifyToken = require('./verifytoken');

// Create route object
let router =  express.Router();

// Create goal model object
var goalSerObject = new goalService();

// Create user model object
var userSerObject = new userService();

var notificationObject = new notificationService();

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
					res.send({
						status: 200,
						settings: GetquestionWithOption,
					});
				})
			}
			else
			{
				res.send({
					status: 404,
					message: 'No Question found.',
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
					res.send({
						status: 200,
						settings: GetquestionWithOption,
					});
				})
			}
			else
			{
				res.send({
					status: 404,
					message: 'No Question found.',
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
	//Check goal exists or not
	goalSerObject.getGoalByUserId(user_id, function(err, goalGetData) 
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
			if(goalGetData) 
			{
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
								goalSerObject.getGoalSettingByPatnerMappingId(goalGetData[0].partner_mapping_id, response.question_id, function(err, goalQuestionAnswerData) 
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
										// if(goalQuestionAnswerData) 
										// {
										// 	let goalSettingData = {
										// 		'goal_id': goalGetData[0].id,
										// 		'question_id': response.question_id,
										// 		'answer': response.answer,
										// 		'patner_mapping_id': goalGetData[0].partner_mapping_id,
										// 		'user_id': user_id,
										// 		'id': goalQuestionAnswerData.id,
										// 		'custom_answer': response.custom_answer ? response.custom_answer : null
										// 	};
										// 	goalSerObject.updatesetting(goalSettingData, function(err, goalSettingDataupdated)
										// 	{
										// 		if(err)
										// 		{
										// 			res.send({
										// 				status: 500,
										// 				message: 'something went wrong',
										// 			});
										// 		}
										// 		else
										// 		{
										// 			res.send({
										// 				status: 200,
										// 				message: 'Saved sucessfully',
										// 			});
										// 		}
										// 	});
										// } else {
												let goalSettingData = {
													'goal_id': goalGetData[0].id,
													'question_id': response.question_id,
													'answer': response.answer,
													'patner_mapping_id': goalGetData[0].partner_mapping_id,
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
																}
																if(patnerData) {
																	userSerObject.updateUserStage(7, patnerData.id, function(err, updatPatnerStage){
																		if(updatPatnerStage) {
																			res.send({
																				status:200,
																				message: "Success",
																				user_stage: updatedStage.stage,
																				patner_Stage: updatPatnerStage.stage
																			})
																		}
																	})
																}
															} )
														}

													})
												}
											});
										// }
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
			}
			else
			{
				return res.send({
					status: 400,
					message: 'No goal found',
				});
			}
		}
	});
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
			message: 'Unique Id is required.',
		});
	}

	if(!formValidator.isAlpha(unique_code))   
	{
		return res.send({
			status: 400,
			message: 'Please enter a valid unique id.',
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
											}
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
											}
										});
									}
									else
									{
										userSerObject.updateUserStage(3, user_id, function(err, userStageupdatedata) {});
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
														}
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
																	userSerObject.updateUserStage(4, monthlyGoalData.partner_two_id, function(err, responses){})
																	if(userStageupdatedata) {
																		return res.send({
																			status: 200,
																			message: 'Paring sucessfully',
																			stage: userStageupdatedata.stage,
																			FCMID: uniqueCodeData.fcmid
																		})
																	}
																});
																// }
															}
														}
													});
												}
												else
												{
													return res.send({
														status: 400,
														message: 'Unable to add monthly goal.',
													});
												}
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
								message: 'No security code found',
							});
						}
					}
				});
			}
			else
			{
				return res.send({
					status: 400,
					message: 'No user found',
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
				res.send({
					status: 200,
					partnerMappingData: partnersData,
				});
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
					}
					if(partenerData) {
						if(partenerData.stage === 5) {
							res.send({
								status: 400,
								message: 'Please Wait, Your partner is already setting goal',
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
											}
											if(GetpatnerData) {
												userSerObject.updateUserStage(6, user_id, function(err, updatedStage) {
													if(updatedStage) {
														userSerObject.getPartnerById(user_id, function(err, patnerData) {
															if(err) {
																res.send({
																	status: 400,
																	message: "something went wrong"
																})
															}
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
																	var date = new Date();
																	var month = date.getMonth() + 1;
																	var year = date.getFullYear();
																	let day = new Date(year, month, 0).getDate() / monthlyGoalDataSaved.connect_number
																	cron.schedule(`${parseInt(minutes)} ${hours} */${day} * *`, () => {
																		// cron.schedule(`*,1,2,4 * * * *`, () => {
																			notificationObject.notification(updateedstage.fcmid, function(err, response) {
																				let notification1 = {
																					user_id: updateedstage.id,
																					goal_id: monthlyGoalDataSaved.id,
																					device_id: updateedstage.fcmid,
																					notification_id: response.results[0].message_id,
																				}
																				notificationObject.saveNotification(notification1, function(err, response) {})
																			})
																			notificationObject.notification(GetpatnerData.fcmid, function(err, response) {
																				let notification1 = {
																					user_id: GetpatnerData.id,
																					goal_id: monthlyGoalDataSaved.id,
																					device_id: updateedstage.fcmid,
																					notification_id: response.results[0].message_id,
																				}
																				notificationObject.saveNotification(notification1, function(err, response) {})
																			})
																	});
																	if(updateedstage) {
																		res.send({
																			status: 200,
																			message: 'The monthly goal has been created.',
																			stage: updateedstage.stage,
																			fcmid: GetpatnerData.fcmid,
																			Patner1_first_name: updateedstage.first_name,
																			Patner1_last_name: updateedstage.last_name,
																			patner1_stage: updateedstage.stage,
																			Patner2_first_name:GetpatnerData.first_name,
																			Patner2_last_name:GetpatnerData.last_name,
																			patner2_stage: GetpatnerData.stage
																		});
																	}
																})
															}
														} )
													}

												})
											}
										})
									}
								});
							}
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
		} 
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
							}
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
											messgae: "PAring is not save successfully",
											user_stage: userDetails.stage
										})
									}
									if(userDetails.stage > 4) {
										res.send({
											status:200,
											user_stage: userDetails.stage,
											patner_stage:partenerData.stage
										})
									}
							}
						});
					}
		
				}
			});
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
							res.send({
								status: 200,
								message: 'The monthly goal has been updated.',
							});
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

	// if(!formValidator.isInt(partner_mapping_id))   
	// {
	// 	return res.send({
	// 		status: 400,
	// 		message: 'Please enter a valid goal id.',
	// 	});
	// }
	goalSerObject.getPartnerData(user_id, function(err, patnerData) {
		if(patnerData) {
					// if(partnerData)
					// {
						goalSerObject.getGoalDetails(patnerData.id, user_id, function(err, goalCompleteData)
						{
							if(err)
							{
								res.send({
									status: 500,
									message: 'There was a problem finding the goal.',
								});
							}
							else
							{
								res.send({
									status: 200,
									result: goalCompleteData,
								});
							}
						});
					// }
					// else
					// {
					// 	res.send({
					// 		status: 404,
					// 		message: 'No goal found.',
					// 	});
					// }
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
		if(Options) {
			res.send({
				status: 200,
				message: "Options save successfully",
				result: Options
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
		}
		if(response) {
			res.send({
				status:200,
				message: "Question save successfully",
				result: response
			})
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
					}
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
					}
				});
			}

		}
	});
})

// Update goal setting detail
router.put('/updateGoalSetting/:goal_id', verifyToken, function(req, res) {
	let user_id     = jwt.decode(req.headers['x-access-token']).id;
	let goal_id     = req.params.goal_id;

	if(!goal_id) 
	{
		return res.send({
			status: 400,
			message: 'Goal Id is required as params.',
		});
	}

	if(!formValidator.isInt(goal_id))   
	{
		return res.send({
			status: 400,
			message: 'Please enter a valid goal id.',
		});
	}

	// if(!answer) 
	// {
	// 	return res.send({
	// 		status: 400,
	// 		message: 'Answer is required',
	// 	});
	// }
	//Check goal exists or not
	goalSerObject.getGoalByUserId(user_id, function(err, goalGetData) 
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
			if(goalGetData) 
			{
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
								goalSerObject.getGoalSettingByPatnerMappingId(goalGetData[0].partner_mapping_id, response.question_id, function(err, goalQuestionAnswerData) 
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
										if(goalQuestionAnswerData) 
										{
											let goalSettingData = {
												'goal_id': goal_id,
												'question_id': response.question_id,
												'answer': response.answer,
												'patner_mapping_id': goalGetData[0].partner_mapping_id,
												'user_id': user_id,
												'id': goalQuestionAnswerData.id,
												'custom_answer': response.custom_answer ? response.custom_answer : null
											};
											goalSerObject.updatesetting(goalSettingData, function(err, goalSettingDataupdated)
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
													res.send({
														status: 200,
														message: 'Saved sucessfully',
													});
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
									message: 'No goal setting found',
								});
							}
						}
					});
				})
			}
			else
			{
				return res.send({
					status: 400,
					message: 'No goal found',
				});
			}
		}
	});
});
module.exports = router;
