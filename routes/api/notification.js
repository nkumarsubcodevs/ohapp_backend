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

// Create route object
let router =  express.Router();

// Create notification model object
var notificationObject = new NotificationService();

// Create goal model object
var goalServiceObject = new goalService();

// Create user model object
var userServiceObject = new userService();

var quickyObject = new quickyService();
// Get single page content
router.get('/checkNotificationStage', verifyToken, function(req, res, next) {

  var user_id = jwt.decode(req.headers['x-access-token']).id;

  notificationObject.getNotification(user_id, function(err, pageData)
  {
      if(err)
      {
          res.send({
            status: 500,
            message: 'Please Wait! The quicky setup is already in progress by your partner.',
          });
      }
      else
      {
          if(pageData)
          {
            goalServiceObject.getPartnerData(user_id, function(err, patnerData) {
              if(err) {
                res.send({
                  status: 400,
                  message: "Something went wrong"
                })
              } else {
                if(patnerData) {
                  notificationObject.getNotification(patnerData.partner_two_id, function(err, patner) {
                    if(err) {
                      res.send({
                        status: 400,
                        message: "something went wrong"
                      })
                    } else {
                      if(patner.stage == 1 && pageData.stage == 1) {
                          notificationObject.getNotificationById(pageData.id, function(err, notification1) {
                            if(err) {
                              res.send({
                                status: 400,
                                message: "Something went wrong!"
                              })
                            } else {
                              if(notification1) {
                                notificationObject.getNotificationById(patner.id, function(err, notification2) {
                                  if(err) {
                                    res.send({
                                      status: 400,
                                      message: "Something went wrong!"
                                    })
                                  } else {
                                    if(notification2) {
                                     if(notification2.stage == 1 && notification1.stage) {
                                       notificationObject.updateNotificationStage(pageData.notification_id, 2, function(err, updateStage) {
                                         if(updateStage) {
                                           res.send({
                                             status:200,
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
                                         status:404,
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
                      } else if(patner.stage == 2 && pageData.stage == 1) {
                        res.send({
                          status:200,
                          message: "Your patner is setting quicky",
                          user_stage: pageData.stage,
                          partner_stage: patner.stage
                        })
                      } else if(patner.stage == 3 && pageData.stage == 3){
                        res.send({
                          status: 200,
                          message: "Quicky is saved successfully",
                          user_stage: pageData.stage,
                          partner_stage: patner.stage
                        })
                      } else {
                        notificationObject.updateNotificationStage(pageData.notification_id, 2, function(err, updateStage) {
                          if(updateStage) {
                            res.send({
                              status:200,
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
          else
          {
            res.send({
              status: 404,
              message: 'Notification is not found',
            });
          }
      }
  });
});

router.post('/NotificationMute', verifyToken, function(req, res) {
    let user_id = jwt.decode(req.headers['x-access-token']).id;
    let start_time = req.body.start_time;
    let end_time = req.body.end_time;
    let mute_status = req.body.mute_status;

    if(!start_time) 
    {
      return res.send({
        status: 400,
        message: 'Start Time is required',
      });
    }

    if(!end_time) 
    {
      return res.send({
        status: 400,
        message: 'End Time is required',
      });
    }

    userServiceObject.getPartnerById(user_id, function(err, partnerData) {
      if(err) {
        res.send({
          status: 400,
          message: "Something Went Wrong!"
        })
      } else {
        if(partnerData) {
          let Data = {
            user_id: user_id,
            partner_id: partnerData.id,
            start_time: start_time,
            end_time: end_time,
            mute_status: mute_status
          }
          userServiceObject.UpdateNotificationMuteData(Data, function(err, UpdateNotificationMute) {
            if(err) {
              res.send({
                status: 400,
                message: "Something Went Wrong! Please try after some time"
              })
            } else {
              if(UpdateNotificationMute) {
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

router.get('/NotificationStatus', verifyToken, function(req, res) {
  let user_id = jwt.decode(req.headers['x-access-token']).id;

  userServiceObject.getUserById(user_id, function(err, UserData) {
    if(err) {
      res.send({
        status: 400,
        message: "Something went wrong!"
      })
    } else {
      if(UserData) {
        if(UserData.notification_mute_status) {
          // let Now = current_datetime.format(new Date, 'YYYY-MM-DD HH:mm:ss', true);
          // let end_time = new Date(UserData.notification_mute_end);
          // let start_time = new Date(UserData.notification_mute_start);
          // Now = new Date(Now);
          // if((Now.getTime() < end_time.getTime()) && (Now.getTime() > start_time.getTime())) {
            let statusCheck = customHelper.check_notification_Mute(UserData.notification_mute_start,UserData.notification_mute_end);
            if(statusCheck) {
              res.send({
                status:200,
                result: true,
                message: "Notification is mute for some time"
              })
            } else {
            // }
          // } else {
            userServiceObject.getPartnerById(user_id, function(err, partnerData) {
              if(err) {
                res.send({
                  status: 400,
                  message: "Somwthing Went Wrong! Please try after some time"
                })
              } else {
                if(partnerData) {
                  let unmute = {
                    status: 0,
                    user_id: user_id,
                    partner_id: partnerData.id
                  }
                  userServiceObject.UpdateNotificationStatus(unmute, function(err, UpdatedData) {
                    if(err) {
                      res.send({
                        status: 400,
                        message: "Somwthing Went Wrong! Please try after some time"
                      })
                    } else {
                      if(UpdatedData) {
                        res.send({
                          status:200,
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

router.post('/checkUserIntrest/:id', verifyToken, function(req, res) {
  let user_id = jwt.decode(req.headers['x-access-token']).id;
  let quicky_id = req.params.id
  let response = req.body.answer;
    quickyObject.getSingleQuickyRecord(quicky_id, function(err, QuickyResponse) {
      if(err) {
        res.send({
          status: 400,
          message: "Something Went Wrong!"
        })
      } else {
        if(QuickyResponse) {
          let quickData = {
            partner1_intrest: QuickyResponse.user_id == user_id ? response : QuickyResponse.partner1_intrest,
            partner2_intrest: QuickyResponse.user_id == user_id ? QuickyResponse.partner2_intrest : response,
            quicky_id: quicky_id
          }
          quickyObject.updateUserIntrest(quickData, function(err, UpdatedQuicky) {
            if(err) {
              res.send({
                status: 400,
                message: "Something Went Wrong!"
              })
            } else {
              if(UpdatedQuicky) {
                setTimeout(() => {
                  quickyObject.getSingleQuickyRecord(quicky_id, function(err, Quickies) {
                    if(err) {
                      res.send({
                        status: 400,
                        message: "Something Went Wrong!"
                      })
                    } else {
                      if(Quickies) {
                        if(Quickies.partner1_intrest == false || Quickies.partner2_intrest == false) {
                          res.send({
                            status: 200,
                            message: "Any one partner is not intrested."
                          })
                        } else if(Quickies.partner1_intrest == null && Quickies.partner2_intrest == null) {
                          res.send({
                            status: 200,
                            message: "Any one partner is not choosed option."
                          })
                        }
                        else {
                            userServiceObject.getUserById(user_id, function(err, userData) {
                              if(err) {
                                res.send({
                                  status: 400,
                                  message: "Something Went Wrong!"
                                })
                              } else {
                                if(userData) {
                                  userServiceObject.getPartnerById(user_id, function(err, partnerData) {
                                    if(err) {
                                      res.send({
                                        status: 400,
                                        message: "Something Went Wrong!"
                                      })
                                    } else {
                                      if(partnerData) {
                                        goalServiceObject.getGoalDetails(user_id, partnerData.id, function(err, Goaldata) {
                                          if(err) {
                                           res.send({
                                             status: 404,
                                             message: "Something went wrong!"
                                           })
                                          } else {
                                            if(Goaldata) {
                                              const [time, modifier] = Goaldata.intimate_account_time.split(' ');
                                                 let [hours, minutes] = time.split(':');
                                                 if (hours === '12') {
                                                 hours = '00';
                                                 }
                                                 if (modifier === 'PM') {
                                                   hours = parseInt(hours, 10) + 12;
                                                 }
                                                 var now = new Date();
                                                 var final = new Date(
                                                   now.getFullYear(),
                                                   now.getMonth(),
                                                   now.getDate() + 1,
                                                   hours, minutes, 0  
                                               );
                                                 let timeout = current_datetime.subtract(final, now).toMilliseconds();
                                                 const [time1, modifier1] = QuickyResponse.when.split(' ');
                                                 let [hours1, minutes1] = time1.split(':');
                                                 if (hours === '12') {
                                                 hours1 = '00';
                                                 }
                                                 if (modifier1 === 'PM') {
                                                   hours1 = parseInt(hours1, 10) + 12;
                                                 }
                                                 var now = new Date();
                                                 var onTime = new Date(
                                                   now.getFullYear(),
                                                   now.getMonth(),
                                                   now.getDate(),
                                                   hours1, minutes1, 0
                                               );
                                                 let timeout1 = current_datetime.subtract(onTime, now).toMilliseconds();
                                                 let statusCheck = customHelper.check_notification_Mute(userData.notification_mute_start,userData.notification_mute_end);
                                                 if(statusCheck) {
                                                 res.send({
                                                   status: 400,
                                                   message: "Notificaiton is mute for some time."
                                                 })
                                               } else {
                                                 if(Quickies.partner1_intrest == true && Quickies.partner2_intrest == null) {
                                                   setTimeout(() => {
                                                     let data = {
                                                       title: "FeedBack for last night",
                                                       message: `Did you connect last night?`,
                                                       type: "feedback",
                                                       quicky_id: quicky_id
                                                     }
                                                     notificationObject.Sendnotification(partnerData.fcmid, data, function(err, response) {})
                                                     notificationObject.Sendnotification(userData.fcmid, data,  function(err, response) {})
                                                   }, timeout)
                                                   setTimeout(() => {
                                                    let data = {
                                                      title: "Congratulations on scheduling a connection!",
                                                      message: `It’s ${userData.first_name}'s turn to initiate.`,
                                                      type: "Inform",
                                                      quicky_id: quicky_id
                                                    }
                                                    notificationObject.Sendnotification(partnerData.fcmid, data, function(err, response) {})
                                                    notificationObject.Sendnotification(userData.fcmid, data,  function(err, response) {})
                                                  }, timeout1);
                                                 } else {
                                                  setTimeout(() => {
                                                    let data = {
                                                      title: "FeedBack for last night",
                                                      message: `Did you connect last night?`,
                                                      type: "feedback",
                                                      quicky_id: quicky_id
                                                    }
                                                    notificationObject.Sendnotification(userData.fcmid, data,  function(err, response) {})
                                                  }, timeout)
                                                  setTimeout(() => {
                                                    let data = {
                                                      title: "Congratulations on scheduling a connection!",
                                                      message: `It’s ${userData.first_name}'s turn to initiate.`,
                                                      type: "Inform",
                                                      quicky_id: quicky_id
                                                    }
                                                    notificationObject.Sendnotification(userData.fcmid, data,  function(err, response) {})
                                                  }, timeout1);
                                                 }
                                               }
                                            } else {
                                              res.send({
                                                status: 400,
                                                message: "Goal is not found"
                                              })
                                            }
                                          }
                                        })
                                      }
                                    }
                                  })
                                }
                              }
                            })
                        }
                      }else {
                        res.send({
                          status: 400,
                          message: "Quicky data is not found"
                        })
                      }
                    }
                  })
                }, 1000)
                res.send({
                  status: 200,
                  message: "User intrest save successfully"
                })
              } else {
                res.send({
                  status: 400,
                  message: "Quicky data is not found"
                })
              }
            }
          })
        } else {
          res.send({
            status: 400,
            message: "Quicky data is not found"
          })
        }
      }
    })
})

module.exports = router;