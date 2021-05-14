/** 
  * @desc this file will contains the routes for pages api
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file pages.js
*/

const express = require('express');
const NotificationService = require('../../services/NotificationService');
const goalService = require('../../services/GoalService');
const userService = require('../../services/UserService');
const quickyService = require('../../services/QuickyService');
const jwt = require('jsonwebtoken');
const formValidator = require('validator');
const current_datetime = require('date-and-time');
const customHelper = require('../../helpers/custom_helper');

// verifytoken middleware
const verifyToken = require('./verifytoken');
const { Console } = require('console');
const { chocolate } = require('color-name');

// Create route object
let router = express.Router();

// Create notification model object
var notificationObject = new NotificationService();

// Create goal model object
var goalServiceObject = new goalService();

// Create user model object
var userServiceObject = new userService();

var quickyObject = new quickyService();
// Get single page content
router.get('/checkNotificationStage', verifyToken, function (req, res, next) {

  var user_id = jwt.decode(req.headers['x-access-token']).id;

  notificationObject.getNotification(user_id, function (err, pageData) {
    if (err) {
      res.send({
        status: 500,
        message: 'Please Wait! The quicky setup is already in progress by your partner.',
      });
    }
    else {
      if (pageData) {
        goalServiceObject.getPartnerData(user_id, function (err, patnerData) {
          if (err) {
            res.send({
              status: 400,
              message: "Something went wrong"
            })
          } else {
            if (patnerData) {
              notificationObject.getNotification(patnerData.partner_two_id, function (err, patner) {
                if (err) {
                  res.send({
                    status: 400,
                    message: "something went wrong"
                  })
                } else {
                  if (patner.stage == 1 && pageData.stage == 1) {
                    notificationObject.getNotificationById(pageData.id, function (err, notification1) {
                      if (err) {
                        res.send({
                          status: 400,
                          message: "Something went wrong!"
                        })
                      } else {
                        if (notification1) {
                          notificationObject.getNotificationById(patner.id, function (err, notification2) {
                            if (err) {
                              res.send({
                                status: 400,
                                message: "Something went wrong!"
                              })
                            } else {
                              if (notification2) {
                                if (notification2.stage == 1 && notification1.stage) {
                                  notificationObject.updateNotificationStage(pageData.notification_id, 2, function (err, updateStage) {
                                    if (updateStage) {
                                      res.send({
                                        status: 200,
                                        result: 'updateStage',
                                        user_stage: updateStage.stage,
                                        partner_stage: notification2.stage
                                      })
                                    } else {
                                      res.send({
                                        status: 504,
                                        message: "Something went wrong!"
                                      })
                                    }
                                  })
                                } else {
                                  res.send({
                                    status: 404,
                                    message: "something went wrong"
                                  })
                                }
                              } else {
                                res.send({
                                  status: 504,
                                  message: "Something went wrong!"
                                })
                              }
                            }
                          })
                        } else {
                          res.send({
                            status: 500,
                            message: "Something went wrong!"
                          })
                        }
                      }
                    })
                  } else if (patner.stage == 2 && pageData.stage == 1) {
                    res.send({
                      status: 200,
                      message: "Your patner is setting quicky",
                      user_stage: pageData.stage,
                      partner_stage: patner.stage
                    })
                  } else if (patner.stage == 3 && pageData.stage == 3) {
                    res.send({
                      status: 200,
                      message: "Quicky is saved successfully",
                      user_stage: pageData.stage,
                      partner_stage: patner.stage
                    })
                  } else {
                    notificationObject.updateNotificationStage(pageData.notification_id, 2, function (err, updateStage) {
                      if (updateStage) {
                        res.send({
                          status: 200,
                          result: 'updateStage',
                          user_stage: pageData.stage,
                          partner_stage: patner.stage
                        })
                      } else {
                        res.send({
                          status: 504,
                          message: "Something went wrong!"
                        })
                      }
                    })
                  }
                }
              })
            } else {
              res.send({
                status: 404,
                message: "partner is not found"
              })
            }
          }
        })
      }
      else {
        res.send({
          status: 404,
          message: 'Notification is not found',
        });
      }
    }
  });
});

