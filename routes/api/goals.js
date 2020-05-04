/** 
  * @desc this file will contains the routes for goals api
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file goals.js
*/

const express = require('express');
const goalService = require('../../services/GoalService');
const userService = require('../../services/UserService');
const customHelper = require('../../helpers/custom_helper');
const formValidator = require('validator');
const current_datetime = require('date-and-time');

// verifytoken middleware
const verifyToken = require('./verifytoken');

// Create route object
let router =  express.Router();

// Create goal model object
var goalSerObject = new goalService();

// Create user model object
var userSerObject = new userService();

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
				res.send({
					status: 200,
					settings: settingData,
				});
			}
			else
			{
				res.send({
					status: 404,
					message: 'No user found.',
				});
			}	
		}
	});
});

// Save user setting detail
router.post('/savegoalsettings', verifyToken, function(req, res) {

	let goal_id     = req.body.goal_id;
	let question_id = req.body.question_id;
	let answer      = req.body.answer;

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

	if(!question_id) 
	{
		return res.send({
			status: 400,
			message: 'Question Id is required.',
		});
	}

	if(!formValidator.isInt(question_id))   
	{
		return res.send({
			status: 400,
			message: 'Please enter a valid question id.',
		});
	}

	if(!answer) 
	{
		return res.send({
			status: 400,
			message: 'Answer is required',
		});
	}

	// Check goal exists or not
	goalSerObject.getGoalById(goal_id, function(err, goalGetData) 
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
				// Check setting question exists or not
				goalSerObject.getGoalSettingsQuestionById(question_id, function(err, goalQuestionData) 
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
								'goal_id': goal_id,
								'question_id': question_id,
								'answer': answer
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
									res.send({
										status: 200,
										message: 'Settings Saved',
									});
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

	let partner_mapping_id = req.body.partner_mapping_id;
	let user_id            = req.body.user_id;
	let connect_number     = req.body.connect_number;
	let percentage         = req.body.percentage;

	if(!partner_mapping_id) 
	{
		return res.send({
			status: 400,
			message: 'Partner Id is required.',
		});
	}

	if(!formValidator.isInt(partner_mapping_id))   
	{
		return res.send({
			status: 400,
			message: 'Please enter a valid partner mapping id.',
		});
	}

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

	if(!percentage) 
	{
		return res.send({
			status: 400,
			message: 'Percentage is required.',
		});
	}

	if(!formValidator.isInt(percentage))   
	{
		return res.send({
			status: 400,
			message: 'Please enter a valid percentage.',
		});
	}

	// Check goal exists or not
	goalSerObject.getPartnerById(partner_mapping_id, function(err, partnerMappingData) 
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
			if(partnerMappingData.status) 
			{
                // check if user-id is found or not in partner mapping table
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

					var initiator_count = customHelper.h_getNumberOfTimesPercentage(connect_number, percentage);
					var partner_percentage = 100 - percentage;
					var partner_initiator_count = connect_number - initiator_count;

					let monthlyGoalData = {
						'partner_mapping_id': partner_mapping_id,
						'user_id': user_id,
						'month_start': current_datetime.format(now, 'YYYY-MM-DD'),
						'month_end': customHelper.h_get30daysAdvanceDate(),
						'connect_number': connect_number,
						'percentage': percentage,
						'initiator_count': initiator_count,
						'status': 1,	
						'partner_id': parter_id,
						'partner_percentage': partner_percentage,
						'partner_initiator_count': partner_initiator_count,	
					};

					goalSerObject.createMonthlyGoal(monthlyGoalData, function(err, monthlyGoalDataSaved)
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
								message: 'The monthly goal has been created.',
							});
						}
					});
				}
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

// Update monthly goal
router.post('/updatemonthlygoal', verifyToken, function(req, res) {

	let goal_id            = req.body.goal_id;
	let connect_number     = req.body.connect_number;
	let percentage         = req.body.percentage;

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

	if(!percentage) 
	{
		return res.send({
			status: 400,
			message: 'Percentage is required.',
		});
	}

	if(!formValidator.isInt(percentage))   
	{
		return res.send({
			status: 400,
			message: 'Please enter a valid percentage.',
		});
	}

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
					const now = new Date();

					var initiator_count = customHelper.h_getNumberOfTimesPercentage(connect_number, percentage);
					
					let monthlyGoalData = {
						'goal_id': goal_id,
						'partner_mapping_id': goalData.partner_mapping_id,
						'user_id': goalData.user_id,
						'month_start': current_datetime.format(now, 'YYYY-MM-DD'),
						'month_end': customHelper.h_get30daysAdvanceDate(),
						'connect_number': connect_number,
						'percentage': percentage,
						'initiator_count': initiator_count,
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
router.get('/getmonthlygoaldetail/:partner_mapping_id', verifyToken, function(req, res, next) {

	let partner_mapping_id  = req.params.partner_mapping_id;
	
	if(!partner_mapping_id) 
	{
		return res.send({
			status: 400,
			message: 'Goal Id is required.',
		});
	}

	if(!formValidator.isInt(partner_mapping_id))   
	{
		return res.send({
			status: 400,
			message: 'Please enter a valid goal id.',
		});
	}

	goalSerObject.getPartnerById(partner_mapping_id, function(err, partnerData)
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
			if(partnerData)
			{	
				goalSerObject.getGoalDetails(partner_mapping_id, function(err, goalCompleteData)
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
			}
			else
			{
				res.send({
					status: 404,
					message: 'No goal found.',
				});
			}	
		}
	});
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

module.exports = router;
