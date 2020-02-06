
/** 
  * @desc this service file will define all the functions related to the chat message
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file MessageService.js
*/

const messageObject = require('../models/messages');
const current_datetime = require('date-and-time');

class MessageService
{
	// Save Chat Message
	async saveChatMessage(messageData, callback){

		const now = new Date();
		
		let msgData = new messageObject({
			goal_id: messageData.goal_id,
			sender_id: messageData.sender_id,
			receiver_id: messageData.receiver_id,
			message: messageData.message,
			chat_status_id : 1,
			create_time: current_datetime.format(now, 'YYYY-MM-DD hh:mm:ss'),
			update_time: current_datetime.format(now, 'YYYY-MM-DD hh:mm:ss')
		});

		callback(null,msgData.save());
	}
}

module.exports = MessageService;