router.post('/NotificationMute', verifyToken, function (req, res) {
  let user_id = jwt.decode(req.headers['x-access-token']).id;
  let start_time = req.body.start_time;
  let end_time = req.body.end_time;
  let mute_status = req.body.mute_status;

  if (!start_time) {
    return res.send({
      status: 400,
      message: 'Start Time is required',
    });
  }

  if (!end_time) {
    return res.send({
      status: 400,
      message: 'End Time is required',
    });
  }

  userServiceObject.getPartnerById(user_id, function (err, partnerData) {
    if (err) {
      res.send({
        status: 400,
        message: "Something Went Wrong!"
      })
    } else {
      if (partnerData) {
        let Data = {
          user_id: user_id,
          partner_id: partnerData.id,
          start_time: start_time,
          end_time: end_time,
          mute_status: mute_status
        }
        userServiceObject.UpdateNotificationMuteData(Data, function (err, UpdateNotificationMute) {
          if (err) {
            res.send({
              status: 400,
              message: "Something Went Wrong! Please try after some time"
            })
          } else {
            if (UpdateNotificationMute) {
              res.send({
                status: 200,
                message: "Notification mute successfuly."
              })
            } else {
              res.send({
                status: 500,
                message: "Something Went Wrong! Please try after some time"
              })
            }
          }
        })
      } else {
        res.send({
          status: 500,
          message: "Partner is not found"
        })
      }
    }
  })
})

router.get('/NotificationStatus', verifyToken, function (req, res) {
  let user_id = jwt.decode(req.headers['x-access-token']).id;

  userServiceObject.getUserById(user_id, function (err, UserData) {
    if (err) {
      res.send({
        status: 400,
        message: "Something went wrong!"
      })
    } else {
      if (UserData) {
        if (UserData.notification_mute_status) {
          // let Now = current_datetime.format(new Date, 'YYYY-MM-DD HH:mm:ss', true);
          // let end_time = new Date(UserData.notification_mute_end);
          // let start_time = new Date(UserData.notification_mute_start);
          // Now = new Date(Now);
          // if((Now.getTime() < end_time.getTime()) && (Now.getTime() > start_time.getTime())) {
          let statusCheck = customHelper.check_notification_Mute(UserData.notification_mute_start, UserData.notification_mute_end);
          if (statusCheck) {
            res.send({
              status: 200,
              result: true,
              message: "Notification is mute for some time"
            })
          } else {
            // }
            // } else {
            userServiceObject.getPartnerById(user_id, function (err, partnerData) {
              if (err) {
                res.send({
                  status: 400,
                  message: "Somwthing Went Wrong! Please try after some time"
                })
              } else {
                if (partnerData) {
                  let unmute = {
                    status: 0,
                    user_id: user_id,
                    partner_id: partnerData.id
                  }
                  userServiceObject.UpdateNotificationStatus(unmute, function (err, UpdatedData) {
                    if (err) {
                      res.send({
                        status: 400,
                        message: "Somwthing Went Wrong! Please try after some time"
                      })
                    } else {
                      if (UpdatedData) {
                        res.send({
                          status: 200,
                          result: false,
                          message: "Notification is Unmute"
                        })
                      } else {
                        res.send({
                          status: 400,
                          message: "Somwthing Went Wrong! Please try after some time"
                        })
                      }
                    }
                  })
                } else {
                  res.send({
                    status: 500,
                    message: "Partner is not found"
                  })
                }
              }
            })
          }
        } else {
          res.send({
            status: 200,
            result: false,
            message: "Notification is Unmute"
          })
        }
      } else {
        res.send({
          status: 500,
          message: "User is not found"
        })
      }
    }
  })
})

