/** 
  * @desc this file will contains the routes for goals api
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file goals.js
*/

const express = require('express');
const goalService = require('../../services/GoalService');
const userService = require('../../services/UserService');
const formValidator = require('validator');

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

module.exports = router;
