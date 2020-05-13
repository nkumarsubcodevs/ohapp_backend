
/** 
  * @desc this service file will define all the functions related to the goal
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file GoalService.js
*/

var FCM = require('fcm-node');
// Get API secret
const config = require('../config/config');
const GoalNotification = require('../models/goal_notification');
const current_datetime = require('date-and-time');

var fcm = new FCM(config.firebase_server_key);
class NotificationService
{

	async saveNotification(data, callback) {
		const now = new Date();

		let response = new GoalNotification({
			goal_id:data.goal_id,
			user_id:data.user_id,
			device_id: data.device_id,
			status:1,
			stage:1,
			notification_id:data.notification_id,
			create_time: current_datetime.format(now, 'YYYY-MM-DD hh:mm:ss'),
			update_time: current_datetime.format(now, 'YYYY-MM-DD hh:mm:ss')
		})
		callback(null, await response.save())
	}

	async notification(notificationData, callback) {
		let re = notificationData
		var message = { //this may vary according to the message type (single recipient, multicast, topic, et cetera)
			to: re, 
			notification: {
				title: 'Dating', 
				body: 'Do you want to set plan of dating for tonight' 
			},
			data: {  //you can send only notification or only data(or include both)
				my_key: 'my value',
				my_another_key: 'my another value'
			}
		};
		fcm.send(message, function(err, response){
			if (err) {
				console.log("Something has gone wrong!", err);
			} else {
				callback(null, JSON.parse(response));
			}
		});
	}

	async updateNotification(id, answer, callback) {
		const now = new Date();
		GoalNotification.update({answer:  answer, update_time: current_datetime.format(now, 'YYYY-MM-DD hh:mm:ss') }, { where: { notification_id: id }});
		let response = await GoalNotification.findOne({where: {notification_id: id, status: 1}});
		if(response.answer === answer) {
			callback(null, response);
		} else {
			this.updateNotification(id, answer, callback);
		}
	}

	async getNotification(id, callback) {
		let response = await GoalNotification.findOne({where: { user_id: id, status: 1}, order : [['create_time', 'DESC']]});
		callback(null, response)
	}

	async updateNotificationStage(id, stage, callback) {
		const now = new Date();
		GoalNotification.update({stage:  stage, update_time: current_datetime.format(now, 'YYYY-MM-DD hh:mm:ss') }, { where: { notification_id: id }}) 
		let response = await GoalNotification.findOne({where: {notification_id: id, status: 1}});
		if(response.stage == stage) {
			callback(null, response);
		} else {
			this.updateNotificationStage(id, stage, callback);
		}
	}
}

module.exports = NotificationService;