// check user intresr
router.post("/checkUserIntrest/:id", verifyToken, function (req, res) {
  let user_id = jwt.decode(req.headers["x-access-token"]).id;
  let quicky_id = req.params.id;
  let response = req.body.answer;
  quickyObject.getSingleQuickyRecord(quicky_id, function (err, QuickyResponse) {
    if (err) {
      res.send({
        status: 400,
        message: "Something Went Wrong!",
      });
    } else {
      if (QuickyResponse) {
        let quickData = {
          partner1_intrest:
            QuickyResponse.user_id == user_id
              ? response
              : QuickyResponse.partner1_intrest,
          partner2_intrest:
            QuickyResponse.user_id == user_id
              ? QuickyResponse.partner2_intrest
              : response,
          quicky_id: quicky_id,
        };
        quickyObject.updateUserIntrest(
          quickData,
          function (err, UpdatedQuicky) {
            if (err) {
              res.send({
                status: 400,
                message: "Something Went Wrong!",
              });
            } else {
              if (UpdatedQuicky) {
                userServiceObject.getPartnerById(
                  user_id,
                  function (err, PartnerData) {
                    if (err) {
                      res.send({
                        status: 400,
                        message: "Something Went Wrong!",
                      });
                    } else {
                      if (PartnerData) {
                        if (response == true) {

                          if (QuickyResponse.user_id == user_id) {
                            if (
                              UpdatedQuicky.partner1_intrest ==
                              true &&
                              UpdatedQuicky.partner2_intrest ==
                              true
                            ) {


                              userServiceObject.getUserById(
                                user_id,
                                function (err, userData) {
                                  if (err) {
                                    res.send({
                                      status: 400,
                                      message:
                                        "Something Went Wrong!",
                                    });
                                  } else {
                                    quickyObject.saveQuickybeforenotification(quikceydata, function (err, updatedStage) {
                                    })
                                    let data = {
                                      title:
                                        "OPTIMIZE | HARMONIZEO.",
                                      message: `You have an alert from Oh!. Log in to respond…`,
                                      type:
                                        "Inform",
                                      quicky_id: quicky_id
                                    };

                                    notificationObject.Sendnotification(
                                      PartnerData.fcmid,
                                      data,
                                      function (
                                        err,
                                        response
                                      ) {
                                        let notificationdata = {
                                          user_id: user_id,
                                          title: "Oh Yes! It's your lucky night!",
                                          message: `Oh Yes! It's your lucky night!`,
                                          type: "Inform",
                                        }
                                        notificationObject.addnotification(notificationdata,
                                          function (err, response) { }
                                        );
                                      }

                                    );
                                    notificationObject.Sendnotification(
                                      userData.fcmid,
                                      data,
                                      function (
                                        err,
                                        response
                                      ) {
                                        let notificationdata = {
                                          user_id: user_id,
                                          title: "Oh Yes! It's your lucky night!",
                                          message: `Oh Yes! It's your lucky night!`,
                                          type: "Inform",
                                        }
                                        notificationObject.addnotification(notificationdata,
                                          function (err, response) { }
                                        );
                                      }
                                    );

                                  }
                                });
                            }
                            if (UpdatedQuicky.partner2_intrest == false) {
                              res.send({
                                status: 200,
                                message:
                                  "Your partner is not intrest for connect tonight",
                                fcmid: PartnerData.fcmid,
                              });
                            } else if (UpdatedQuicky.partner2_intrest == true) {
                              res.send({
                                status: 200,
                                message: "User intrest save successfully",
                                fcmid: PartnerData.fcmid,
                              });
                            } else {

                              let When = customHelper.Get_HoursMinutes(
                                UpdatedQuicky.when
                              );

                              var now = new Date();
                              var onTime = new Date(
                                now.getFullYear(),
                                now.getMonth(),
                                now.getDate(),
                                When.hours,
                                When.minutes,
                                0
                              );

                              let timeout1 = current_datetime
                                .subtract(onTime, now)
                                .toMilliseconds();
                              setTimeout(() => {
                                quickyObject.getSingleQuickyRecord(
                                  quicky_id,
                                  function (err, Quickies) {
                                    if (err) {
                                      res.send({
                                        status: 400,
                                        message: "Something Went Wrong!",
                                      });
                                    } else {

                                      if (Quickies) {
                                        if (
                                          Quickies.partner1_intrest == false ||
                                          Quickies.partner2_intrest == false
                                        ) {
                                          res.send({
                                            status: 200,
                                            message:
                                              "Any one partner is not intrested.",
                                            fcmid: PartnerData.fcmid,
                                          });
                                        } else if (
                                          Quickies.partner1_intrest == null &&
                                          Quickies.partner2_intrest == null
                                        ) {
                                          res.send({
                                            status: 200,
                                            message:
                                              "Any one partner is not choosed option.",
                                            fcmid: PartnerData.fcmid,
                                          });
                                        } else {
                                          userServiceObject.getUserById(
                                            user_id,
                                            function (err, userData) {
                                              if (err) {
                                                res.send({
                                                  status: 400,
                                                  message:
                                                    "Something Went Wrong!",
                                                });
                                              } else {
                                                if (userData) {
                                                  userServiceObject.getPartnerById(
                                                    user_id,
                                                    function (
                                                      err,
                                                      partnerData
                                                    ) {
                                                      if (err) {
                                                        res.send({
                                                          status: 400,
                                                          message:
                                                            "Something Went Wrong!",
                                                        });
                                                      } else {

                                                        if (partnerData) {
                                                          goalServiceObject.getGoalDetails(
                                                            user_id,
                                                            partnerData.id,
                                                            function (
                                                              err,
                                                              Goaldata
                                                            ) {
                                                              if (err) {
                                                                res.send({
                                                                  status: 404,
                                                                  message:
                                                                    "Something went wrong!",
                                                                });
                                                              } else {

                                                                if (Goaldata) {

                                                                  let acounttime = customHelper.Get_HoursMinutes(
                                                                    Goaldata.hours
                                                                  );
                                                                  let RequsestTime = customHelper.Get_HoursMinutes(
                                                                    Goaldata.intimate_request_time
                                                                  );

                                                                  let hours =
                                                                    RequsestTime.hours +
                                                                    acounttime.hours;
                                                                  let minutes =
                                                                    RequsestTime.minutes +
                                                                    acounttime.minutes;
                                                                  var now = new Date();
                                                                  var final = new Date(
                                                                    now.getFullYear(),
                                                                    now.getMonth(),
                                                                    now.getDate(),
                                                                    hours,
                                                                    minutes,
                                                                    0
                                                                  );


                                                                  let timeout = current_datetime
                                                                    .subtract(
                                                                      final,
                                                                      now
                                                                    )
                                                                    .toMilliseconds();

                                                                  let statusCheck = customHelper.check_notification_Mute(
                                                                    userData.notification_mute_start,
                                                                    userData.notification_mute_end
                                                                  );
                                                                  if (
                                                                    statusCheck
                                                                  ) {
                                                                    res.send({
                                                                      status: 400,
                                                                      message:
                                                                        "Notificaiton is mute for some time.",
                                                                    });
                                                                  } else {

                                                                    if (
                                                                      Quickies.partner1_intrest ==
                                                                      null ||
                                                                      Quickies.partner2_intrest ==
                                                                      null
                                                                    ) {

                                                                      setTimeout(
                                                                        () => {
                                                                          quickyObject.saveQuickybeforenotification(quikceydata, function (err, updatedStage) {
                                                                          })
                                                                          let data = {
                                                                            title:
                                                                              "OPTIMIZE | HARMONIZE0.",
                                                                            message: `You have an alert from Oh!. Log in to respond…`,
                                                                            type:
                                                                              "feedback",
                                                                            quicky_id: quicky_id,
                                                                          };

                                                                          notificationObject.Sendnotification(
                                                                            partnerData.fcmid,
                                                                            data,
                                                                            function (
                                                                              err,
                                                                              response
                                                                            ) {
                                                                              let notificationdata = {
                                                                                user_id: user_id,
                                                                                title: "FeedBack for last night",
                                                                                message: `Did you connect last night?`,
                                                                                type: "feedback",
                                                                              }
                                                                              notificationObject.addnotification(notificationdata,
                                                                                function (err, response) { }
                                                                              );
                                                                            }

                                                                          );
                                                                          notificationObject.Sendnotification(
                                                                            userData.fcmid,
                                                                            data,
                                                                            function (
                                                                              err,
                                                                              response
                                                                            ) {
                                                                              let notificationdata = {
                                                                                user_id: user_id,
                                                                                title: "FeedBack for last night",
                                                                                message: `Did you connect last night?`,
                                                                                type: "feedback",
                                                                              }
                                                                              notificationObject.addnotification(notificationdata,
                                                                                function (err, response) { }
                                                                              );
                                                                            }
                                                                          );
                                                                        },
                                                                        timeout
                                                                      );
                                                                    } else {

                                                                      setTimeout(
                                                                        () => {
                                                                          quickyObject.saveQuickybeforenotification(quikceydata, function (err, updatedStage) {
                                                                          })
                                                                          let data = {
                                                                            title:
                                                                              "OPTIMIZE | HARMONIZEO.",
                                                                            message: `You have an alert from Oh!. Log in to respond…`,
                                                                            type:
                                                                              "feedback",
                                                                            quicky_id: quicky_id,
                                                                          };
                                                                          notificationObject.Sendnotification(
                                                                            partnerData.fcmid,
                                                                            data,
                                                                            function (
                                                                              err,
                                                                              response
                                                                            ) {
                                                                              let notificationdata = {
                                                                                user_id: user_id,
                                                                                title: "FeedBack for last night",
                                                                                message: `Did you connect last night?`,
                                                                                type: "feedback",
                                                                              }
                                                                              notificationObject.addnotification(notificationdata,
                                                                                function (err, response) { }
                                                                              );
                                                                            }
                                                                          );
                                                                          notificationObject.Sendnotification(
                                                                            userData.fcmid,
                                                                            data,
                                                                            function (
                                                                              err,
                                                                              response
                                                                            ) {
                                                                              let notificationdata = {
                                                                                user_id: user_id,
                                                                                title: "FeedBack for last night",
                                                                                message: `Did you connect last night?`,
                                                                                type: "feedback",
                                                                              }
                                                                              notificationObject.addnotification(notificationdata,
                                                                                function (err, response) { }
                                                                              );
                                                                            }
                                                                          );
                                                                        },
                                                                        timeout
                                                                      );
                                                                    }
                                                                  }
                                                                } else {
                                                                  res.send({
                                                                    status: 400,
                                                                    message:
                                                                      "Goal is not found",
                                                                  });
                                                                }
                                                              }
                                                            }
                                                          );
                                                        }
                                                      }
                                                    }
                                                  );
                                                }
                                              }
                                            }
                                          );
                                        }
                                      } else {
                                        res.send({
                                          status: 400,
                                          message: "Quicky data is not found",
                                        });
                                      }
                                    }
                                  }
                                );
                              }, timeout1);
                              res.send({
                                status: 200,
                                message: "User intrest save successfully",
                                fcmid: PartnerData.fcmid,
                              });
                            }
                          } else {
                            if (
                              UpdatedQuicky.partner1_intrest ==
                              true &&
                              UpdatedQuicky.partner2_intrest ==
                              true
                            ) {

                              userServiceObject.getUserById(
                                user_id,
                                function (err, userData) {
                                  if (err) {
                                    res.send({
                                      status: 400,
                                      message:
                                        "Something Went Wrong!",
                                    });
                                  } else {
                                    quickyObject.saveQuickybeforenotification(quikceydata, function (err, updatedStage) {
                                    })
                                    let data = {
                                      title:
                                        "OPTIMIZE | HARMONIZEO.",
                                      message: `You have an alert from Oh!. Log in to respond…`,
                                      type:
                                        "Inform",
                                      quicky_id: quicky_id
                                    };

                                    notificationObject.Sendnotification(
                                      PartnerData.fcmid,
                                      data,
                                      function (
                                        err,
                                        response
                                      ) {
                                        let notificationdata = {
                                          user_id: user_id,
                                          title: "Oh Yes! It's your lucky night!",
                                          message: `Oh Yes! It's your lucky night!`,
                                          type: "Inform",
                                        }
                                        notificationObject.addnotification(notificationdata,
                                          function (err, response) { }
                                        );
                                      }

                                    );
                                    notificationObject.Sendnotification(
                                      userData.fcmid,
                                      data,
                                      function (
                                        err,
                                        response
                                      ) {
                                        let notificationdata = {
                                          user_id: user_id,
                                          title: "Oh Yes! It's your lucky night!",
                                          message: `Oh Yes! It's your lucky night!`,
                                          type: "Inform",
                                        }
                                        notificationObject.addnotification(notificationdata,
                                          function (err, response) { }
                                        );
                                      }
                                    );
                                  }
                                });
                            }
                            if (UpdatedQuicky.partner1_intrest == false) {
                              res.send({
                                status: 200,
                                message: "User intrest save successfully",
                                fcmid: PartnerData.fcmid,
                              });
                            } else if (UpdatedQuicky.partner1_intrest == true) {
                              res.send({
                                status: 200,
                                message: "User intrest save successfully",
                                fcmid: PartnerData.fcmid,
                              });
                            } else {

                              let When = customHelper.Get_HoursMinutes(
                                UpdatedQuicky.when
                              );
                              var now = new Date();
                              var onTime = new Date(
                                now.getFullYear(),
                                now.getMonth(),
                                now.getDate(),
                                When.hours,
                                When.minutes,
                                0
                              );

                              let timeout1 = current_datetime
                                .subtract(onTime, now)
                                .toMilliseconds();
                              setTimeout(() => {
                                quickyObject.getSingleQuickyRecord(
                                  quicky_id,
                                  function (err, Quickies) {
                                    if (err) {
                                      res.send({
                                        status: 400,
                                        message: "Something Went Wrong!",
                                      });
                                    } else {
                                      if (Quickies) {
                                        if (
                                          Quickies.partner1_intrest == false ||
                                          Quickies.partner2_intrest == false
                                        ) {
                                          res.send({
                                            status: 200,
                                            message:
                                              "Any one partner is not intrested.",
                                            fcmid: PartnerData.fcmid,
                                          });
                                        } else if (
                                          Quickies.partner1_intrest == null &&
                                          Quickies.partner2_intrest == null
                                        ) {
                                          res.send({
                                            status: 200,
                                            message:
                                              "Any one partner is not choosed option.",
                                            fcmid: PartnerData.fcmid,
                                          });
                                        } else {
                                          userServiceObject.getUserById(
                                            user_id,
                                            function (err, userData) {
                                              if (err) {
                                                res.send({
                                                  status: 400,
                                                  message:
                                                    "Something Went Wrong!",
                                                });
                                              } else {
                                                if (userData) {
                                                  userServiceObject.getPartnerById(
                                                    user_id,
                                                    function (
                                                      err,
                                                      partnerData
                                                    ) {
                                                      if (err) {
                                                        res.send({
                                                          status: 400,
                                                          message:
                                                            "Something Went Wrong!",
                                                        });
                                                      } else {
                                                        if (partnerData) {
                                                          goalServiceObject.getGoalDetails(
                                                            user_id,
                                                            partnerData.id,
                                                            function (
                                                              err,
                                                              Goaldata
                                                            ) {
                                                              if (err) {
                                                                res.send({
                                                                  status: 404,
                                                                  message:
                                                                    "Something went wrong!",
                                                                });
                                                              } else {
                                                                if (Goaldata) {
                                                                  let acounttime = customHelper.Get_HoursMinutes(
                                                                    Goaldata.hours
                                                                  );
                                                                  let RequsestTime = customHelper.Get_HoursMinutes(
                                                                    Goaldata.intimate_request_time
                                                                  );
                                                                  let hours =
                                                                    RequsestTime.hours +
                                                                    acounttime.hours;
                                                                  let minutes =
                                                                    RequsestTime.minutes +
                                                                    acounttime.minutes;
                                                                  var now = new Date();
                                                                  var final = new Date(
                                                                    now.getFullYear(),
                                                                    now.getMonth(),
                                                                    now.getDate(),
                                                                    hours,
                                                                    minutes,
                                                                    0
                                                                  );

                                                                  let timeout = current_datetime
                                                                    .subtract(
                                                                      final,
                                                                      now
                                                                    )
                                                                    .toMilliseconds();


                                                                  let statusCheck = customHelper.check_notification_Mute(
                                                                    userData.notification_mute_start,
                                                                    userData.notification_mute_end
                                                                  );
                                                                  if (
                                                                    statusCheck
                                                                  ) {
                                                                    res.send({
                                                                      status: 400,
                                                                      message:
                                                                        "Notificaiton is mute for some time.",
                                                                    });
                                                                  } else {

                                                                    if (
                                                                      Quickies.partner1_intrest ==
                                                                      null ||
                                                                      Quickies.partner2_intrest ==
                                                                      null
                                                                    ) {
                                                                      setTimeout(
                                                                        () => {
                                                                          quickyObject.saveQuickybeforenotification(quikceydata, function (err, updatedStage) {
                                                                          })
                                                                          let data = {
                                                                            title:
                                                                              "OPTIMIZE | HARMONIZEO.",
                                                                            message: `You have an alert from Oh!. Log in to respond…`,
                                                                            type:
                                                                              "feedback",
                                                                            quicky_id: quicky_id,

                                                                          };

                                                                          notificationObject.Sendnotification(
                                                                            partnerData.fcmid,
                                                                            data,
                                                                            function (
                                                                              err,
                                                                              response
                                                                            ) {
                                                                              let notificationdata = {
                                                                                user_id: user_id,
                                                                                title: "FeedBack for last night",
                                                                                message: `Did you connect last night?`,
                                                                                type: "feedback",
                                                                              }
                                                                              notificationObject.addnotification(notificationdata,
                                                                                function (err, response) { }
                                                                              );
                                                                            }

                                                                          );
                                                                          notificationObject.Sendnotification(
                                                                            userData.fcmid,
                                                                            data,
                                                                            function (
                                                                              err,
                                                                              response
                                                                            ) {
                                                                              let notificationdata = {
                                                                                user_id: user_id,
                                                                                title: "FeedBack for last night",
                                                                                message: `Did you connect last night?`,
                                                                                type: "feedback",
                                                                              }
                                                                              notificationObject.addnotification(notificationdata,
                                                                                function (err, response) { }
                                                                              );
                                                                            }
                                                                          );
                                                                        },
                                                                        timeout
                                                                      );
                                                                    } else {
                                                                      setTimeout(
                                                                        () => {
                                                                          quickyObject.saveQuickybeforenotification(quikceydata, function (err, updatedStage) {
                                                                          })
                                                                          let data = {

                                                                            title:
                                                                              "OPTIMIZE | HARMONIZEO.",
                                                                            message: `You have an alert from Oh!. Log in to respond…`,
                                                                            type:
                                                                              "feedback",
                                                                            quicky_id: quicky_id,
                                                                          };
                                                                          notificationObject.Sendnotification(
                                                                            partnerData.fcmid,
                                                                            data,
                                                                            function (
                                                                              err,
                                                                              response
                                                                            ) {
                                                                              let notificationdata = {
                                                                                user_id: user_id,
                                                                                title: "FeedBack for last night",
                                                                                message: `Did you connect last night?`,
                                                                                type: "feedback",
                                                                              }
                                                                              notificationObject.addnotification(notificationdata,
                                                                                function (err, response) { }
                                                                              );
                                                                            }
                                                                          );
                                                                          notificationObject.Sendnotification(
                                                                            userData.fcmid,
                                                                            data,
                                                                            function (
                                                                              err,
                                                                              response
                                                                            ) {
                                                                              let notificationdata = {
                                                                                user_id: user_id,
                                                                                title: "FeedBack for last night",
                                                                                message: `Did you connect last night?`,
                                                                                type: "feedback",
                                                                              }
                                                                              notificationObject.addnotification(notificationdata,
                                                                                function (err, response) { }
                                                                              );
                                                                            }
                                                                          );
                                                                        },
                                                                        timeout
                                                                      );

                                                                      // let data = {
                                                                      //   title:
                                                                      //     "Congratulations on scheduling a connection!",
                                                                      //   message: `It’s your turn to initiate.`,
                                                                      //   type:
                                                                      //     "Inform",
                                                                      //   quicky_id: quicky_id,
                                                                      // };
                                                                      // notificationObject.Sendnotification(
                                                                      //   partnerData.fcmid,
                                                                      //   data,
                                                                      //   function (
                                                                      //     err,
                                                                      //     response
                                                                      //   ) {
                                                                      //   }
                                                                      // );
                                                                      // notificationObject.Sendnotification(
                                                                      //   userData.fcmid,
                                                                      //   data,
                                                                      //   function (
                                                                      //     err,
                                                                      //     response
                                                                      //   ) {
                                                                      //     console.log(
                                                                      //       "singal======================================================================",
                                                                      //       response
                                                                      //     );
                                                                      //   }
                                                                      // );
                                                                    }
                                                                  }
                                                                } else {
                                                                  res.send({
                                                                    status: 400,
                                                                    message:
                                                                      "Goal is not found",
                                                                  });
                                                                }
                                                              }
                                                            }
                                                          );
                                                        }
                                                      }
                                                    }
                                                  );
                                                }
                                              }
                                            }
                                          );
                                        }
                                      } else {
                                        res.send({
                                          status: 400,
                                          message: "Quicky data is not found",
                                        });
                                      }
                                    }
                                  }
                                );
                              }, timeout1);
                              res.send({
                                status: 200,
                                message: "User intrest save successfully",
                                fcmid: PartnerData.fcmid,
                              });
                            }
                          }
                        } else {
                          res.send({
                            status: 200,
                            message: "User intrest save successfully",
                            fcmid: PartnerData.fcmid,
                            partner1_intrest: UpdatedQuicky.partner1_intrest,
                            partner2_intrest: UpdatedQuicky.partner2_intrest,
                          });
                        }
                      } else {
                        res.send({
                          status: 400,
                          message: "Partner is not found",
                        });
                      }
                    }
                  }
                );
              } else {
                res.send({
                  status: 400,
                  message: "Quicky data is not found",
                });
              }
            }
          }
        );
      } else {
        res.send({
          status: 400,
          message: "Quicky data is not found",
        });
      }
    }
  });
});

