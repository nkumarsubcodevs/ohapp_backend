// const cron = require("node-cron");

// let cron = {};

// exports.start = function start(time, callback) {
//   /// cron start
//   // insert
//   const id = 1;

//   cron[id] = cron.schedule(time, () => callback());

//   let monthend = new Date(2020 - 06 - 05);
//   let REMAINING = monthend.getDate() - new Date().getDate();
//   let remainingConnections = 10 - 1;
//   const final = Math.ceil(REMAINING / remainingConnections);

//   return id;
// };

// exports.stop = function stop(id) {
//   cron && cron[id].stop(); // cron stop by id
// };

const cron = require("node-cron");

let cron = {};

exports.start = function start(time, callback) {
  /// cron start
  // insert
  const id = 1;

  cron[id] = cron.schedule(time, () => callback());

  schedules = cron.schedule(
    `${parseInt(minutes)} ${hours} */${day} * *`,
    () => {
      // cron.schedule(`* * * * *`, (err, ress) => {
      let statusCheck = customHelper.check_notification_Mute(
        usersData.notification_mute_start,
        usersData.notification_mute_end
      );
      if (statusCheck) {
        res.send({
          status: 400,
          message: "Notificaiton is mute for some time.",
        });
      } else {
        goalSerObject.getGoalDetails(
          usersData.id,
          GetpatnerData.id,
          function (err, monthlyGoal_data) {
            if (err) {
              res.send({
                status: 404,
                message: "Something went wrong!",
              });
            } else {
              if (monthlyGoal_data) {
                var Startdate = new Date(
                  monthlyGoal_data.month_start
                ).getTime();
                var lastDay = new Date(monthlyGoal_data.month_end).getTime();
                var current_date = lastDay - Startdate;
                let remaing = current_date / (1000 * 3600 * 24);
                let PR;
                if (monthlyGoal_data.complete_count == 0) {
                  PR = 0;
                } else {
                  PR =
                    (monthlyGoal_data.complete_count /
                      monthlyGoal_data.connect_number) *
                    100;
                }
                let Notificationmessage = {
                  PR: PR.toFixed(2),
                  remaing_days: remaing,
                };
                notificationObject.notification(
                  usersData.fcmid,
                  Notificationmessage,
                  function (err, response) {
                    let notification1 = {
                      user_id: usersData.id,
                      goal_id: monthlyGoalDataSaved.id,
                      device_id: usersData.fcmid,
                      notification_id: response.results[0].message_id,
                    };
                    notificationObject.saveNotification(
                      notification1,
                      function (err, response) {}
                    );
                  }
                );
                notificationObject.notification(
                  GetpatnerData.fcmid,
                  Notificationmessage,
                  function (err, response) {
                    let notification1 = {
                      user_id: GetpatnerData.id,
                      goal_id: monthlyGoalDataSaved.id,
                      device_id: GetpatnerData.fcmid,
                      notification_id: response.results[0].message_id,
                    };
                    notificationObject.saveNotification(
                      notification1,
                      function (err, response) {}
                    );
                  }
                );
              }
            }
          }
        );
      }
    }
  );

  return id;
};

exports.stop = function stop(id) {
  cron && cron[id].stop(); // cron stop by id
};
