
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

	async notification(notificationData, GoalData,  callback) {
		let re = notificationData
		console.log(GoalData)
		var message = { //this may vary according to the message type (single recipient, multicast, topic, et cetera)
			to: re, 
			notification: {
				title: 'Dating', 
				body: `You are at ${GoalData.PR}% of goal with ${GoalData.remaing_days} days left in the month.
Would you like to make a connection tonight?`
			},
			data: {  //you can send only notification or only data(or include both)
				type: 'remember'
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

	async SendFeedbacknotification(notificationData, Quicky_id, callback) {
		let re = notificationData
		var message = { //this may vary according to the message type (single recipient, multicast, topic, et cetera)
			to: re, 
			notification: {
				title: 'Feedback of last night', 
				body: 'Did you connect last night? ' 
			},
			data: {  //you can send only notification or only data(or include both)
				type: 'feedback',
				id: Quicky_id
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

	async getNotificationById(id, callback) {
		let response = await GoalNotification.findOne({where: { id: id, status: 1}, order : [['create_time', 'DESC']]});
		callback(null, response)
	}

	async updateNotificationStage(notification, stage, callback) {
		const now = new Date();
		GoalNotification.update({
			stage:  stage,
			update_time: current_datetime.format(now, 'YYYY-MM-DD hh:mm:ss'
		)},
		{
			where: {
				notification_id: notification
			}
		}).then(async res => {
			let response = await GoalNotification.findOne({where: {notification_id: notification, status: 1}});
			callback(null, response)
		}).catch(err => {
			callback(err, null)
		})
	}
}

module.exports = NotificationService;
