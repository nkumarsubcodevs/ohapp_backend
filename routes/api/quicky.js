/**
 * @desc this file will contains the routes for feedback api
 * @author Navneet Kumar navneet.kumar@subcodevs.com
 * @file feedback.js
 */

const express = require("express");
const QuickyService = require("../../services/QuickyService");
const GoalService = require("../../services/GoalService");
const userService = require("../../services/UserService");
const NotificationService = require("../../services/NotificationService");
const formValidator = require("validator");
const customHelper = require("../../helpers/custom_helper");
const jwt = require("jsonwebtoken");
const current_datetime = require("date-and-time");
// verifytoken middleware
const verifyToken = require("./verifytoken");

// Create route object
let router = express.Router();

// Create user model object
var quickyObject = new QuickyService();

// Create Goal model object
var goalObject = new GoalService();

// Create USer model object
var userSerObject = new userService();

// Create notification model object
var notificationObject = new NotificationService();

// Save quicky data
router.post("/SaveQuicky", verifyToken, function (req, res) {
  let when = req.body.when;
  let where = req.body.where;
  let user_id = jwt.decode(req.headers["x-access-token"]).id;

  goalObject.getPartnerData(user_id, function (err, partnerData) {
    if (err) {
      res.send({
        status: 404,
        message: "something went wrong!",
      });
    } else {
      if (partnerData) {
        userSerObject.getUserById(partnerData.partner_two_id, function (err, partnerResponse) {
          if (err) {
            res.send({
              status: 400,
              message: "something went wrong",
            });
          } else {
            if (partnerResponse) {
              let data = {
                user_id: user_id,
                when: when,
                where: where,
                partner_mapping_id: partnerData.id,
              };
              quickyObject.saveQuicky(data, function (err, responseQuicky) {
                if (err) {
                  res.send({
                    status: 400,
                    message: "something went wrong",
                  });
                } else {
                  if (responseQuicky) {
                    // notificationObject.getNotification(user_id, function(err, NotificationData) {
                    //   if(err) {
                    //     res.send({
                    //       status: 504,
                    //       message: "Something went worng"
                    //     })
                    //   } else {
                    //     if(NotificationData) {
                    //       notificationObject.updateNotificationStage(NotificationData.notification_id, 3, function(err, updateStage) {
                    //         if(err) {
                    //           res.send({
                    //             status: 504,
                    //             message: "Something went worng"
                    //           })
                    //         } else {
                    //           if(updateStage) {
                    //             notificationObject.getNotification(partnerData.partner_two_id, function(err, NotificationData2) {
                    //               if(err) {
                    //                 res.send({
                    //                   status: 504,
                    //                   message: "Something went worng"
                    //                 })
                    //               } else {
                    //                 if(NotificationData2) {
                    //                   notificationObject.updateNotificationStage(NotificationData2.notification_id, 3, function(err, updatedStage) {
                    //                     if(err) {
                    //                       res.send({
                    //                         status: 504,
                    //                         message: "Something went worng"
                    //                       })
                    //                     } else {
                    //                       if(updatedStage) {
                    //                         res.send({
                    //                           status: 200,
                    //                           message: "quicky save successfully",
                    //                           quickyData: responseQuicky,
                    //                           partner_fcmid: partnerResponse.fcmid
                    //                         })
                    //                       } else {
                    //                         res.send({
                    //                           status: 504,
                    //                           message: "partner stage is not updated"
                    //                         })
                    //                       }
                    //                     }
                    //                   })
                    //                 } else {
                    //                   res.send({
                    //                     status: 504,
                    //                     message: "Notification not found"
                    //                   })
                    //                 }
                    //               }
                    //             })
                    //           } else {
                    //             res.send({
                    //               status: 504,
                    //               message: "not update user stage"
                    //             })
                    //           }
                    //         }
                    //       })
                    //     } else {
                    //       res.send({
                    //         status: 504,
                    //         message: "Notification is not found"
                    //       })
                    //     }
                    //   }
                    // })
                    res.send({
                      status: 200,
                      message: "quicky save successfully",
                      quickyData: responseQuicky,
                      partner_fcmid: partnerResponse.fcmid,
                    });
                  } else {
                    res.send({
                      status: 504,
                      message: "Something went worng",
                    });
                  }
                }
              });
            } else {
              res.send({
                status: 504,
                message: "partner is not found",
              });
            }
          }
        });
      } else {
        res.send({
          status: 504,
          message: "Partner mapping is not found",
        });
      }
    }
  });
});

