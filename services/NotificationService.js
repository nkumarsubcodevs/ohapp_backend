
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
const notification = require("../models/notifications");


var fcm = new FCM(config.firebase_server_key);
class NotificationService {

	// Save Notification
	async saveNotification(data, callback) {
		const now = new Date();

		let response = new GoalNotification({
			goal_id: data.goal_id,
			user_id: data.user_id,
			device_id: data.device_id,
			status: 1,
			stage: 1,
			notification_id: data.notification_id,
			create_time: current_datetime.format(now, 'YYYY-MM-DD hh:mm:ss'),
			update_time: current_datetime.format(now, 'YYYY-MM-DD hh:mm:ss')
		})
		callback(null, await response.save())
	}

	// insert notification data
	async addnotification(notificationdata, callback) {
		const now = new Date();
		let response = new notification({
			user_id: notificationdata.user_id,
			quickey_id: notificationdata.quickey_id,
			title: notificationdata.title,
			message: notificationdata.message,
			type: notificationdata.type,
			status: 1,
			checkans: notificationdata.checkans,
			create_time: current_datetime.format(now, 'YYYY-MM-DD hh:mm:ss'),
			update_time: current_datetime.format(now, 'YYYY-MM-DD hh:mm:ss')
		})
		callback(null, await response.save())
	}

	// insert notification quikie
	async addnotificationquikcy(user_id, callback) {
		const now = new Date();
		let response = new notification({
			user_id: user_id,
			title: "OPTIMIZE | HARMONIZE0",
			message: "You have an alert from Oh!. Log in to respond…",
			type: "feedback",
			status: 1,
			create_time: current_datetime.format(now, 'YYYY-MM-DD hh:mm:ss'),
			update_time: current_datetime.format(now, 'YYYY-MM-DD hh:mm:ss')
		})
		callback(null, await response.save())
	}

	// Send Reminder notification
	async notification(notificationData, GoalData, Check, response, quickey_id, callback) {

		let re = notificationData

		var message = {
			to: re,
			priority: "high",
			notification: {
				title: 'OPTIMIZE | HARMONIZE',
				body: `You have an alert from Oh!. Log in to respond…`
			},
			data: {
				type: 'remember',
				Check: Check,
				notification_id: response,
				quickey_id: quickey_id,
			}
		};

		fcm.send(message, function (err, response) {
			if (err) {
				console.log("Something has gone wrong!", err);
			} else {
				callback(null, JSON.parse(response));
			}
		});
	}

	// Send feedback notification
	async Sendnotification(notificationId, NotifacationData, response, quickey_id, callback) {
		let re = notificationId
		var message = {
			to: re,
			priority: "high",
			notification: {
				title: 'OPTIMIZE | HARMONIZE',
				body: `You have an alert from Oh!. Log in to respond…`,
				notification_id: NotifacationData.notification_id,
				quicky_id: NotifacationData.quickey_id
			},
			data: {
				type: NotifacationData.type,
				notification_id: response,
				Quicky_id: quickey_id
			}
		};
		fcm.send(message, function (err, response) {
			if (err) {
				console.log("Something has gone wrong!", err);
			} else {
				callback(null, JSON.parse(response));
			}
		});
	}

	// send notification for tracker
	async Sendnotificationfortracker(partner_data, data1, callback) {
		let fcmtoken = partner_data
		let data = {
			to: fcmtoken,
			title: "You have an alert from Oh!. Log in to respond…",
			message: ``,
			type: "",
		}

		fcm.send(data, function (err, response) {
			if (err) {
				console.log("Something has gone wrong!", err);
			} else {
				callback(null, JSON.parse(response));
			}
		});
	}


	// Update notification
	async updateNotification(id, answer, callback) {
		const now = new Date();
		GoalNotification.update({ answer: answer, update_time: current_datetime.format(now, 'YYYY-MM-DD hh:mm:ss') }, { where: { notification_id: id } });
		let response = await GoalNotification.findOne({ where: { notification_id: id, status: 1 } });
		if (response.answer === answer) {
			callback(null, response);
		} else {
			this.updateNotification(id, answer, callback);
		}
	}

	// Get notification By User ID
	async getNotification(id, callback) {
		let response = await GoalNotification.findOne({ where: { user_id: id, status: 1 }, order: [['create_time', 'DESC']] });
		callback(null, response)
	}

	//updatesavenotifications
	async updatesaveNotification(id, callback) {
		const now = new Date();
		let response = await notification.update({ status: "2", update_time: now }, { where: { id: id } })
		callback(null, response)
	}

	// Get Notification By Id
	async getNotificationById(id, callback) {
		let response = await GoalNotification.findOne({ where: { id: id, status: 1 }, order: [['create_time', 'DESC']] });
		callback(null, response)
	}

	//get 20 latest notification data
	async getNotificationData(user_id, callback) {
		const response = await notification.findAll({ where: { user_id: user_id }, order: [['create_time', 'DESC']], limit: 20 });
		callback(null, response);
	}

	// get the notification all data for seen or unseen
	async getnotificationseenorunseen(id, callback) {
		const response = await notification.findAll({ where: { id: id }, order: [['create_time', 'DESC']] });
		callback(null, response);
	}

	//get the unseen notification data
	async getNotificationunseenData(user_id, callback) {
		const response = await notification.findAll({ where: { user_id: user_id }, order: [['create_time', 'DESC']], limit: 20 });
		let length = response.filter(res => res.status == 1);
		callback(null, length);
	}

	// save notification data
	async savenotificationdata(user_id, quickey_id, title, message, type, status, checkans, callback) {
		const now = new Date();
		let data = new notification({
			user_id: user_id,
			quickey_id: quickey_id,
			title: title,
			message: message,
			type: type,
			status: status,
			checkans: checkans,
			create_time: current_datetime.format(now, "YYYY-MM-DD hh:mm:ss"),
			update_time: current_datetime.format(now, "YYYY-MM-DD hh:mm:ss"),

		})

		await data.save()
			.then(res => {
				callback(null, res);
			}).catch(err => {
				callback(err.message, null);
			})
	}

	// Update Notifacation Stage
	async updateNotificationStage(notification, stage, callback) {
		const now = new Date();
		GoalNotification.update({
			stage: stage,
			update_time: current_datetime.format(now, 'YYYY-MM-DD hh:mm:ss'
			)
		},
			{
				where: {
					notification_id: notification
				}
			}).then(async res => {
				let response = await GoalNotification.findOne({ where: { notification_id: notification, status: 1 } });
				callback(null, response)
			}).catch(err => {
				callback(err, null)
			})
	}
}

module.exports = NotificationService;
