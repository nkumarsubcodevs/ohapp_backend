/**
 * @desc this service file will define all the functions related to the goal
 * @author Navneet Kumar navneet.kumar@subcodevs.com
 * @file GoalService.js
 */

var FCM = require("fcm-node");
// Get API secret
const config = require("../config/config");
const GoalNotification = require("../models/goal_notification");
const current_datetime = require("date-and-time");

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
      create_time: current_datetime.format(now, "YYYY-MM-DD hh:mm:ss"),
      update_time: current_datetime.format(now, "YYYY-MM-DD hh:mm:ss"),
    });
    callback(null, await response.save());
  }

  // Send Reminder notification
  async notification(notificationData, GoalData, callback) {
    let re = notificationData;
    var message = {
      to: re,
      notification: {
        title: "Dating",
        body: `You are at ${GoalData.PR}% of goal with ${GoalData.remaing_days} days left in the month.
Would you like to make a connection tonight?`,
      },
      data: {
        type: "remember",
      },
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
  async Sendnotification(notificationId, NotifacationData, callback) {
    let re = notificationId;
    var message = {
      to: re,
      notification: {
        title: NotifacationData.title,
        body: NotifacationData.message,
      },
      data: {
        type: NotifacationData.type,
        Quicky_id: NotifacationData.quicky_id,
      },
    };
    fcm.send(message, function (err, response) {
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
    GoalNotification.update(
      { answer: answer, update_time: current_datetime.format(now, "YYYY-MM-DD hh:mm:ss") },
      { where: { notification_id: id } }
    );
    let response = await GoalNotification.findOne({ where: { notification_id: id, status: 1 } });
    if (response.answer === answer) {
      callback(null, response);
    } else {
      this.updateNotification(id, answer, callback);
    }
  }

  // Get notification By User ID
  async getNotification(id, callback) {
    let response = await GoalNotification.findOne({
      where: { user_id: id, status: 1 },
      order: [["create_time", "DESC"]],
    });
    callback(null, response);
  }

  // Get Notification By Id
  async getNotificationById(id, callback) {
    let response = await GoalNotification.findOne({ where: { id: id, status: 1 }, order: [["create_time", "DESC"]] });
    callback(null, response);
  }

  // Update Notifacation Stage
  async updateNotificationStage(notification, stage, callback) {
    const now = new Date();
    GoalNotification.update(
      {
        stage: stage,
        update_time: current_datetime.format(now, "YYYY-MM-DD hh:mm:ss"),
      },
      {
        where: {
          notification_id: notification,
        },
      }
    )
      .then(async (res) => {
        let response = await GoalNotification.findOne({ where: { notification_id: notification, status: 1 } });
        callback(null, response);
      })
      .catch((err) => {
        callback(err, null);
      });
  }
}

module.exports = NotificationService;