// Update quicky data
// router.put("/updateQuicky/:id", verifyToken, function (req, res) {
//   let when = req.body.when;
//   let where = req.body.where;
//   let partner_response = req.body.partner_response;
//   let user_id = jwt.decode(req.headers["x-access-token"]).id;
//   let quicky_id = req.params.id;
//   quickyObject.getSingleQuickyRecord(quicky_id, function (err, QuickyData) {
//     if (err) {
//       res.send({
//         status: 400,
//         message: "something Went wrong!",
//       });
//     } else {
//       if (QuickyData) {
//         goalObject.getPartnerData(user_id, function (err, partnerData) {
//           if (err) {
//             res.send({
//               status: 404,
//               message: "something went wrong!",
//             });
//           } else {
//             if (partnerData) {
//               userSerObject.getUserById(partnerData.partner_two_id, function (err, partnerResponse) {
//                 if (err) {
//                   res.send({
//                     status: 400,
//                     message: "something went wrong",
//                   });
//                 } else {
//                   if (partnerResponse) {
//                     let data = {
//                       user_id: user_id,
//                       when: when,
//                       where: where,
//                       partner_mapping_id: partnerData.id,
//                       quicky_id: quicky_id,
//                       partner_response: partner_response,
//                     };
//                     quickyObject.updateQuicky(data, function (err, responseQuicky) {
//                       if (err) {
//                         res.send({
//                           status: 400,
//                           message: "something went wrong",
//                         });
//                       }
//                       if (responseQuicky) {
//                         if (responseQuicky.partner_response === true) {
//                           userSerObject.getUserById(user_id, function (err, userData) {
//                             if (err) {
//                               res.send({
//                                 status: 404,
//                                 message: "something went wrong",
//                               });
//                             } else {
//                               if (userData) {
//                                 goalObject.getGoalDetails(user_id, partnerResponse.id, function (err, Goaldata) {
//                                   if (err) {
//                                     res.send({
//                                       status: 404,
//                                       message: "Something went wrong!",
//                                     });
//                                   } else {
//                                     if (Goaldata) {
//                                       const [time, modifier] = when.split(" ");
//                                       let [hours, minutes] = time.split(":");
//                                       if (hours === "12") {
//                                         hours = "00";
//                                       }
//                                       if (modifier === "PM") {
//                                         hours = parseInt(hours, 10) + 12;
//                                       }
//                                       var now = new Date();
//                                       var before15 = new Date(
//                                         now.getFullYear(),
//                                         now.getMonth(),
//                                         now.getDate(),
//                                         hours,
//                                         minutes - 15,
//                                         0
//                                       );
//                                       var final = new Date(
//                                         now.getFullYear(),
//                                         now.getMonth(),
//                                         now.getDate(),
//                                         hours,
//                                         minutes,
//                                         0
//                                       );
//                                       let timeout = current_datetime.subtract(before15, now).toMilliseconds();
//                                       let timeout1 = current_datetime.subtract(final, now).toMilliseconds();
//                                       let statusCheck = customHelper.check_notification_Mute(
//                                         userData.notification_mute_start,
//                                         userData.notification_mute_end
//                                       );
//                                       if (statusCheck) {
//                                         res.send({
//                                           status: 400,
//                                           message: "Notificaiton is mute for some time.",
//                                         });
//                                       } else {
//                                         setTimeout(() => {
//                                           let data = {
//                                             title: "Thank You for scheduling a connection!",
//                                             message: `It’s your turn to initiate.`,
//                                             type: "Reminder",
//                                             quicky_id: quicky_id,
//                                           };
//                                           notificationObject.Sendnotification(
//                                             partnerResponse.fcmid,
//                                             data,
//                                             function (err, response) { }
//                                           );
//                                           notificationObject.Sendnotification(
//                                             userData.fcmid,
//                                             data,
//                                             function (err, response) { }
//                                           );
//                                         }, timeout);
//                                       }
//                                     } else {
//                                       res.send({
//                                         status: 400,
//                                         message: "Goal is not found",
//                                       });
//                                     }
//                                   }
//                                 });
//                               } else {
//                                 res.send({
//                                   status: 504,
//                                   message: "user is not found",
//                                 });
//                               }
//                             }
//                           });
//                         }
//                         res.send({
//                           status: 200,
//                           message: "quicky update successfully",
//                           QuickyData: responseQuicky,
//                           partner_fcmid: partnerResponse.fcmid,
//                         });
//                       }
//                     });
//                   } else {
//                     res.send({
//                       status: 504,
//                       message: "partner not found",
//                     });
//                   }
//                 }
//               });
//             } else {
//               res.send({
//                 status: 504,
//                 message: "Partner mapping is not found",
//               });
//             }
//           }
//         });
//       } else {
//         res.send({
//           status: 504,
//           message: "Quicky is not found",
//         });
//       }
//     }
//   });
// });