// get save notification
router.get('/getsavenotification', verifyToken, function (req, res, next) {
  let user_id = jwt.decode(req.headers["x-access-token"]).id;
  if (!user_id) {
    return res.send({
      status: 400,
      message: 'user_id is required',
    });
  }

  notificationObject.getNotificationData(user_id, function (err, notificationdata) {
    if (err) {
      res.send({
        status: 500,
        message: 'Something went wrong.',
      });
    }
    else {
      if (notificationdata) {
        res.send({
          status: 200,
          result: notificationdata,
        });
      }
      else {
        res.send({
          status: 404,
          message: 'No Data found.',
        });
      }
    }
  })

})


router.put("/updatesaveNotification/:id", verifyToken, function (req, res) {
  let id = req.params.id;
  let user_id = jwt.decode(req.headers["x-access-token"]).id;

  notificationObject.updatesaveNotification(id, function (err, updateStage) {
    if (err) {
      res.send({
        status: 500,
        message: 'Something went wrong.',
      });
    }
    else {
      if (updateStage) {
        res.send({
          status: 200,
          result: updateStage,
        })
      } else {
        res.send({
          status: 504,
          message: "Something went wrong!"
        })
      }
    }
  })
});

// save notification
router.post('/Savenotification', verifyToken, function (req, res) {

  let user_id = req.body.user_id
  let quickey_id = req.body.quickey_id;
  let title = req.body.title;
  let message = req.body.message;
  let type = req.body.type
  let status = req.body.status;
  let checkans = "false"
  notificationObject.savenotificationdata(user_id, quickey_id, title, message, type, status, checkans, function (err, notificationdata) {
    if (err) {
      res.send({
        status: 404,
        message: "something went wrong!!"
      })
    } else {
      if (notificationdata) {
        res.send({
          status: 200,
          message: "Data save successfully",
          Data: notificationdata
        })
      } else {
        res.send({
          status: 400,
          message: "Something went wrong"
        })
      }
    }
  })

})


module.exports = router;
