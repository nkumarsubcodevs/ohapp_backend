/** 
  * @desc this file will contains the routes for messages api
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file messages.js
*/

const express = require('express');
const current_datetime = require('date-and-time');
const formValidator = require('validator');
const path = require('path');

const messageService = require('../../services/MessageService');
const customHelper = require('../../helpers/custom_helper');

// Get API secret
const config      = require('../../config/config');

// verifytoken middleware
const verifyToken = require('./verifytoken');

// Create route object
let router =  express.Router();

// Create user model object
var msgSerObject = new messageService();

// Update profile image
router.post('/sendchatmessages', verifyToken, (req, res, next) => {

	let goal_id       = req.body.goal_id;
	let sender_id     = req.body.sender_id;
	let receiver_id   = req.body.receiver_id;
	let chat_message  = req.body.chat_message;

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

	if(!sender_id) 
	{
		return res.send({
			status: 400,
			message: 'Sender Id is required.',
		});
	}

	if(!formValidator.isInt(sender_id))   
	{
		return res.send({
			status: 400,
			message: 'Please enter a valid sender id.',
		});
	}

	if(!receiver_id) 
	{
		return res.send({
			status: 400,
			message: 'Receiver id is required.',
		});
	}

	if(!formValidator.isInt(receiver_id))   
	{
		return res.send({
			status: 400,
			message: 'Please enter a valid receiver id.',
		});
	}

	if(!chat_message) 
	{
		return res.send({
			status: 400,
			message: 'Message is required.',
		});
	}

	const now = new Date();

	var encoded_msg = customHelper.h_getChatMsgEncode(chat_message);
	
	let messageData = {
		'goal_id': goal_id,
		'sender_id': sender_id,
		'receiver_id': receiver_id,
		'message': encoded_msg,
		'create_time': current_datetime.format(now, 'YYYY-MM-DD hh:mm:ss'),
		'update_time': current_datetime.format(now, 'YYYY-MM-DD hh:mm:ss'),
	};
	
	msgSerObject.saveChatMessage(messageData, function(err, msgDataSaved)
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
				message: 'Chat message has been saved.',
			});
		}
	});
});

module.exports = router;