router.put("/updateQuicky/:id", verifyToken, function (req, res) {
  let when = req.body.when;
  let where = req.body.where;
  let partner_response = req.body.partner_response;
  let user_id = jwt.decode(req.headers["x-access-token"]).id;
  let quicky_id = req.params.id;
  quickyObject.getSingleQuickyRecord(quicky_id, function (err, QuickyData) {
    if (err) {
      return res.send({
        status: 400,
        message: "something Went wrong!",
      });
    } else {
      if (QuickyData) {
        goalObject.getPartnerData(user_id, function (err, partnerData) {
          if (err) {
            return res.send({
              status: 404,
              message: "something went wrong!!",
            });
          } else {
            if (partnerData) {
              userSerObject.getUserById(partnerData.partner_two_id, function (err, partnerResponse) {
                if (err) {
                  return res.send({
                    status: 400,
                    message: "something went wrong!!370",
                  });
                } else {
                  if (partnerResponse) {
                    let data = {
                      user_id: user_id,
                      when: when,
                      where: where,
                      partner_mapping_id: partnerData.id,
                      quicky_id: quicky_id,
                      partner_response: partner_response,
                    };
                    quickyObject.updateQuicky(data, function (err, responseQuicky) {
                      if (err) {
                        return res.send({
                          status: 400,
                          message: "something went wrong!!",
                        });
                      } else {
                        userSerObject.getUserById(user_id, function (err, userData) {
                          if (err) {
                            return res.send({
                              status: 400,
                              message: "Something Went Wrong!!",

                            });
                          } else {
                            userSerObject.getPartnerById(
                              user_id,
                              function (err, partnerData) {
                                if (responseQuicky.partner_response == true) {
                                  if (err) {
                                    return res.send({
                                      status: 400,
                                      message: "Something Went Wrong!!",
                                    });
                                  } else {
                                    let quikceydata = {
                                      user_id: user_id,
                                      partner_mapping_id: partnerData.id,

                                    }
                                    quickyObject.saveQuickybeforenotification(quikceydata, function (err, quickeydata) {
                                      if (err) {
                                        res.send({
                                          status: 404,
                                          message: "Something went wrong!!"
                                        })
                                      } else {
                                        let notificationdata = {
                                          user_id: user_id,
                                          title: "Quickie confirmed",
                                          message: `Oh Yes! It's your lucky night!`,
                                          type: "Inform",
                                          checkans: "null",
                                          quickey_id: quickeydata.id

                                        }
                                        notificationObject.addnotification(notificationdata,
                                          function (err, response) {
                                            let data = {
                                              title:
                                                "OPTIMIZE | HARMONIZEO.",
                                              message: `You have an alert from Oh!. Log in to respond…`,
                                              type: "Inform",
                                              notification_id: response.id,
                                              quickey_id: response.quickey_id,
                                            };
                                            notificationObject.Sendnotification(
                                              userData.fcmid,
                                              data,
                                              response.id,
                                              response.quickey_id,
                                              function (err, response) { }
                                            )
                                          }

                                        );
                                      }
                                    })
                                    quickyObject.saveQuickybeforenotification(quikceydata, function (err, quickeydata) {
                                      if (err) {
                                        res.send({
                                          status: 404,
                                          message: "Something went wrong!!"
                                        })
                                      } else {
                                        let notificationdata12 = {
                                          user_id: partnerData.id,
                                          title: "Quickie confirmed",
                                          message: `Oh Yes! It's your lucky night!`,
                                          type: "Inform",
                                          checkans: "null",
                                          quickey_id: quickeydata.id
                                        }
                                        notificationObject.addnotification(notificationdata12,
                                          function (err, response) {
                                            let data = {
                                              title:
                                                "OPTIMIZE | HARMONIZEO.",
                                              message: `You have an alert from Oh!. Log in to respond…`,
                                              type: "Inform",
                                              notification_id: response.id,
                                              quickey_id: response.quickey_id,
                                            };
                                            notificationObject.Sendnotification(
                                              partnerData.fcmid,
                                              data,
                                              response.id,
                                              response.quickey_id,
                                              function (
                                                err,
                                                response
                                              ) { }
                                            )

                                          }
                                        );
                                      }
                                    })

                                    let When = customHelper.Get_HoursMinutes(responseQuicky.when);
                                    var now = new Date();
                                    var onTime = new Date(
                                      now.getFullYear(),
                                      now.getMonth(),
                                      now.getDate(),
                                      When.hours,
                                      When.minutes,
                                      0
                                    );

                                    let timeout1 = current_datetime.subtract(onTime, now).toMilliseconds();
                                    setTimeout(() => {
                                      quickyObject.getSingleQuickyRecord(quicky_id, function (err, Quickies) {
                                        if (err) {
                                          return res.send({
                                            status: 400,
                                            message: "Something Went Wrong!!",
                                          });
                                        } else {
                                          userSerObject.getUserById(user_id, function (err, userData) {
                                            if (err) {
                                              return res.send({
                                                status: 400,
                                                message: "Something Went Wrong!!",
                                              });
                                            } else {
                                              if (userData) {
                                                userSerObject.getPartnerById(user_id, function (err, partnerData) {
                                                  if (err) {
                                                    return res.send({
                                                      status: 400,
                                                      message: "Something Went Wrong!!",
                                                    });
                                                  } else {
                                                    if (partnerData) {
                                                      goalObject.getGoalDetails(
                                                        user_id,
                                                        partnerData.id,
                                                        function (err, Goaldata) {
                                                          if (err) {
                                                            return res.send({
                                                              status: 404,
                                                              message: "Something went wrong!!",
                                                            });
                                                          } else {
                                                            if (Goaldata) {
                                                              let acounttime = customHelper.Get_HoursMinutes(
                                                                Goaldata.hours
                                                              );
                                                              let RequsestTime = customHelper.Get_HoursMinutes(
                                                                Goaldata.intimate_request_time
                                                              );

                                                              let hours = RequsestTime.hours + acounttime.hours;
                                                              let minutes = RequsestTime.minutes + acounttime.minutes;
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
                                                                .subtract(final, now)
                                                                .toMilliseconds();

                                                              let statusCheck = customHelper.check_notification_Mute(
                                                                userData.notification_mute_start,
                                                                userData.notification_mute_end
                                                              );
                                                              if (statusCheck) {
                                                                return res.send({
                                                                  status: 400,
                                                                  message: "Notificaiton is mute for some time.",
                                                                });
                                                              } else {

                                                                setTimeout(() => {
                                                                  let quikceydata = {
                                                                    user_id: user_id,
                                                                    partner_mapping_id: partnerData.id,

                                                                  }
                                                                  quickyObject.saveQuickybeforenotification(quikceydata, function (err, quickeydata) {
                                                                    if (err) {
                                                                      return res.send({
                                                                        status: 404,
                                                                        message: "Something went wrong!!"
                                                                      })
                                                                    } else {
                                                                      let notificationdata = {
                                                                        user_id: user_id,
                                                                        title: "FeedBack for last night",
                                                                        message: `Did you connect last night?`,
                                                                        type: "feedback",
                                                                        quickey_id: quickeydata.id,
                                                                        checkans: "null"
                                                                      }
                                                                      notificationObject.addnotification(notificationdata,
                                                                        function (err, response) {
                                                                          let data = {
                                                                            title: "OPTIMIZE | HARMONIZEO.",
                                                                            message: `You have an alert from Oh!. Log in to respond…`,
                                                                            type: "feedback",

                                                                            notification_id: response.id,
                                                                            quickey_id: response.quickey_id,
                                                                          };
                                                                          notificationObject.Sendnotification(
                                                                            userData.fcmid,
                                                                            data,
                                                                            response.id,
                                                                            response.quickey_id,
                                                                            function (err, response) { }
                                                                          )
                                                                        }

                                                                      );


                                                                      let notificationdata12 = {
                                                                        user_id: partnerData.id,
                                                                        title: "FeedBack for last night",
                                                                        message: `Did you connect last night?`,
                                                                        type: "feedback",
                                                                        quickey_id: quickeydata.id,
                                                                        checkans: "null"
                                                                      }
                                                                      notificationObject.addnotification(notificationdata12,
                                                                        function (err, response) {
                                                                          let data = {
                                                                            title: "OPTIMIZE | HARMONIZEO.",
                                                                            message: `You have an alert from Oh!. Log in to respond…`,
                                                                            type: "feedback",
                                                                            notification_id: response.id,
                                                                            quickey_id: response.quickey_id,
                                                                          };
                                                                          notificationObject.Sendnotification(
                                                                            partnerData.fcmid,
                                                                            data,
                                                                            response.id,
                                                                            response.quickey_id,
                                                                            function (err, response) { }
                                                                          )
                                                                        }

                                                                      );
                                                                    }

                                                                  })
                                                                }, timeout);
                                                              }
                                                            } else {
                                                              return res.send({
                                                                status: 400,
                                                                message: "Something went wrong!!",
                                                              });
                                                            }
                                                          }
                                                        }
                                                      );
                                                    } else {
                                                      return res.send({
                                                        status: 400,
                                                        message: "Something went wrong!!",
                                                      });
                                                    }
                                                  }
                                                });
                                              } else {
                                                return res.send({
                                                  status: 400,
                                                  message: "Something went wrong!!",
                                                });
                                              }
                                            }
                                          });
                                        }
                                      });
                                    }, timeout1);

                                    return res.send({
                                      status: 200,
                                      message: "Update Successfully",
                                      QuickyData: responseQuicky,
                                      partner_fcmid: partnerResponse.fcmid,
                                    });
                                  }
                                }
                                else {
                                  if (responseQuicky.partner_response == false) {
                                    return res.send({
                                      status: 200,
                                      message: "Quickie request rejected",
                                      QuickyData: responseQuicky,
                                      partner_fcmid: partnerResponse.fcmid,

                                    })
                                  } else {
                                    return res.send({
                                      status: 400,
                                      message: "something went wrong!!",
                                    });
                                  }
                                }
                              })
                          }
                        })
                      }

                    })
                  }
                }
              });
            } else {
              return res.send({
                status: 504,
                message: "Something went wrong!!",
              });
            }
          }
        });
      } else {
        return res.send({
          status: 400,
          message: "Something went wrong!!!",
        })
      }
    }
  });

});
// Get singal quicky data
router.get("/getQuicky/:id", verifyToken, function (req, res) {
  let quicky_id = req.params.id;
  quickyObject.getSingleQuickyRecord(quicky_id, function (err, QuickyData) {
    if (err) {
      res.send({
        status: 400,
        message: "something Went wrong!",
      });
    } else {
      if (QuickyData) {
        res.send({
          status: 200,
          result: QuickyData,
        });
      } else {
        res.send({
          status: 404,
          message: "Quicky is not found",
        });
      }
    }
  });
});

module.exports = router;
