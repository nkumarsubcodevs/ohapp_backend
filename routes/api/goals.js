/**
 * @desc this file will contains the routes for goals api
 * @author Navneet Kumar navneet.kumar@subcodevs.com
 * @file goals.js
 */

const express = require("express");
const GoalService = require("../../services/GoalService");
const NotificationService = require("../../services/NotificationService");
const UserService = require("../../services/UserService");
const completionService = require("../../services/CompletionService");
const quickyService = require("../../services/QuickyService");
const subscripationService = require("../../services/SubscripationService");
const customHelper = require("../../helpers/custom_helper");
const formValidator = require("validator");
const current_datetime = require("date-and-time");
var cron = require("node-cron");
const jwt = require("jsonwebtoken");
// verifytoken middleware
const verifyToken = require("./verifytoken");

// Create route object
let router = express.Router();

// Get API secret
const config = require("../../config/config");
const completion_goals = require("../../models/completion_goals");

// Create goal model object
var goalSerObject = new GoalService();

// Create user model object
var userSerObject = new UserService();

// Create user model object
var completionSerObject = new completionService();

var notificationObject = new NotificationService();

var SubscripationObject = new subscripationService();

// Create Quicky model
var quickynObject = new quickyService();
let schedules1;
let schedules;
// Get user setting detail
router.get("/getgoalsettings", verifyToken, function (req, res, next) {
  goalSerObject.getGoalSettings(function (err, settingData) {
    if (err) {
      return res.send({
        status: 500,
        message: "There was a problem finding the user setting.",
      });
    } else {
      if (settingData) {
        goalSerObject.getGoalSettings(function (err, GetquestionWithOption) {
          if (err) {
            return res.send({
              status: 404,
              message: "Something Went Wrong",
            });
          } else {
            if (GetquestionWithOption) {
              return res.send({
                status: 200,
                settings: GetquestionWithOption,
              });
            } else {
              return res.send({
                status: 504,
                message: "Option is not found",
              });
            }
          }
        });
      } else {
        return res.send({
          status: 404,
          message: "Question is not found.",
        });
      }
    }
  });
});

// Get user setting detail
router.get("/getgoalsettingsanswer", verifyToken, function (req, res, next) {
  let user_id = jwt.decode(req.headers["x-access-token"]).id;
  goalSerObject.getGoalSettings(function (err, settingData) {
    if (err) {
      return res.send({
        status: 500,
        message: "There was a problem finding the user setting.",
      });
    } else {
      if (settingData) {
        goalSerObject.getGoalSettingsAnswer(user_id, function (err, GetquestionWithOption) {
          if (err) {
            return res.send({
              status: 404,
              message: "something went wrong",
            });
          } else {
            if (GetquestionWithOption) {
              return res.send({
                status: 200,
                settings: GetquestionWithOption,
              });
            } else {
              return res.send({
                status: 504,
                message: "Quetionaries is not avaliable.",
              });
            }
          }
        });
      } else {
        return res.send({
          status: 404,
          message: "Question is not found.",
        });
      }
    }
  });
});

// Get partner user setting detail
router.get("/getpartnergoalsettingsanswer", verifyToken, function (req, res, next) {
  let user_id = jwt.decode(req.headers["x-access-token"]).id;
  userSerObject.getPartnerById(user_id, function (err, partnerData) {
    if (err) {
      return res.send({
        status: 400,
        message: "something went wrong",
      });
    } else {
      if (partnerData) {
        goalSerObject.getGoalSettings(function (err, settingData) {
          if (err) {
            return res.send({
              status: 500,
              message: "There was a problem finding the user setting.",
            });
          } else {
            if (settingData) {
              goalSerObject.getGoalSettingsAnswer(partnerData.id, function (err, GetquestionWithOption) {
                if (err) {
                  return res.send({
                    status: 404,
                    message: "something went wrong",
                  });
                } else {
                  if (GetquestionWithOption) {
                    return res.send({
                      status: 200,
                      settings: GetquestionWithOption,
                    });
                  } else {
                    return res.send({
                      status: 504,
                      message: "Quetionaries is not avaliable.",
                    });
                  }
                }
              });
            } else {
              return res.send({
                status: 404,
                message: "Question is not found.",
              });
            }
          }
        });
      } else {
        return res.send({
          status: 504,
          messgae: "Patner is not found",
        });
      }
    }
  });
});

// Save user setting detail
router.post("/savegoalsettings", verifyToken, function (req, res) {
  let user_id = jwt.decode(req.headers["x-access-token"]).id;
  let skip = req.body.skip;
  // if(!question_id)
  // {
  // 	return res.send({
  // 		status: 400,
  // 		message: 'Question Id is required.',
  // 	});
  // }

  // if(!formValidator.isInt(question_id))
  // {
  // 	return res.send({
  // 		status: 400,
  // 		message: 'Please enter a valid question id.',
  // 	});
  // }

  // if(!answer)
  // {
  // 	return res.send({
  // 		status: 400,
  // 		message: 'Answer is required',
  // 	});
  // }
  if (skip) {
    userSerObject.updateUserStage(9, user_id, function (err, updatedStage) {
      if (updatedStage) {
        userSerObject.getPartnerById(user_id, function (err, patnerData) {
          if (err) {
            return res.send({
              status: 400,
              message: "something went wrong",
            });
          } else {
            if (patnerData) {
              return res.send({
                status: 200,
                message: "Question answer is saved successfully",
                user_stage: updatedStage.stage,
              });
            } else {
              return res.send({
                status: 504,
                messgae: "Patner is not found",
              });
            }
          }
        });
      }
    });
  } else {
    req.body.map((response) => {
      // Check setting question exists or not
      goalSerObject.getGoalSettingsQuestionById(response.question_id, function (err, goalQuestionData) {
        if (err) {
          return res.send({
            status: 500,
            message: "something went wrong",
          });
        } else {
          if (goalQuestionData) {
            let goalSettingData = {
              question_id: response.question_id,
              answer: response.answer,
              user_id: user_id,
              custom_answer: response.custom_answer ? response.custom_answer : null,
            };
            goalSerObject.saveSettings(goalSettingData, function (err, goalSettingDataSaved) {
              if (err) {
                return res.send({
                  status: 500,
                  message: "something went wrong",
                });
              } else {
                userSerObject.updateUserStage(9, user_id, function (err, updatedStage) {
                  if (updatedStage) {
                    userSerObject.getPartnerById(user_id, function (err, patnerData) {
                      if (err) {
                        return res.send({
                          status: 400,
                          message: "something went wrong",
                        });
                      } else {
                        if (patnerData) {
                          return res.send({
                            status: 200,
                            message: "Question answer is saved successfully",
                            user_stage: updatedStage.stage,
                          });
                        } else {
                          return res.send({
                            status: 504,
                            messgae: "Patner is not found",
                          });
                        }
                      }
                    });
                  }
                });
              }
            });
          } else {
            return res.send({
              status: 400,
              message: "Question is not found",
            });
          }
        }
      });
    });
  }
});

// Compare user security code
router.post("/checkuseruniquecode", verifyToken, function (req, res) {
  let user_id = req.body.user_id;
  let unique_code = req.body.unique_code;

  if (!user_id) {
    return res.send({
      status: 400,
      message: "User Id is required.",
    });
  }

  if (!formValidator.isInt(user_id)) {
    return res.send({
      status: 400,
      message: "Please enter a valid user id.",
    });
  }

  if (!unique_code) {
    return res.send({
      status: 400,
      message: "Unique code is required.",
    });
  }

  if (!formValidator.isAlpha(unique_code)) {
    return res.send({
      status: 400,
      message: "Please enter a valid unique code.",
    });
  }

  // Check user exists or not
  userSerObject.getUserById(user_id, function (err, userData) {
    if (err) {
      return res.send({
        status: 500,
        message: "something went wrong",
      });
    } else {
      if (userData) {
        // Check security code exists or not
        userSerObject.checkUniqueCode(unique_code, function (err, uniqueCodeData) {
          if (err) {
            return res.send({
              status: 500,
              message: "something went wrong",
            });
          } else {
            if (uniqueCodeData) {
              if (user_id == uniqueCodeData.id) {
                return res.send({
                  status: 400,
                  message: "Partner-Id should be different.",
                });
              }

              let monthlyGoalData = {
                partner_one_id: user_id,
                partner_two_id: uniqueCodeData.id,
              };
              goalSerObject.checkParterLink(monthlyGoalData, function (err, partnerData) {
                if (err) {
                  return res.send({
                    status: 500,
                    message: "something went wrong",
                  });
                } else {
                  if (partnerData) {
                    userSerObject.getUserById(uniqueCodeData.id, function (err, response) {
                      if (err) {
                        return res.send({
                          status: 400,
                          message: "Your patner is not found",
                        });
                      } else {
                        if (response) {
                          if (response.stage !== 3) {
                            return res.send({
                              status: 200,
                              message: "Please Wait, Your parten is not entered code!",
                              paring: 0,
                            });
                          }
                          if (response.stage === 3) {
                            // userSerObject.freeSecurityCodes(monthlyGoalData, function(err, freeSecurityData){
                            userSerObject.updateUserStage(4, user_id, function (err, userStageupdatedata) {
                              if (userStageupdatedata) {
                                return res.send({
                                  status: 400,
                                  message: "These users are already linked.",
                                  stage: userStageupdatedata.stage,
                                });
                              }
                            });
                            // }
                          }
                        } else {
                          return res.send({
                            status: 504,
                            message: "Patner is not found",
                          });
                        }
                      }
                    });
                  } else {
                    userSerObject.updateUserStage(3, user_id, function (err, userStageupdatedata) {
                      if (userStageupdatedata) {
                        goalSerObject.createPartnerMapping(monthlyGoalData, function (err, createMonthlyData) {
                          if (err) {
                            return res.send({
                              status: 500,
                              message: "something went wrong",
                            });
                          } else {
                            if (createMonthlyData) {
                              userSerObject.getUserById(uniqueCodeData.id, function (err, response) {
                                if (err) {
                                  return res.send({
                                    status: 400,
                                    message: "Your patner is not found",
                                  });
                                } else {
                                  if (response) {
                                    if (response.stage !== 3) {
                                      // setTimeout(()=>{
                                      // 	userSerObject.getUserById(uniqueCodeData.id, function(err, responseData){
                                      // 		if(responseData.stage < 4 ){
                                      // 			userSerObject.getPartnerById(user_id, function(err, userStageupdatedata) {
                                      // 				userSerObject.RemoveParring(user_id, function(err, removeUserData){
                                      // 					if(err){
                                      // 						console.log(err);
                                      // 					}
                                      // 				})
                                      // 				userSerObject.updateUserStage(2, user_id, function(err, updatepatnerStage){
                                      // 					if(err){
                                      // 						console.log(err);
                                      // 					}
                                      // 				})
                                      // 			})
                                      // 		}
                                      // 	})
                                      // },108000);
                                      return res.send({
                                        status: 200,
                                        message: "Please Wait, Your parten is not entered code!",
                                        FCMID: uniqueCodeData.fcmid,
                                        paring: 0,
                                      });
                                    }
                                    if (response.stage === 3) {
                                      // userSerObject.freeSecurityCodes(monthlyGoalData, function(err, freeSecurityData){
                                      userSerObject.updateUserStage(4, user_id, function (err, userStageupdatedata) {
                                        if (userStageupdatedata) {
                                          userSerObject.updateUserStage(
                                            4,
                                            monthlyGoalData.partner_two_id,
                                            function (err, updatepatnerStage) {
                                              if (updatepatnerStage) {
                                                goalSerObject.AddUniqueId(user_id, function (err, updated) {
                                                  if (updated) {
                                                    return res.send({
                                                      status: 200,
                                                      message: "Paring sucessfully",
                                                      stage: userStageupdatedata.stage,
                                                      FCMID: uniqueCodeData.fcmid,
                                                      paring: 1,
                                                    });
                                                  }
                                                });
                                              }
                                            }
                                          );
                                        }
                                      });
                                      // }
                                    }
                                  } else {
                                    return res.send({
                                      status: 504,
                                      message: "Something went Wrong",
                                    });
                                  }
                                }
                              });
                            } else {
                              return res.send({
                                status: 400,
                                message: "Something went wrong.",
                              });
                            }
                          }
                        });
                      } else {
                        return res.send({
                          status: 400,
                          message: "something went wrong",
                        });
                      }
                    });
                  }
                }
              });
            } else {
              return res.send({
                status: 400,
                message: "Your Partner's code does not match",
                paring: 2,
              });
            }
          }
        });
      } else {
        return res.send({
          status: 400,
          message: "User is not found",
        });
      }
    }
  });
});

// Get partner mapping
router.post("/getpartnermapping", verifyToken, function (req, res) {
  let partner_one_id = req.body.partner_one_id;
  let partner_two_id = req.body.partner_two_id;

  if (!partner_one_id) {
    return res.send({
      status: 400,
      message: "First partner id is required.",
    });
  }

  if (!formValidator.isInt(partner_one_id)) {
    return res.send({
      status: 400,
      message: "Please enter a valid first partner id.",
    });
  }

  if (!partner_two_id) {
    return res.send({
      status: 400,
      message: "Second partner Id is required.",
    });
  }

  if (!formValidator.isInt(partner_two_id)) {
    return res.send({
      status: 400,
      message: "Please enter a valid second partner id.",
    });
  }

  let partneMappingData = {
    partner_one_id: partner_one_id,
    partner_two_id: partner_two_id,
  };

  goalSerObject.checkParterLink(partneMappingData, function (err, partnersData) {
    if (partnersData.status) {
      if (err) {
        return res.send({
          status: 500,
          message: "something went wrong",
        });
      } else {
        if (partnersData) {
          return res.send({
            status: 200,
            partnerMappingData: partnersData,
          });
        } else {
          return res.send({
            status: 504,
            message: "Something went is wrong",
          });
        }
      }
    } else {
      return res.send({
        status: 403,
        message: "This mapping has been expired",
      });
    }
  });
});

// Create monthly goal
router.post("/createmonthlygoal", verifyToken, function (req, res) {
  // let partner_mapping_id = req.body.partner_mapping_id;
  let user_id = jwt.decode(req.headers["x-access-token"]).id;
  let connect_number = req.body.connect_number;
  // let percentage         = req.body.percentage;/
  let intimate_account_time = req.body.intimate_account_time;
  let intimate_request_time = req.body.intimate_request_time;
  let intimate_time = req.body.intimate_time;
  let initiator_count = req.body.initiator_count;
  let initiator_count1 = req.body.initiator_count1;
  let hours = req.body.hours;

  if (!user_id) {
    return res.send({
      status: 400,
      message: "User id is required.",
    });
  }

  if (!formValidator.isInt(user_id)) {
    return res.send({
      status: 400,
      message: "Please enter a valid user id.",
    });
  }

  if (!connect_number) {
    return res.send({
      status: 400,
      message: "Please enter a valid information.",
    });
  }

  if (!formValidator.isInt(connect_number)) {
    return res.send({
      status: 400,
      message: "Please enter a valid information.",
    });
  }

  if (!intimate_account_time) {
    return res.send({
      status: 400,
      message: "Please enter a valid information.",
    });
  }

  if (!intimate_request_time) {
    return res.send({
      status: 400,
      message: "Please enter a valid information.",
    });
  }

  if (!intimate_time) {
    return res.send({
      status: 400,
      message: "Please enter a valid information.",
    });
  }

  if (!initiator_count) {
    return res.send({
      status: 400,
      message: "Please enter a valid information.",
    });
  }

  if (!initiator_count1) {
    return res.send({
      status: 400,
      message: "Please enter a valid information.",
    });
  }
  // Check goal exists or not

  goalSerObject.checkParternstage(user_id, function (err, partnerMappingData) {
    if (err) {
      return res.send({
        status: 500,
        message: "something went wrong",
      });
    } else {
      if (partnerMappingData) {
        userSerObject.getUserById(partnerMappingData.partner_two_id, function (err, partenerData) {
          if (err) {
            return res.send({
              status: 400,
              message: "Invalid partner id provided",
            });
          } else {
            if (partenerData) {
              if (partenerData.stage === 7) {
                return res.send({
                  status: 400,
                  message: "Please Wait! The goal setup is already in progress by your partner.",
                });
              } else {
                var user_checker = 0;
                if (partnerMappingData.partner_one_id == user_id) {
                  user_checker++;
                }

                if (partnerMappingData.partner_two_id == user_id) {
                  user_checker++;
                }

                if (user_checker == 0) {
                  return res.send({
                    status: 400,
                    message: "Invalid partner id provided",
                  });
                } else {
                  userSerObject.updateUserStage(5, user_id, function (er, updateedstage) { });
                  const now = new Date();
                  var parter_id = 0;
                  if (partnerMappingData.partner_one_id != user_id) {
                    parter_id = partnerMappingData.partner_one_id;
                  }
                  if (partnerMappingData.partner_two_id != user_id) {
                    parter_id = partnerMappingData.partner_two_id;
                  }
                  // var initiator_count = customHelper.h_getNumberOfTimesPercentage(connect_number, percentage);
                  // var partner_percentage = 100 - percentage;
                  // var partner_initiator_count = connect_number - initiator_count;
                  let monthlyGoalData = {
                    partner_mapping_id: partnerMappingData.id,
                    user_id: user_id,
                    month_start: current_datetime.format(now, "YYYY-MM-DD"),
                    month_end: customHelper.h_get30daysAdvanceDate(),
                    connect_number: connect_number,
                    // 'percentage': percentage,
                    initiator_count: initiator_count,
                    initiator_count1: initiator_count1,
                    status: 1,
                    intimate_time: intimate_time,
                    intimate_request_time: intimate_request_time,
                    intimate_account_time: intimate_account_time,
                    partner_id: parter_id,
                    // 'partner_percentage': partner_percentage,
                    partner_initiator_count: initiator_count,
                    hours: hours,
                  };
                  goalSerObject.createMonthlyGoal(monthlyGoalData, function (err, monthlyGoalDataSaved) {
                    if (err) {
                      userSerObject.updateUserStage(4, parter_id, function (er, updateedstage) { });
                      return res.send({
                        status: 504,
                        message: "something went wrong.",
                      });
                    } else {
                      let updateStage = {
                        user_id: user_id,
                        partner_id: parter_id,
                        stage: 8,
                      };
                      userSerObject.updateBothPartnerStage(updateStage, function (err, updatedStage) {
                        if (updatedStage) {
                          userSerObject.getUserById(user_id, function (err, userData) {
                            if (err) {
                              return res.send({
                                status: 400,
                                message: "something went wrong.",
                              });
                            } else {
                              if (userData) {
                                userSerObject.getPartnerById(user_id, function (err, partnerData) {
                                  if (err) {
                                    return res.send({
                                      status: 400,
                                      message: "something went wrong.",
                                    });
                                  } else {
                                    if (partnerData) {

                                      const [time, modifier] = monthlyGoalDataSaved.intimate_request_time.split(" ");
                                      let [hours, minutes] = time.split(":");
                                      if (hours === "12") {
                                        hours = "00";
                                      }
                                      if (modifier === "PM") {
                                        hours = parseInt(hours, 10) + 12;
                                      }
                                      var night = new Date(
                                        now.getFullYear(),
                                        now.getMonth(),
                                        now.getDate(),
                                        hours,
                                        minutes,
                                        0
                                      );
                                      var month = current_datetime.format(night, "MM", true);
                                      var year = current_datetime.format(night, "YYYY", true);
                                      minutes = current_datetime.format(night, "mm");
                                      hours = current_datetime.format(night, "HH");
                                      let day = parseInt(
                                        new Date(year, month, 0).getDate() / monthlyGoalDataSaved.connect_number
                                      );
                                      if (day <= 0) {
                                        day = 1;
                                      }
                                      let day1 = parseInt(new Date().getDate());
                                      //${parseInt(minutes)} ${hours} ${day1} ${month} *
                                      schedules1 = cron.schedule(`${parseInt(minutes)} ${hours} ${day1} ${month} *`,
                                        () => {
                                          // cron.schedule(`* * * * *`, (err, ress) => {
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
                                            goalSerObject.getGoalDetails(
                                              userData.id,
                                              partnerData.id,
                                              function (err, monthlyGoal_data) {

                                                if (err) {
                                                  return res.send({
                                                    status: 404,
                                                    message: "Something went wrong!",
                                                  });
                                                } else {

                                                  if (monthlyGoal_data) {
                                                    let contribution1 = monthlyGoal_data.contribution1;
                                                    let contribution2 = monthlyGoal_data.contribution2;
                                                    let initiator_count1 = monthlyGoal_data.initiator_count;
                                                    let initiator_count2 = monthlyGoal_data.initiator_count1;
                                                    let connect_number = monthlyGoal_data.connect_number;
                                                    let totalcontribution1 = connect_number * initiator_count1 / 100
                                                    let totalcontribution2 = connect_number * initiator_count2 / 100
                                                    let ct1 = contribution1 * 100 / totalcontribution1
                                                    let ct2 = contribution2 * 100 / totalcontribution2
                                                    let Check = false;

                                                    if (user_id != monthlyGoal_data.user_id) {
                                                      if (ct1 < ct2) {
                                                        Check = false;
                                                      }
                                                      else if (ct2 < ct1) {
                                                        Check = true;
                                                      }
                                                      else if (ct1 === ct2) {
                                                        if (initiator_count1 < initiator_count2) {
                                                          Check = true;
                                                        }
                                                        else if (initiator_count2 < initiator_count1) {
                                                          Check = false;
                                                        }
                                                        else {
                                                          Check = false;
                                                        }
                                                      }
                                                    }
                                                    else {
                                                      if (ct1 < ct2) {
                                                        Check = true;
                                                      }
                                                      else if (ct2 < ct1) {
                                                        Check = false;
                                                      }
                                                      else if (ct1 === ct2) {
                                                        if (initiator_count1 < initiator_count2) {
                                                          Check = false;
                                                        }
                                                        else if (initiator_count2 < initiator_count1) {
                                                          Check = true;
                                                        }
                                                        else {
                                                          Check = true;
                                                        }
                                                      }
                                                    }
                                                    let quikceydata = {
                                                      user_id: Check === true ? monthlyGoal_data.user_id : partnerData.id,
                                                      partner_mapping_id: partnerMappingData.id,

                                                    }
                                                    quickynObject.saveQuickybeforenotification(quikceydata, function (err, quickeydata) {
                                                      if (err) {
                                                        res.send({
                                                          status: 404,
                                                          message: "Something went wrong!!"
                                                        })
                                                      } else {
                                                        var date = new Date();
                                                        var Startdate = new Date(monthlyGoal_data.month_start).getTime();
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

                                                        let notification1 = {
                                                          user_id: userData.id,
                                                          goal_id: monthlyGoalDataSaved.id,
                                                          device_id: userData.fcmid,
                                                          notification_id: "null",
                                                        };
                                                        notificationObject.saveNotification(
                                                          notification1,
                                                          function (err, response) {
                                                            let notificationdata = {
                                                              user_id: user_id,
                                                              title: "Dating",
                                                              message: `You are at ${Notificationmessage.PR}% of goal with ${Notificationmessage.remaing_days} days left in the month.
                                                                Would you like to make a connection tonight?`,
                                                              type: "remember",
                                                              checkans: Check,
                                                              quickey_id: quickeydata.id

                                                            }
                                                            notificationObject.addnotification(notificationdata,
                                                              function (err, response) {
                                                                notificationObject.notification(
                                                                  userData.fcmid,
                                                                  Notificationmessage,
                                                                  Check,
                                                                  response.id,
                                                                  response.quickey_id,
                                                                  function (err, response) {
                                                                  }
                                                                );
                                                              }
                                                            )
                                                          }
                                                        );
                                                        let notification12 = {
                                                          user_id: partnerData.id,
                                                          goal_id: monthlyGoalDataSaved.id,
                                                          device_id: partnerData.fcmid,
                                                          notification_id: "null",
                                                        };
                                                        notificationObject.saveNotification(
                                                          notification12,
                                                          function (err, response) {
                                                            let notificationdata = {
                                                              user_id: partnerData.id,
                                                              title: "Dating",
                                                              message: `You are at ${Notificationmessage.PR}% of goal with ${Notificationmessage.remaing_days} days left in the month.
                                                                Would you like to make a connection tonight?`,
                                                              type: "remember",
                                                              checkans: !Check,
                                                              quickey_id: quickeydata.id
                                                            }
                                                            notificationObject.addnotification(notificationdata,
                                                              function (err, response) {
                                                                notificationObject.notification(
                                                                  partnerData.fcmid,
                                                                  Notificationmessage,
                                                                  !Check,
                                                                  response.id,
                                                                  response.quickey_id,
                                                                  function (err, response) {
                                                                  }
                                                                );
                                                              }
                                                            )
                                                          }
                                                        );

                                                      }
                                                    })

                                                    //${parseInt(minutes)} ${hours} */${day} * *
                                                    //end
                                                    schedules = cron.schedule(`${parseInt(minutes)} ${hours} */${day} * *`, () => {
                                                      // cron.schedule(`* * * * *`, (err, ress) => {
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
                                                        goalSerObject.getGoalDetails(
                                                          userData.id,
                                                          partnerData.id,
                                                          function (err, monthlyGoal_data) {
                                                            if (err) {
                                                              return res.send({
                                                                status: 404,
                                                                message: "Something went wrong!",
                                                              });
                                                            } else {

                                                              if (monthlyGoal_data) {
                                                                let contribution1 = monthlyGoal_data.contribution1;
                                                                let contribution2 = monthlyGoal_data.contribution2;
                                                                let initiator_count1 = monthlyGoal_data.initiator_count;
                                                                let initiator_count2 = monthlyGoal_data.initiator_count1;
                                                                let connect_number = monthlyGoal_data.connect_number;

                                                                let totalcontribution1 = connect_number * initiator_count1 / 100
                                                                let totalcontribution2 = connect_number * initiator_count2 / 100
                                                                let ct1 = contribution1 * 100 / totalcontribution1
                                                                let ct2 = contribution2 * 100 / totalcontribution2
                                                                let Check = false;
                                                                if (user_id != monthlyGoal_data.user_id) {
                                                                  if (ct1 < ct2) {
                                                                    Check = false
                                                                  }
                                                                  else if (ct2 < ct1) {
                                                                    Check = true
                                                                  }
                                                                  else if (ct1 === ct2) {
                                                                    if (initiator_count1 < initiator_count2) {
                                                                      Check = true
                                                                    }
                                                                    else if (initiator_count2 < initiator_count1) {
                                                                      Check = false
                                                                    }
                                                                    else {
                                                                      Check = false;
                                                                    }
                                                                  }
                                                                }
                                                                else {
                                                                  if (ct1 < ct2) {
                                                                    Check = true
                                                                  }
                                                                  else if (ct2 < ct1) {
                                                                    Check = false
                                                                  }
                                                                  else if (ct1 === ct2) {
                                                                    if (initiator_count1 < initiator_count2) {
                                                                      Check = false
                                                                    }
                                                                    else if (initiator_count2 < initiator_count1) {
                                                                      Check = true
                                                                    }
                                                                    else {
                                                                      Check = true;
                                                                    }
                                                                  }
                                                                }


                                                                let quikceydata = {
                                                                  user_id: Check === true ? monthlyGoal_data.user_id : partnerData.id,
                                                                  partner_mapping_id: partnerMappingData.id,

                                                                }
                                                                quickynObject.saveQuickybeforenotification(quikceydata, function (err, quickeydata) {
                                                                  if (quickeydata) {
                                                                    return res.send({
                                                                      status: 404,
                                                                      message: "Something went wrong!!"
                                                                    })
                                                                  }
                                                                  else {
                                                                    var date = new Date();
                                                                    var Startdate = new Date(
                                                                      monthlyGoal_data.month_start
                                                                    ).getTime();
                                                                    var lastDay = new Date(
                                                                      monthlyGoal_data.month_end
                                                                    ).getTime();
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
                                                                    let notification1 = {
                                                                      user_id: userData.id,
                                                                      goal_id: monthlyGoalDataSaved.id,
                                                                      device_id: userData.fcmid,
                                                                      notification_id: "null",
                                                                    };
                                                                    notificationObject.saveNotification(
                                                                      notification1,
                                                                      function (err, response) {
                                                                        let notificationdata = {
                                                                          user_id: user_id,
                                                                          title: "Dating",
                                                                          message: `You are at ${Notificationmessage.PR}% of goal with ${Notificationmessage.remaing_days} days left in the month.
                                                                            Would you like to make a connection tonight?`,
                                                                          type: "remember",
                                                                          checkans: Check,
                                                                          quickey_id: quickeydata.id
                                                                        }
                                                                        notificationObject.addnotification(notificationdata,
                                                                          function (err, response) {
                                                                            notificationObject.notification(
                                                                              userData.fcmid,
                                                                              Notificationmessage,
                                                                              Check,
                                                                              response.id,
                                                                              response.quickey_id,
                                                                              function (err, response) {

                                                                              }
                                                                            );
                                                                          }
                                                                        )
                                                                      }
                                                                    );

                                                                    let notification12 = {
                                                                      user_id: partnerData.id,
                                                                      goal_id: monthlyGoalDataSaved.id,
                                                                      device_id: partnerData.fcmid,
                                                                      notification_id: "null",
                                                                    };
                                                                    notificationObject.saveNotification(
                                                                      notification12,
                                                                      function (err, response) {
                                                                        let notificationdata = {
                                                                          user_id: partnerData.id,
                                                                          title: "Dating",
                                                                          message: `You are at ${Notificationmessage.PR}% of goal with ${Notificationmessage.remaing_days} days left in the month.
                                                                           Would you like to make a connection tonight?`,
                                                                          type: "remember",
                                                                          checkans: !Check,
                                                                          quickey_id: quickeydata.id
                                                                        }
                                                                        notificationObject.addnotification(notificationdata,
                                                                          function (err, response) {
                                                                            notificationObject.notification(
                                                                              partnerData.fcmid,
                                                                              Notificationmessage,
                                                                              !Check,
                                                                              response.id,
                                                                              response.quickey_id,
                                                                              function (err, response) {
                                                                              }
                                                                            );
                                                                          }
                                                                        )
                                                                      }
                                                                    );
                                                                  }
                                                                })

                                                              }


                                                            }
                                                          });
                                                      }
                                                    }
                                                    );
                                                  }
                                                }
                                              }
                                            );
                                          }
                                        },
                                        {
                                          scheduled: false,
                                        }
                                      );
                                      schedules1.start();
                                      return res.send({
                                        status: 200,
                                        message: "The monthly goal has been successfully created.",
                                        stage: userData.stage,
                                        fcmid: partnerData.fcmid,
                                        Patner1_first_name: userData.first_name,
                                        Patner1_last_name: userData.last_name,
                                        patner1_stage: userData.stage,
                                        Patner2_first_name: partnerData.first_name,
                                        Patner2_last_name: partnerData.last_name,
                                        patner2_stage: partnerData.stage,
                                      });
                                    } else {
                                      return res.send({
                                        status: 500,
                                        message: "Partner is not found.",
                                      });
                                    }
                                  }
                                });
                              } else {
                                return res.send({
                                  status: 500,
                                  message: "User is not found.",
                                });
                              }
                            }
                          });
                        }
                      });
                    }
                  });
                }
              }
            } else {
              return res.send({
                status: 504,
                messgae: "Patner is not found",
              });
            }
          }
        });
        // check if user-id is found or not in partner mapping table
      } else {
        return res.send({
          status: 400,
          message: "This mapping has been expired",
        });
      }
    }
  });
});

// Checking user enter goal page or not
router.post("/CheckingStage", verifyToken, function (req, res) {
  let user_id = jwt.decode(req.headers["x-access-token"]).id;
  if (!user_id) {
    return res.send({
      status: 400,
      message: "User id is required.",
    });
  }

  userSerObject.getUserById(user_id, function (err, userDetails) {
    if (err) {
      return res.send({
        status: 400,
        message: "something went wrong",
      });
    } else {
      if (userDetails) {
        goalSerObject.getPartnerData(user_id, function (err, partnerMappingData) {
          if (err) {
            return res.send({
              status: 500,
              message: "something went wrong",
            });
          } else {
            if (partnerMappingData) {
              userSerObject.getUserById(partnerMappingData.partner_two_id, function (err, partenerData) {
                if (err) {
                  return res.send({
                    status: 400,
                    message: "Invalid partner id provided",
                  });
                } else {
                  if (partenerData) {
                    if (partenerData.stage === 4 && userDetails.stage === 4) {
                      if (userDetails.receipt || partenerData.receipt) {
                        let PatnerData = userDetails.receipt ? userDetails : partenerData;
                        SubscripationObject.VerifyReceipt(PatnerData, function (err, VerifyData) {
                          if (err) {
                            return res.send({
                              status: 404,
                              message: "something went wrong",
                            });
                          } else {
                            if (VerifyData) {
                              if (VerifyData.data.expire_at) {
                                let currentDate = current_datetime.format(new Date(), "YYYY-MM-DD HH:mm:ss", true);
                                let expiryDate = current_datetime.format(
                                  new Date(parseInt(VerifyData.data.expire_at || VerifyData.data.expire_at)),
                                  "YYYY-MM-DD HH:mm:ss",
                                  true
                                );
                                currentDate = new Date(currentDate);
                                expiryDate = new Date(expiryDate);
                                if (currentDate.getTime() < expiryDate.getTime()) {
                                  userSerObject.updateUserStage(7, user_id, function (err, updatestageData) {
                                    if (updatestageData) {
                                      return res.send({
                                        status: 200,
                                        message:
                                          "You and Your Patner's plan is active! and Sucessfully enter Goal page",
                                        userStage: updatestageData.stage,
                                        partner_stage: partenerData.stage,
                                      });
                                    } else {
                                      return res.send({
                                        status: 400,
                                        message: "Something Went wrong",
                                      });
                                    }
                                  });
                                } else {
                                  if (partenerData.receipt) {
                                    SubscripationObject.VerifyReceipt(PatnerData, function (err, VerifyData) {
                                      if (err) {
                                        return res.send({
                                          status: 404,
                                          message: "something went wrong",
                                        });
                                      } else {
                                        if (VerifyData) {
                                          if (VerifyData.data.expire_at) {
                                            let currentDate = current_datetime.format(
                                              new Date(),
                                              "YYYY-MM-DD HH:mm:ss",
                                              true
                                            );
                                            let expiryDate = current_datetime.format(
                                              new Date(parseInt(VerifyData.data.expire_at)),
                                              "YYYY-MM-DD HH:mm:ss",
                                              true
                                            );
                                            currentDate = new Date(currentDate);
                                            expiryDate = new Date(expiryDate);
                                            if (currentDate.getTime() < expiryDate.getTime()) {
                                              userSerObject.updateUserStage(
                                                7,
                                                user_id,
                                                function (err, updatestageData) {
                                                  if (updatestageData) {
                                                    return res.send({
                                                      status: 200,
                                                      message:
                                                        "You and Your Patner's plan is active! and Sucessfully enter Goal page",
                                                      userStage: updatestageData.stage,
                                                      partner_stage: partenerData.stage,
                                                    });
                                                  } else {
                                                    return res.send({
                                                      status: 400,
                                                      message: "Something Went wrong",
                                                    });
                                                  }
                                                }
                                              );
                                            } else {
                                              userSerObject.getPartnerById(user_id, function (err, userPartnerData) {
                                                if (err) {
                                                  return res.send({
                                                    status: 404,
                                                    message: "Something went wrong!",
                                                  });
                                                } else {
                                                  if (userPartnerData) {
                                                    if (userPartnerData.stage == 5) {
                                                      return res.send({
                                                        status: 400,
                                                        message: "Please Wait, Your partner is doing payment",
                                                      });
                                                    } else {
                                                      setTimeout(() => {
                                                        userSerObject.getPartnerById(
                                                          user_id,
                                                          function (err, userPartnerData) {
                                                            if (userPartnerData.stage == 5) {
                                                              let updateStage = {
                                                                user_id: user_id,
                                                                partner_id: partnerMappingData.partner_two_id,
                                                                stage: 4,
                                                              };
                                                              userSerObject.updateBothPartnerStage(
                                                                updateStage,
                                                                function (err, updatedStage) { }
                                                              );
                                                            }
                                                          }
                                                        );
                                                      }, 300000);
                                                      userSerObject.updateUserStage(
                                                        5,
                                                        user_id,
                                                        function (err, updatestageData) {
                                                          if (updatestageData) {
                                                            return res.send({
                                                              status: 200,
                                                              message:
                                                                "You and Your Patner's plan are expired! and Sucessfully enter payment page",
                                                              userStage: updatestageData.stage,
                                                              partner_stage: partenerData.stage,
                                                            });
                                                          } else {
                                                            return res.send({
                                                              status: 400,
                                                              message: "Something Went wrong",
                                                            });
                                                          }
                                                        }
                                                      );
                                                    }
                                                  } else {
                                                    return res.send({
                                                      status: 404,
                                                      message: "Partner is not found!",
                                                    });
                                                  }
                                                }
                                              });
                                            }
                                          } else {
                                            return res.send({
                                              status: 200,
                                              message: "Please Buy subscripation",
                                            });
                                          }
                                        } else {
                                        }
                                      }
                                    });
                                  } else {
                                    userSerObject.updateUserStage(5, user_id, function (err, updatestageData) {
                                      setTimeout(() => {
                                        userSerObject.getPartnerById(user_id, function (err, userPartnerData) {
                                          if (userPartnerData.stage == 5) {
                                            let updateStage = {
                                              user_id: user_id,
                                              partner_id: partnerMappingData.partner_two_id,
                                              stage: 4,
                                            };
                                            userSerObject.updateBothPartnerStage(
                                              updateStage,
                                              function (err, updatedStage) { }
                                            );
                                          }
                                        });
                                      }, 300000);
                                      if (updatestageData) {
                                        return res.send({
                                          status: 200,
                                          message:
                                            "You and Your Patner's plan are expired! and Sucessfully enter payment page",
                                          userStage: updatestageData.stage,
                                          partner_stage: partenerData.stage,
                                        });
                                      } else {
                                        return res.send({
                                          status: 400,
                                          message: "Something Went wrong",
                                        });
                                      }
                                    });
                                  }
                                }
                              } else {
                                return res.send({
                                  status: 200,
                                  message: "Please Buy subscripation",
                                });
                              }
                            } else {
                            }
                          }
                        });
                      } else {
                        setTimeout(() => {
                          userSerObject.getPartnerById(user_id, function (err, userPartnerData) {
                            if (userPartnerData.stage == 5) {
                              let updateStage = {
                                user_id: user_id,
                                partner_id: partnerMappingData.partner_two_id,
                                stage: 4,
                              };
                              userSerObject.updateBothPartnerStage(updateStage, function (err, updatedStage) {
                              });
                            }
                          });
                        }, 300000);
                        userSerObject.updateUserStage(5, user_id, function (err, updatestageData) {
                          if (updatestageData) {
                            return res.send({
                              status: 200,
                              message: "Sucessfully enter payment page",
                              userStage: updatestageData.stage,
                              partner_stage: partenerData.stage,
                            });
                          } else {
                            return res.send({
                              status: 400,
                              message: "Something Went wrong",
                            });
                          }
                        });
                      }
                    }
                    if (partenerData.stage === 5 && userDetails.stage === 4) {
                      setTimeout(() => {
                        userSerObject.getPartnerById(user_id, function (err, userPartnerData) {
                          if (userPartnerData.stage == 5) {
                            let updateStage = {
                              user_id: user_id,
                              partner_id: partnerMappingData.partner_two_id,
                              stage: 4,
                            };
                            userSerObject.updateBothPartnerStage(updateStage, function (err, updatedStage) { });
                          }
                        });
                      }, 30000);

                      return res.send({
                        status: 400,
                        message: "Please Wait, Your partner is doing payment",
                      });
                    }
                    if (partenerData.stage === 4 && userDetails.stage === 5) {
                      return res.send({
                        status: 200,
                        message: "You are already on payment page",
                      });
                    }
                    if (partenerData.stage === 6 && userDetails.stage === 6) {
                      userSerObject.updateUserStage(7, user_id, function (err, updatestageData) {
                        if (updatestageData) {
                          return res.send({
                            status: 200,
                            message: "Sucessfully enter goal page",
                            userStage: updatestageData.stage,
                            partner_stage: partenerData.stage,
                          });
                        } else {
                          return res.send({
                            status: 400,
                            message: "Something Went wrong",
                          });
                        }
                      });
                    }
                    if (partenerData.stage === 7 && userDetails.stage < 7) {
                      return res.send({
                        status: 400,
                        message: "Please Wait, Your partner is already setting goal",
                      });
                    }
                    if (partenerData.stage < 7 && userDetails.stage === 7) {
                      return res.send({
                        status: 200,
                        message: "You are already on Goal page",
                        userStage: userDetails.stage,
                        partner_stage: partenerData.stage,
                      });
                    }
                    if (partenerData.stage === 8 && userDetails.stage === 8) {
                      return res.send({
                        status: 200,
                        message: "Goal already created",
                        userStage: userDetails.stage,
                        partner_stage: partenerData.stage,
                      });
                    }
                    if (partenerData.stage === 8 && userDetails.stage === 5) {
                      return res.send({
                        status: 200,
                        message: "Questionaries Saved",
                        userStage: userDetails.stage,
                        partner_stage: partenerData.stage,
                      });
                    }
                    if (partenerData.stage < 4) {
                      return res.send({
                        status: 400,
                        messgae: "Paring is not save successfully",
                        userStage: userDetails.stage,
                      });
                    }
                    if (userDetails.stage > 4 && userDetails.stage < 8) {
                      return res.send({
                        status: 200,
                        message: "User stage already updated",
                        userStage: userDetails.stage,
                        partner_stage: partenerData.stage,
                      });
                    }
                    if (partenerData.stage === 6 && userDetails.stage < 6) {
                      userSerObject.updateUserStage(5, userDetails.id, function (err, updatestageData) {
                        if (updatestageData) {
                          userSerObject.updateUserStage(6, user_id, function (err, updatestageData) {
                            if (updatestageData) {
                              return res.send({
                                status: 200,
                                message: "Sucessfully enter goal page",
                                userStage: updatestageData.stage,
                                partner_stage: partenerData.stage,
                              });
                            } else {
                              return res.send({
                                status: 400,
                                message: "Something Went wrong",
                              });
                            }
                          });
                        } else {
                          return res.send({
                            status: 400,
                            message: "Something Went wrong",
                          });
                        }
                      });
                    }
                    if (partenerData.stage >= 8 && userDetails.stage === 4) {
                      if (userDetails.receipt || partenerData.receipt) {
                        let PatnerData = userDetails.receipt ? userDetails : partenerData;
                        SubscripationObject.VerifyReceipt(PatnerData, function (err, VerifyData) {
                          if (err) {
                            return res.send({
                              status: 404,
                              message: "something went wrong",
                            });
                          } else {
                            if (VerifyData) {
                              if (VerifyData.data.expire_at) {
                                let currentDate = current_datetime.format(new Date(), "YYYY-MM-DD HH:mm:ss", true);
                                let expiryDate = current_datetime.format(
                                  new Date(parseInt(VerifyData.data.expire_at)),
                                  "YYYY-MM-DD HH:mm:ss",
                                  true
                                );
                                currentDate = new Date(currentDate);
                                expiryDate = new Date(expiryDate);
                                if (currentDate.getTime() < expiryDate.getTime()) {
                                  userSerObject.updateUserStage(7, user_id, function (err, updatestageData) {
                                    if (updatestageData) {
                                      return res.send({
                                        status: 200,
                                        message:
                                          "You and Your Patner's plan is active! and Sucessfully enter Goal page",
                                        userStage: updatestageData.stage,
                                        partner_stage: partenerData.stage,
                                      });
                                    } else {
                                      return res.send({
                                        status: 400,
                                        message: "Something Went wrong",
                                      });
                                    }
                                  });
                                } else {
                                  if (partenerData.receipt) {
                                    SubscripationObject.VerifyReceipt(PatnerData, function (err, VerifyData) {
                                      if (err) {
                                        return res.send({
                                          status: 404,
                                          message: "something went wrong",
                                        });
                                      } else {
                                        if (VerifyData) {
                                          if (VerifyData.data.expire_at) {
                                            let currentDate = current_datetime.format(
                                              new Date(),
                                              "YYYY-MM-DD HH:mm:ss",
                                              true
                                            );
                                            let expiryDate = current_datetime.format(
                                              new Date(parseInt(VerifyData.data.expire_at)),
                                              "YYYY-MM-DD HH:mm:ss",
                                              true
                                            );
                                            currentDate = new Date(currentDate);
                                            expiryDate = new Date(expiryDate);
                                            if (currentDate.getTime() < expiryDate.getTime()) {
                                              userSerObject.updateUserStage(
                                                7,
                                                user_id,
                                                function (err, updatestageData) {
                                                  if (updatestageData) {
                                                    return res.send({
                                                      status: 200,
                                                      message:
                                                        "You and Your Patner's plan is active! and Sucessfully enter Goal page",
                                                      userStage: updatestageData.stage,
                                                      partner_stage: partenerData.stage,
                                                    });
                                                  } else {
                                                    return res.send({
                                                      status: 400,
                                                      message: "Something Went wrong",
                                                    });
                                                  }
                                                }
                                              );
                                            } else {
                                              userSerObject.getPartnerById(user_id, function (err, userPartnerData) {
                                                if (err) {
                                                  return res.send({
                                                    status: 404,
                                                    message: "Something went wrong!",
                                                  });
                                                } else {
                                                  if (userPartnerData) {
                                                    if (userPartnerData.stage == 5) {
                                                      return res.send({
                                                        status: 400,
                                                        message: "Please Wait, Your partner is doing payment",
                                                      });
                                                    } else {
                                                      setTimeout(() => {
                                                        userSerObject.getPartnerById(
                                                          user_id,
                                                          function (err, userPartnerData) {
                                                            if (userPartnerData.stage == 5) {
                                                              let updateStage = {
                                                                user_id: user_id,
                                                                partner_id: partnerMappingData.partner_two_id,
                                                                stage: 4,
                                                              };
                                                              userSerObject.updateBothPartnerStage(
                                                                updateStage,
                                                                function (err, updatedStage) { }
                                                              );
                                                            }
                                                          }
                                                        );
                                                      }, 300000);
                                                      userSerObject.updateUserStage(
                                                        5,
                                                        user_id,
                                                        function (err, updatestageData) {
                                                          if (updatestageData) {
                                                            return res.send({
                                                              status: 200,
                                                              message:
                                                                "You and Your Patner's plan are expired! and Sucessfully enter payment page",
                                                              userStage: updatestageData.stage,
                                                              partner_stage: partenerData.stage,
                                                            });
                                                          } else {
                                                            return res.send({
                                                              status: 400,
                                                              message: "Something Went wrong",
                                                            });
                                                          }
                                                        }
                                                      );
                                                    }
                                                  } else {
                                                    return res.send({
                                                      status: 404,
                                                      message: "Partner is not found!",
                                                    });
                                                  }
                                                }
                                              });
                                            }
                                          } else {
                                            return res.send({
                                              status: 200,
                                              message: "Please Buy subscripation",
                                            });
                                          }
                                        } else {
                                        }
                                      }
                                    });
                                  } else {
                                    userSerObject.updateUserStage(5, user_id, function (err, updatestageData) {
                                      setTimeout(() => {
                                        userSerObject.getPartnerById(user_id, function (err, userPartnerData) {
                                          if (userPartnerData.stage == 5) {
                                            let updateStage = {
                                              user_id: user_id,
                                              partner_id: partnerMappingData.partner_two_id,
                                              stage: 4,
                                            };
                                            userSerObject.updateBothPartnerStage(
                                              updateStage,
                                              function (err, updatedStage) { }
                                            );
                                          }
                                        });
                                      }, 300000);
                                      if (updatestageData) {
                                        return res.send({
                                          status: 200,
                                          message:
                                            "You and Your Patner's plan are expired! and Sucessfully enter payment page",
                                          userStage: updatestageData.stage,
                                          partner_stage: partenerData.stage,
                                        });
                                      } else {
                                        return res.send({
                                          status: 400,
                                          message: "Something Went wrong",
                                        });
                                      }
                                    });
                                  }
                                }
                              } else {
                                return res.send({
                                  status: 200,
                                  message: "Please Buy subscripation",
                                });
                              }
                            } else {
                            }
                          }
                        });
                      } else {
                        setTimeout(() => {
                          userSerObject.getPartnerById(user_id, function (err, userPartnerData) {
                            if (userPartnerData.stage == 5) {
                              let updateStage = {
                                user_id: user_id,
                                partner_id: partnerMappingData.partner_two_id,
                                stage: 4,
                              };
                              userSerObject.updateBothPartnerStage(updateStage, function (err, updatedStage) { });
                            }
                          });
                        }, 300000);
                        userSerObject.updateUserStage(5, user_id, function (err, updatestageData) {
                          if (updatestageData) {
                            return res.send({
                              status: 200,
                              message: "Sucessfully enter payment page",
                              userStage: updatestageData.stage,
                              partner_stage: partenerData.stage,
                            });
                          } else {
                            return res.send({
                              status: 400,
                              message: "Something Went wrong",
                            });
                          }
                        });
                      }
                    }
                    if (userDetails.stage >= 8) {
                      if (userDetails.receipt || partenerData.receipt) {
                        let PatnerData = userDetails.receipt ? userDetails : partenerData;
                        SubscripationObject.VerifyReceipt(PatnerData, function (err, VerifyData) {
                          if (err) {
                            return res.send({
                              status: 404,
                              message: "something went wrong",
                            });
                          } else {
                            if (VerifyData) {
                              if (VerifyData.data.expire_at) {
                                let currentDate = current_datetime.format(new Date(), "YYYY-MM-DD HH:mm:ss", true);

                                let expiryDate = current_datetime.format(
                                  new Date(parseInt(VerifyData.data.expire_at || VerifyData.data.expire_at)),
                                  "YYYY-MM-DD HH:mm:ss",
                                  true
                                );
                                currentDate = new Date(currentDate);
                                expiryDate = new Date(expiryDate);
                                if (currentDate.getTime() < expiryDate.getTime()) {
                                  return res.send({
                                    status: 200,
                                    message: "You and Your Patner's plan is active! and Sucessfully enter Goal page",
                                    userStage: userDetails.stage,
                                    partner_stage: partenerData.stage,
                                  });
                                } else {
                                  if (partenerData.receipt) {
                                    SubscripationObject.VerifyReceipt(PatnerData, function (err, VerifyData) {
                                      if (err) {
                                        return res.send({
                                          status: 404,
                                          message: "something went wrong",
                                        });
                                      } else {
                                        if (VerifyData) {
                                          if (VerifyData.data.expire_at) {
                                            let currentDate = current_datetime.format(
                                              new Date(),
                                              "YYYY-MM-DD HH:mm:ss",
                                              true
                                            );
                                            let expiryDate = current_datetime.format(
                                              new Date(parseInt(VerifyData.data.expire_at || VerifyData.data.expire_at)),
                                              "YYYY-MM-DD HH:mm:ss",
                                              true
                                            );
                                            currentDate = new Date(currentDate);
                                            expiryDate = new Date(expiryDate);

                                            if (currentDate.getTime() < expiryDate.getTime()) {
                                              return res.send({
                                                status: 200,
                                                message:
                                                  "You and Your Patner's plan is active! and Sucessfully enter Goal page",
                                                userStage: userDetails.stage,
                                                partner_stage: partenerData.stage,
                                              });
                                            } else {
                                              userSerObject.getPartnerById(user_id, function (err, userPartnerData) {
                                                if (err) {
                                                  return res.send({
                                                    status: 404,
                                                    message: "Something went wrong!",
                                                  });
                                                } else {
                                                  if (userPartnerData) {
                                                    //               setTimeout(() => {
                                                    //   userSerObject.getPartnerById(user_id, function (err, userPartnerData) {
                                                    //     if (userPartnerData.stage == 5) {
                                                    //       let updateStage = {
                                                    //         user_id: user_id,
                                                    //         partner_id: partnerMappingData.partner_two_id,
                                                    //         stage: 4,
                                                    //       };
                                                    //       userSerObject.updateBothPartnerStage(
                                                    //         updateStage,
                                                    //         function (err, updatedStage) { }
                                                    //       );
                                                    //     }
                                                    //   });
                                                    // }, 300000);
                                                    if (partenerData.paymentStage != 2) {
                                                      setTimeout(() => {
                                                        userSerObject.getUserById(
                                                          user_id,
                                                          function (err, userPartnerData) {
                                                            if (userPartnerData.paymentStage == 2) {
                                                              userSerObject.updatePaymentStage(
                                                                1,
                                                                partenerData.id,
                                                                () => { }
                                                              );
                                                              userSerObject.updatePaymentStage(1, user_id, () => { });
                                                            }
                                                          }
                                                        );
                                                      }, 300000);
                                                      userSerObject.updatePaymentStage(
                                                        2,
                                                        user_id,
                                                        function (err, updatestageData) {
                                                          if (updatestageData) {
                                                            return res.send({
                                                              status: 200,
                                                              message:
                                                                "You and Your Patner's plan are expired! and Sucessfully enter payment page",
                                                              userStage: updatestageData.stage,
                                                              partner_stage: partenerData.stage,
                                                              userPaymentStage: updatestageData.paymentStage,
                                                              partnerPaymentStage: partenerData.paymentStage,
                                                            });
                                                          } else {
                                                            return res.send({
                                                              status: 400,
                                                              message: "Something Went wrong",
                                                            });
                                                          }
                                                        }
                                                      );
                                                    } else {
                                                      return res.send({
                                                        status: 400,
                                                        message: "Please wait! your partner is doing payment.",
                                                        userStage: userDetails.stage,
                                                        partner_stage: partenerData.stage,
                                                        userPaymentStage: userDetails.paymentStage,
                                                        partnerPaymentStage: partenerData.paymentStage,
                                                      });
                                                    }
                                                  } else {
                                                    return res.send({
                                                      status: 404,
                                                      message: "Partner is not found!",
                                                    });
                                                  }
                                                }
                                              });
                                            }
                                          } else {
                                            return res.send({
                                              status: 200,
                                              message: "Please Buy subscripation",
                                            });
                                          }
                                        } else {
                                        }
                                      }
                                    });
                                  } else {
                                    // userSerObject.updateUserStage(5, user_id, function (err, updatestageData) {
                                    //   if (updatestageData) {
                                    //     setTimeout(() => {
                                    //       userSerObject.getPartnerById(user_id, function (err, userPartnerData) {
                                    //         if (userPartnerData.stage == 5) {
                                    //           let updateStage = {
                                    //             user_id: user_id,
                                    //             partner_id: partnerMappingData.partner_two_id,
                                    //             stage: 4,
                                    //           };
                                    //           userSerObject.updateBothPartnerStage(
                                    //             updateStage,
                                    //             function (err, updatedStage) { }
                                    //           );
                                    //         }
                                    //       });
                                    //     }, 300000);
                                    //     return res.send({
                                    //       status: 200,
                                    //       message:
                                    //         "You and Your Patner's plan are expired! and Sucessfully enter payment page",
                                    //       userStage: updatestageData.stage,
                                    //       partner_stage: partenerData.stage,
                                    //     });
                                    //   } else {

                                    //     return res.send({
                                    //       status: 400,
                                    //       message: "Something Went wrong",
                                    //     });
                                    //   }
                                    // });
                                    if (partenerData.paymentStage != 2) {
                                      userSerObject.updatePaymentStage(2, user_id, function (err, updatestageData) {
                                        if (updatestageData) {
                                          setTimeout(() => {
                                            userSerObject.getUserById(user_id, function (err, userPartnerData) {
                                              if (userPartnerData.paymentStage == 2) {
                                                userSerObject.updatePaymentStage(1, partenerData.id, () => { });
                                                userSerObject.updatePaymentStage(1, user_id, () => { });
                                              }
                                            });
                                            // }, 300000);
                                          }, 300000);
                                          return res.send({
                                            status: 200,
                                            message:
                                              "You and Your Patner's plan are expired! and Sucessfully enter payment page",
                                            userStage: updatestageData.stage,
                                            partner_stage: partenerData.stage,
                                            userPaymentStage: updatestageData.paymentStage,
                                            partnerPaymentStage: partenerData.paymentStage,
                                          });
                                        } else {
                                          return res.send({
                                            status: 400,
                                            message: "Something Went wrong",
                                          });
                                        }
                                      });
                                    } else {
                                      return res.send({
                                        status: 400,
                                        message: "Please wait! your partner is doing payment.",
                                        userStage: userDetails.stage,
                                        partner_stage: partenerData.stage,
                                        userPaymentStage: userDetails.paymentStage,
                                        partnerPaymentStage: partenerData.paymentStage,
                                      });
                                    }
                                  }
                                  // kello
                                  if (partenerData.paymentStage != 2) {
                                    setTimeout(() => {
                                      userSerObject.getUserById(user_id, function (err, userPartnerData) {
                                        if (userPartnerData.paymentStage == 2) {
                                          userSerObject.updatePaymentStage(1, partenerData.id, () => { });
                                          userSerObject.updatePaymentStage(1, user_id, () => { });
                                        }
                                      });
                                    }, 300000);
                                    userSerObject.updatePaymentStage(2, user_id, function (err, updatestageData) {
                                      if (updatestageData) {
                                        return res.send({
                                          status: 200,
                                          message:
                                            "You and Your Patner's plan are expired! and Sucessfully enter payment page",
                                          userStage: updatestageData.stage,
                                          partner_stage: partenerData.stage,
                                          userPaymentStage: updatestageData.paymentStage,
                                          partnerPaymentStage: partenerData.paymentStage,
                                        });
                                      } else {
                                        return res.send({
                                          status: 400,
                                          message: "Something Went wrong",
                                        });
                                      }
                                    });
                                  } else {
                                    return res.send({
                                      status: 400,
                                      message: "Please wait! your partner is doing payment.",
                                      userStage: userDetails.stage,
                                      partner_stage: partenerData.stage,
                                      userPaymentStage: userDetails.paymentStage,
                                      partnerPaymentStage: partenerData.paymentStage,
                                    });
                                  }
                                }
                              } else {
                                return res.send({
                                  status: 200,
                                  message: "Please Buy subscripation",
                                });
                              }
                            } else {
                              return res.send({
                                status: 200,
                                message: "Please Buy subscripation",
                              });
                            }
                          }
                        });
                      } else {
                        return res.send({
                          status: 200,
                          message: "Sucessfully enter payment page",
                          userStage: updatestageData.stage,
                          partner_stage: partenerData.stage,
                        });
                      }
                    }
                  } else {
                    return res.send({
                      status: 504,
                      message: "partner is not found",
                    });
                  }
                }
              });
            } else {
              return res.send({
                status: 504,
                message: "Paring is not found",
              });
            }
          }
        });
      } else {
        return res.send({
          status: 504,
          message: "User is not found",
        });
      }
    }
  });
});

// Update monthly goal
router.post("/updatemonthlygoal/:goal_id", verifyToken, function (req, res) {
  let user_id = jwt.decode(req.headers["x-access-token"]).id;
  let goal_id = req.params.goal_id;
  let connect_number = req.body.connect_number;
  // let percentage         = req.body.percentage;
  let intimate_account_time = req.body.intimate_account_time;
  let intimate_request_time = req.body.intimate_request_time;
  let intimate_time = req.body.intimate_time;
  let initiator_count = req.body.initiator_count;
  let initiator_count1 = req.body.initiator_count1;
  let hours = req.body.hours;
  if (!goal_id) {
    return res.send({
      status: 400,
      message: "Goal Id is required.",
    });
  }

  if (!formValidator.isInt(goal_id)) {
    return res.send({
      status: 400,
      message: "Please enter a valid goal id.",
    });
  }

  if (!connect_number) {
    return res.send({
      status: 400,
      message: "Connect number is required.",
    });
  }

  if (!formValidator.isInt(connect_number)) {
    return res.send({
      status: 400,
      message: "Please enter a valid connect number.",
    });
  }
  if (!intimate_account_time) {
    return res.send({
      status: 400,
      message: "Intimate Account Time is required.",
    });
  }

  if (!intimate_request_time) {
    return res.send({
      status: 400,
      message: "Intimate Request Time is required.",
    });
  }

  if (!intimate_time) {
    return res.send({
      status: 400,
      message: "Intimate time is required.",
    });
  }

  if (!initiator_count) {
    return res.send({
      status: 400,
      message: "Initiator count is required.",
    });
  }

  if (!initiator_count1) {
    return res.send({
      status: 400,
      message: "Initiator count 1 is required.",
    });
  }

  // Check goal exists or not
  goalSerObject.getGoalById(goal_id, function (err, goalData) {
    if (err) {
      return res.send({
        status: 500,
        message: "something went wrong1",
      });
    } else {
      if (goalData) {
        userSerObject.getPartnerById(user_id, function (err, partnerResponse) {
          if (err) {
            return res.send({
              status: 400,
              message: "something went wrong2",
            });
          } else {
            if (partnerResponse) {
              if (goalData.status) {
                const now = new Date();
                let monthlyGoalData = {
                  partner_mapping_id: goalData.partner_mapping_id,
                  user_id: user_id,
                  connect_number: connect_number,
                  initiator_count: initiator_count,
                  initiator_count1: initiator_count1,
                  status: 1,
                  intimate_time: intimate_time,
                  intimate_request_time: intimate_request_time,
                  intimate_account_time: intimate_account_time,
                  id: goal_id,
                  partner_initiator_count: initiator_count,
                  hours: hours,
                };

                goalSerObject.updateMonthlyGoal(monthlyGoalData, function (err, monthlyGoalDataSaved) {
                  if (err) {
                    return res.send({
                      status: 500,
                      message: "something went wrong.",
                    });
                  } else {
                    if (monthlyGoalDataSaved) {
                      //schedules.stop();
                      userSerObject.getUserById(partnerResponse.id, function (err, GetpatnerData) {
                        if (err) {
                          return res.send({
                            status: 400,
                            message: "something went wrong",
                          });
                        } else {
                          if (GetpatnerData) {
                            userSerObject.getUserById(user_id, function (err, usersData) {
                              if (err) {
                                return res.send({
                                  status: 404,
                                  messgae: "something went wrong",
                                });
                              } else {
                                if (usersData) {
                                  const [time, modifier] = monthlyGoalDataSaved.intimate_request_time.split(" ");
                                  let [hours, minutes] = time.split(":");
                                  if (hours === "12") {
                                    hours = "00";
                                  }
                                  if (modifier === "PM") {
                                    hours = parseInt(hours, 10) + 12;
                                  }

                                  var night = new Date(
                                    now.getFullYear(),
                                    now.getMonth(),
                                    now.getDate(),
                                    hours,
                                    minutes,
                                    0
                                  );
                                  var month1 = current_datetime.format(night, "MM", true);
                                  var year1 = current_datetime.format(night, "YYYY", true);
                                  minutes = current_datetime.format(night, "mm");
                                  hours = current_datetime.format(night, "HH");
                                  let day1 = parseInt(new Date().getDate());
                                  var date = new Date();
                                  var month = date.getMonth() + 1;
                                  var year = date.getFullYear();
                                  let day = parseInt(
                                    new Date(year, month, 0).getDate() / monthlyGoalDataSaved.connect_number
                                  );

                                  if (day <= 0) {
                                    day = 1;
                                  }

                                  //${parseInt(minutes)} ${hours} ${day1} ${month1} *
                                  schedules1 && schedules1.stop();
                                  schedules1 = cron.schedule(
                                    `${parseInt(minutes)} ${hours} ${day1} ${month1} *`,
                                    () => {
                                      let statusCheck = customHelper.check_notification_Mute(
                                        usersData.notification_mute_start,
                                        usersData.notification_mute_end
                                      );
                                      if (statusCheck) {
                                        return res.send({
                                          status: 400,
                                          message: "Notificaiton is mute for some time.",
                                        });
                                      } else {
                                        goalSerObject.getGoalDetails(
                                          usersData.id,
                                          GetpatnerData.id,
                                          function (err, monthlyGoal_data) {
                                            if (err) {
                                              return res.send({
                                                status: 404,
                                                message: "something went wrong6!",
                                              });
                                            } else {
                                              if (monthlyGoal_data) {
                                                let contribution1 = monthlyGoal_data.contribution1;
                                                let contribution2 = monthlyGoal_data.contribution2;
                                                let initiator_count1 = monthlyGoal_data.initiator_count;
                                                let initiator_count2 = monthlyGoal_data.initiator_count1;
                                                let connect_number = monthlyGoal_data.connect_number;
                                                let totalcontribution1 = connect_number * initiator_count1 / 100
                                                let totalcontribution2 = connect_number * initiator_count2 / 100
                                                let ct1 = contribution1 * 100 / totalcontribution1
                                                let ct2 = contribution2 * 100 / totalcontribution2
                                                let Check = false;
                                                if (user_id != monthlyGoal_data.user_id) {
                                                  if (ct1 < ct2) {
                                                    Check = false;
                                                  }
                                                  else if (ct2 < ct1) {
                                                    Check = true;
                                                  }
                                                  else if (ct1 === ct2) {
                                                    if (initiator_count1 < initiator_count2) {
                                                      Check = true;
                                                    }
                                                    else if (initiator_count2 < initiator_count1) {
                                                      Check = false;
                                                    }
                                                    else {
                                                      Check = false;
                                                    }
                                                  }
                                                }
                                                else {
                                                  if (ct1 < ct2) {
                                                    Check = true;
                                                  }
                                                  else if (ct2 < ct1) {
                                                    Check = false;
                                                  }
                                                  else if (ct1 === ct2) {
                                                    if (initiator_count1 < initiator_count2) {
                                                      Check = false;
                                                    }
                                                    else if (initiator_count2 < initiator_count1) {
                                                      Check = true;
                                                    }
                                                    else {
                                                      Check = true;
                                                    }
                                                  }
                                                }
                                                let quikceydata = {
                                                  user_id: Check === true ? monthlyGoal_data.user_id : GetpatnerData.id,
                                                  partner_mapping_id: goalData.partner_mapping_id,

                                                }
                                                quickynObject.saveQuickybeforenotification(quikceydata, function (err, quickeydata) {
                                                  if (err) {
                                                    return res.send({
                                                      status: 404,
                                                      message: "Something went wrong!"
                                                    })
                                                  } else {
                                                    var Startdate = new Date(monthlyGoal_data.month_start).getTime();
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

                                                    let notification1 = {
                                                      user_id: usersData.id,
                                                      goal_id: monthlyGoalDataSaved.id,
                                                      device_id: usersData.fcmid,
                                                      notification_id: "null",
                                                    };
                                                    notificationObject.saveNotification(
                                                      notification1,
                                                      function (err, response) {
                                                        let notificationdata = {
                                                          user_id: user_id,
                                                          title: "Dating",
                                                          message: `You are at ${Notificationmessage.PR}% of goal with ${Notificationmessage.remaing_days} days left in the month.
                                                            Would you like to make a connection tonight?`,
                                                          type: "remember",
                                                          checkans: Check,
                                                          quickey_id: quickeydata.id,
                                                        }
                                                        notificationObject.addnotification(notificationdata,
                                                          function (err, response) {
                                                            notificationObject.notification(
                                                              usersData.fcmid,
                                                              Notificationmessage,
                                                              Check,
                                                              response.id,
                                                              response.quickey_id,
                                                              function (err, response) {
                                                              }
                                                            );
                                                          }
                                                        )
                                                      }
                                                    );
                                                    let notification12 = {
                                                      user_id: GetpatnerData.id,
                                                      goal_id: monthlyGoalDataSaved.id,
                                                      device_id: GetpatnerData.fcmid,
                                                      notification_id: "null",
                                                    };
                                                    notificationObject.saveNotification(
                                                      notification12,
                                                      function (err, response) {
                                                        let notificationdata = {
                                                          user_id: GetpatnerData.id,
                                                          title: "Dating",
                                                          message: `You are at ${Notificationmessage.PR}% of goal with ${Notificationmessage.remaing_days} days left in the month.
                                                            Would you like to make a connection tonight?`,
                                                          type: "remember",
                                                          checkans: !Check,
                                                          quickey_id: quickeydata.id
                                                        }

                                                        notificationObject.addnotification(notificationdata,
                                                          function (err, response) {
                                                            notificationObject.notification(
                                                              GetpatnerData.fcmid,
                                                              Notificationmessage,
                                                              !Check,
                                                              response.id,
                                                              response.quickey_id,
                                                              function (err, response) {
                                                              }
                                                            );
                                                          }
                                                        )
                                                      }
                                                    );
                                                  }
                                                })

                                                cron.schedule(`${parseInt(minutes)} ${hours} */${day} * *`, () => {
                                                  // cron.schedule(`* * * * *`, (err, ress) => {
                                                  let statusCheck = customHelper.check_notification_Mute(
                                                    usersData.notification_mute_start,
                                                    usersData.notification_mute_end
                                                  );
                                                  if (statusCheck) {
                                                    return res.send({
                                                      status: 400,
                                                      message: "Notificaiton is mute for some time.",
                                                    });
                                                  } else {
                                                    goalSerObject.getGoalDetails(
                                                      usersData.id,
                                                      GetpatnerData.id,
                                                      function (err, monthlyGoal_data) {
                                                        if (err) {
                                                          return res.send({
                                                            status: 404,
                                                            message: "something went wrong6!",
                                                          });
                                                        } else {
                                                          if (monthlyGoal_data) {
                                                            let contribution1 = monthlyGoal_data.contribution1;
                                                            let contribution2 = monthlyGoal_data.contribution2;
                                                            let initiator_count1 = monthlyGoal_data.initiator_count;
                                                            let initiator_count2 = monthlyGoal_data.initiator_count1;
                                                            let connect_number = monthlyGoal_data.connect_number;
                                                            let totalcontribution1 = connect_number * initiator_count1 / 100
                                                            let totalcontribution2 = connect_number * initiator_count2 / 100
                                                            let ct1 = contribution1 * 100 / totalcontribution1
                                                            let ct2 = contribution2 * 100 / totalcontribution2
                                                            let Check = false;
                                                            if (user_id != monthlyGoal_data.user_id) {
                                                              if (ct1 < ct2) {
                                                                Check = false;
                                                              }
                                                              else if (ct2 < ct1) {
                                                                Check = true;
                                                              }
                                                              else if (ct1 === ct2) {
                                                                if (initiator_count1 < initiator_count2) {
                                                                  Check = true;
                                                                }
                                                                else if (initiator_count2 < initiator_count1) {
                                                                  Check = false;
                                                                }
                                                                else {
                                                                  Check = false;
                                                                }
                                                              }
                                                            }
                                                            else {
                                                              if (ct1 < ct2) {
                                                                Check = true;
                                                              }
                                                              else if (ct2 < ct1) {
                                                                Check = false;
                                                              }
                                                              else if (ct1 === ct2) {
                                                                if (initiator_count1 < initiator_count2) {
                                                                  Check = false;
                                                                }
                                                                else if (initiator_count2 < initiator_count1) {
                                                                  Check = true;
                                                                }
                                                                else {
                                                                  Check = true;
                                                                }
                                                              }
                                                            }
                                                            let quikceydata = {
                                                              user_id: Check === true ? monthlyGoal_data.user_id : GetpatnerData.id,
                                                              partner_mapping_id: goalData.partner_mapping_id,

                                                            }
                                                            quickynObject.saveQuickybeforenotification(quikceydata, function (err, quickeydata) {
                                                              if (quickeydata) {
                                                                res.send({
                                                                  status: 404,
                                                                  message: "Something went wrong"
                                                                })

                                                              } else {
                                                                var Startdate = new Date(
                                                                  monthlyGoal_data.month_start
                                                                ).getTime();
                                                                var lastDay = new Date(
                                                                  monthlyGoal_data.month_end
                                                                ).getTime();
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
                                                                let notification1 = {
                                                                  user_id: monthlyGoal_data.id,
                                                                  goal_id: monthlyGoalDataSaved.id,
                                                                  device_id: monthlyGoal_data.fcmid,
                                                                  notification_id: "null",
                                                                };
                                                                notificationObject.saveNotification(
                                                                  notification1,
                                                                  function (err, response) {
                                                                    let notificationdata = {
                                                                      user_id: user_id,
                                                                      title: "Dating",
                                                                      message: `You are at ${Notificationmessage.PR}% of goal with ${Notificationmessage.remaing_days} days left in the month.
                                                                        Would you like to make a connection tonight?`,
                                                                      type: "remember",
                                                                      checkans: Check,
                                                                      quickey_id: quickeydata.id
                                                                    }
                                                                    notificationObject.addnotification(notificationdata,
                                                                      function (err, response) {
                                                                        notificationObject.notification(
                                                                          monthlyGoal_data.fcmid,
                                                                          Notificationmessage,
                                                                          Check,
                                                                          response.id,
                                                                          response.quickey_id,
                                                                          function (err, response) {
                                                                          }
                                                                        );
                                                                      }
                                                                    )
                                                                  }
                                                                );

                                                                let notification12 = {
                                                                  user_id: GetpatnerData.id,
                                                                  goal_id: monthlyGoalDataSaved.id,
                                                                  device_id: GetpatnerData.fcmid,
                                                                  notification_id: "null",
                                                                };
                                                                notificationObject.saveNotification(
                                                                  notification12,
                                                                  function (err, response) {
                                                                    let notificationdata = {
                                                                      user_id: GetpatnerData.id,
                                                                      title: "Dating",
                                                                      message: `You are at ${Notificationmessage.PR}% of goal with ${Notificationmessage.remaing_days} days left in the month.
                                                                        Would you like to make a connection tonight?`,
                                                                      type: "remember",
                                                                      checkans: !Check,
                                                                      quickey_id: quickeydata.id
                                                                    }
                                                                    notificationObject.addnotification(notificationdata,
                                                                      function (err, response) {
                                                                        notificationObject.notification(
                                                                          GetpatnerData.fcmid,
                                                                          Notificationmessage,
                                                                          !Check,
                                                                          response.id,
                                                                          response.quickey_id,
                                                                          function (err, response) {
                                                                          }
                                                                        );
                                                                      }
                                                                    )
                                                                  }
                                                                );
                                                              }
                                                            })
                                                          }
                                                        }
                                                      }
                                                    );
                                                  }
                                                });
                                              }
                                            }
                                          }
                                        );
                                      }
                                    }
                                  );
                                  schedules1.start();
                                  return res.send({
                                    status: 200,
                                    message: "The monthly goal has been updated.",
                                    patner_fcmid: partnerResponse.fcmid,
                                  });
                                } else {
                                  return res.send({
                                    status: 504,
                                    messgae: "user is not found",
                                  });
                                }
                              }
                            });
                          } else {
                            return res.send({
                              status: 504,
                              messgae: "Patner is not found",
                            });
                          }
                        }
                      });
                    } else {
                      return res.send({
                        status: 504,
                        message: "Goal is not update",
                      });
                    }
                  }
                });
              } else {
                return res.send({
                  status: 400,
                  message: "This goal is not active",
                });
              }
            } else {
              return res.send({
                status: 400,
                message: "partner not found",
              });
            }
          }
        });
      } else {
        return res.send({
          status: 400,
          message: "This goal is not valid",
        });
      }
    }
  });
});

// Get monthly goal detail
router.get("/getmonthlygoaldetail", verifyToken, function (req, res, next) {
  let user_id = jwt.decode(req.headers["x-access-token"]).id;

  if (!user_id) {
    return res.send({
      status: 400,
      message: "User Id is required.",
    });
  }

  goalSerObject.getPartnerData(user_id, function (err, patnerData) {
    if (patnerData) {
      goalSerObject.getGoalDetails(
        patnerData.partner_one_id,
        patnerData.partner_two_id,
        function (err, goalCompleteData) {
          if (err) {
            return res.send({
              status: 500,
              message: "something went wrong7 please try after some time.",
            });
          } else {
            if (goalCompleteData) {
              userSerObject.getUserById(user_id, function (err, loginUserData) {
                if (loginUserData) {
                  userSerObject.getPartnerById(user_id, function (err, patnerData, id) {
                    if (patnerData) {
                      let currentGoalData = {
                        id: goalCompleteData.id,
                        partner_mapping_id: goalCompleteData.partner_mapping_id,
                        user_id: goalCompleteData.user_id,
                        goal_identifier: goalCompleteData.goal_identifier,
                        month_start: goalCompleteData.month_start,
                        month_end: goalCompleteData.month_end,
                        connect_number: goalCompleteData.connect_number,
                        initiator_count:
                          goalCompleteData.user_id === user_id
                            ? goalCompleteData.initiator_count
                            : goalCompleteData.initiator_count1,
                        initiator_count1:
                          goalCompleteData.user_id === user_id
                            ? goalCompleteData.initiator_count1
                            : goalCompleteData.initiator_count,
                        intimate_time: goalCompleteData.intimate_time,
                        intimate_request_time: goalCompleteData.intimate_request_time,
                        intimate_account_time: goalCompleteData.intimate_account_time,
                        complete_count: goalCompleteData.complete_count,
                        complete_percentage: goalCompleteData.complete_percentage,
                        status: goalCompleteData.status,
                        create_time: goalCompleteData.create_time,
                        update_time: goalCompleteData.update_time,
                        user1_first_name: loginUserData.first_name,
                        user1_last_name: loginUserData.last_name,
                        user2_first_name: patnerData.first_name,
                        user2_last_name: patnerData.last_name,
                      };
                      return res.send({
                        status: 200,
                        result: currentGoalData,
                      });
                    } else {
                      return res.send({
                        status: 400,
                        message: "partner is not found",
                      });
                    }
                  });
                } else {
                  return res.send({
                    status: 400,
                    message: "user is not found",
                  });
                }
              });
            } else {
              return res.send({
                status: 504,
                message: "something went wrong please try after some time.",
              });
            }
          }
        }
      );
    }
    if (err) {
      return res.send({
        status: 400,
        message: "something went wrong8",
      });
    }
  });
});

// Get monthly goal history
router.get("/getmonthlygoalhistory/:user_id", verifyToken, function (req, res, next) {
  let user_id = req.params.user_id;
  if (!user_id) {
    return res.send({
      status: 400,
      message: "Goal Id is required.",
    });
  }

  if (!formValidator.isInt(user_id)) {
    return res.send({
      status: 400,
      message: "Please enter a valid goal id.",
    });
  }

  goalSerObject.getAllGoalsHistoryByUserID(user_id, function (err, goalHistoryData) {
    if (err) {
      return res.send({
        status: 500,
        message: "There was a problem finding the goal history.",
      });
    } else {
      if (goalHistoryData) {
        return res.send({
          status: 200,
          message: goalHistoryData,
        });
      } else {
        return res.send({
          status: 404,
          message: "No goal history found.",
        });
      }
    }
  });
});

// Add Questionalries option from admin panel
router.post("/saveOptions", verifyToken, function (req, res) {
  let title = req.body.title;
  let question_id = req.body.question_id;
  if (!title) {
    return res.send({
      status: 400,
      message: "Title is required",
    });
  }
  if (question_id) {
    return res.send({
      status: 400,
      message: "Question Id is required",
    });
  }
  if (!formValidator.isInt(question_id)) {
    return res.send({
      status: 400,
      message: "Please enter a valid Question Id.",
    });
  }
  goalSerObject.setQuestionOptions(title, question_id, function (err, Options) {
    if (err) {
      return res.send({
        status: 400,
        messgae: "Something went wrong!",
      });
    } else {
      if (Options) {
        return res.send({
          status: 200,
          message: "Options save successfully",
          result: Options,
        });
      } else {
        return res.send({
          status: 504,
          messgae: "option is not saved",
        });
      }
    }
  });
});

// Get Questionaries option
router.get("/getOption", verifyToken, function (req, res) {
  goalSerObject.GetQuestionOption(function (err, GetOptions) {
    if (GetOptions) {
      return res.send({
        status: 200,
        result: GetOptions,
      });
    }
    if (err) {
      return res.send({
        status: 400,
        messgae: "Something went wrong!",
      });
    }
  });
});

router.post("/saveQuestionaries", verifyToken, function (req, res) {
  let question_title = req.body.question_title;
  let question_descripation = req.body.question_descripation;
  let iscustom = req.body.iscustom;
  if (!question_title) {
    return res.send({
      status: 400,
      message: "Question Title is required",
    });
  }
  if (!question_descripation) {
    return res.send({
      status: 400,
      message: "Quetion descripation is required",
    });
  }
  let questions = {
    question_title: question_title,
    question_descripation: question_descripation,
    iscustom: iscustom,
  };

  goalSerObject.saveQuestionaries(questions, function (err, response) {
    if (err) {
      return res.send({
        status: 400,
        messgae: "Something went Wrong!",
      });
    } else {
      if (response) {
        return res.send({
          status: 200,
          message: "Question save successfully",
          result: response,
        });
      }
    }
  });
});

router.get("/CheckQuetionariesFlag", verifyToken, function (req, res) {
  let user_id = jwt.decode(req.headers["x-access-token"]).id;
  if (!user_id) {
    return res.send({
      status: 400,
      message: "User id is required.",
    });
  }
  goalSerObject.getPartnerData(user_id, function (err, partnerMappingData) {
    if (err) {
      return res.send({
        status: 500,
        message: "something went wrong",
      });
    } else {
      if (partnerMappingData) {
        userSerObject.getUserById(partnerMappingData.partner_two_id, function (err, partenerData) {
          if (err) {
            return res.send({
              status: 400,
              message: "Invalid partner id provided",
            });
          } else {
            if (partenerData) {
              setTimeout(() => {
                if (partenerData.stage === 7) {
                  return res.send({
                    status: 400,
                    message: "Please Wait, Your partner is already working on questionaries",
                  });
                } else {
                  userSerObject.updateUserStage(7, user_id, function (err, updatestageData) {
                    if (updatestageData) {
                      return res.send({
                        status: 200,
                        message: "Sucessfully enter questionaries page",
                        stage: updatestageData.stage,
                      });
                    } else {
                      return res.send({
                        status: 400,
                        message: "Something Went wrong",
                      });
                    }
                  });
                }
              }, 1000);
            } else {
              return res.send({
                status: 504,
                message: "Partner is not found",
              });
            }
          }
        });
      } else {
        return res.send({
          status: 504,
          messgae: "something went wrong",
        });
      }
    }
  });
});

// Update goal setting detail
router.put("/updateGoalSetting/", verifyToken, function (req, res) {
  let user_id = jwt.decode(req.headers["x-access-token"]).id;

  // if(!answer)
  // {
  // 	return res.send({
  // 		status: 400,
  // 		message: 'Answer is required',
  // 	});
  // }
  //Check goal exists or not

  req.body.map((response) => {
    // Check setting question exists or not
    goalSerObject.getGoalSettingsQuestionById(response.question_id, function (err, goalQuestionData) {
      if (err) {
        return res.send({
          status: 500,
          message: "something went wrong",
        });
      } else {
        if (goalQuestionData) {
          let goalSettingData = {
            question_id: response.question_id,
            answer: response.answer,
            user_id: user_id,
            id: response.question_answer_id,
            custom_answer: response.custom_answer ? response.custom_answer : null,
          };
          goalSerObject.updatesetting(goalSettingData, function (err, goalSettingDataupdated) {
            if (err) {
              return res.send({
                status: 400,
                message: "something went wrong",
              });
            } else {
              if (goalSettingDataupdated) {
                return res.send({
                  status: 200,
                  message: "updated sucessfully",
                });
              } else {
                return res.send({
                  status: 504,
                  message: "Something went wrong",
                });
              }
            }
          });
        } else {
          return res.send({
            status: 400,
            message: "No goal setting found",
          });
        }
      }
    });
  });
});


// Update Complete goal count
router.put("/updateCompletedGoal/:id", verifyToken, function (req, res) {
  let user_id = jwt.decode(req.headers["x-access-token"]).id;
  let answer1 = req.body.didYouConnectLastNight;
  let answer2 = req.body.WhoInitiative;
  let quicky_id = req.params.id;
  if (!answer1) {
    return res.send({
      status: 400,
      message: "Please select an option for continue.",
    });
  }
  userSerObject.getPartnerById(user_id, function (err, partner_data) {
    if (err) {
      return res.send({
        status: 400,
        message: "something went wrong!",
      });
    } else {
      if (partner_data) {
        goalSerObject.getGoalDetails(user_id, partner_data.id, function (err, monthly_goal_data) {
          if (err) {
            return res.send({
              status: 400,
              message: "something went wrong!",
            });
          } else {
            if (monthly_goal_data) {
              goalSerObject.getPartnerData(user_id, function (err, patner_mapping_data) {
                if (err) {
                  return res.send({
                    status: 400,
                    message: "something went wrong",
                  });
                } else {
                  if (patner_mapping_data) {
                    if (answer1 === "true") {
                      if (!answer2) {
                        return res.send({
                          status: 400,
                          message: "Please select an option for continue.",
                        });
                      }
                      let userID;
                      if (answer2 === "true") {
                        userID = user_id;
                      } else {
                        userID = partner_data.id;
                      }
                      quickynObject.getSingleQuickyRecord(quicky_id, function (err, QuickyData) {
                        if (err) {
                          return res.send({
                            status: 400,
                            message: "Something Went Wrong!",
                          });
                        } else {
                          if (QuickyData) {
                            let updateQuickyData = {
                              partner1_answer1: QuickyData.user_id == user_id ? answer1 : QuickyData.partner1_answer1,
                              partner1_answer2: QuickyData.user_id == user_id ? answer2 : QuickyData.partner1_answer2,
                              partner2_answer1: QuickyData.user_id == user_id ? QuickyData.partner2_answer1 : answer1,
                              partner2_answer2: QuickyData.user_id == user_id ? QuickyData.partner2_answer2 : answer2,
                              quicky_id: quicky_id,
                            };
                            quickynObject.updatePartnerDatainQuicky(updateQuickyData, function (err, UpdateData) {
                              if (err) {
                                return res.send({
                                  status: 400,
                                  message: "Something Went Wrong!",
                                });
                              } else {
                                if (UpdateData) {
                                  if (UpdateData.partner1_answer2 != null && UpdateData.partner2_answer2 != null) {
                                    quickynObject.Addcontribution(quicky_id, function (err, ContributionData) {
                                      if (err) {
                                        return res.send({
                                          status: 400,
                                          message: "Something Went Wrong!",
                                        });
                                      } else {
                                        if (ContributionData) {
                                          let userID;

                                          if (answer2 === "true") {
                                            userID = user_id;
                                          } else {
                                            userID = partner_data.id;
                                          }

                                          if (ContributionData.partner1_answer2 != ContributionData.partner2_answer2) {

                                            let comepletion_goal = {
                                              user_id: userID,
                                              goal_id: monthly_goal_data.id,
                                              partner_mapping_id: patner_mapping_data.id,
                                              didYouConnectLastNight: answer1,
                                              WhoInitiative: answer2,
                                            };
                                            let completeData = {
                                              id: monthly_goal_data.id,
                                              complete_count: parseInt(monthly_goal_data.complete_count) + 1,
                                              contribution1:
                                                monthly_goal_data.user_id === comepletion_goal.user_id
                                                  ? parseInt(monthly_goal_data.contribution1) + 1
                                                  : parseInt(monthly_goal_data.contribution1),
                                              contribution2:
                                                monthly_goal_data.user_id === comepletion_goal.user_id
                                                  ? parseInt(monthly_goal_data.contribution2)
                                                  : parseInt(monthly_goal_data.contribution2) + 1,
                                            };
                                            goalSerObject.updateCompleteCount(
                                              completeData,
                                              function (err, update_monthly_data) {
                                                if (err) {
                                                  return res.send({
                                                    status: 400,
                                                    message: err,
                                                  });
                                                } else {
                                                  if (update_monthly_data) {
                                                    completionSerObject.saveCompletionGoal(
                                                      comepletion_goal,
                                                      function (err, save_data) {
                                                        if (err) {
                                                          return res.send({
                                                            status: 504,
                                                            message: "something Went Wrong",
                                                          });
                                                        } else {
                                                          if (save_data) {
                                                            return res.send({
                                                              status: 200,
                                                              message: "Update successfully",
                                                            });
                                                          } else {
                                                            return res.send({
                                                              status: 504,
                                                              message: "something Went Wrong",
                                                            });
                                                          }
                                                        }
                                                      }
                                                    );
                                                  } else {
                                                    return res.send({
                                                      status: 504,
                                                      message: "something Went Wrong",
                                                    });
                                                  }
                                                }
                                              }
                                            );
                                          } else {
                                            return res.send({
                                              status: 200,
                                              message: "Both Partner answer are same",
                                            });
                                          }
                                        }
                                      }
                                    });
                                  } else {
                                    setTimeout(() => {
                                      quickynObject.getSingleQuickyRecord(quicky_id, function (err, quickyData) {
                                        if (err) {
                                          return res.send({
                                            status: 400,
                                            message: "Something Went Wrong!",
                                          });
                                        } else {
                                          if (quickyData) {
                                            if (quickyData.contribution != 1 && quickyData.partner2_answer1 != false) {
                                              let comepletion_goal = {
                                                user_id: userID,
                                                goal_id: monthly_goal_data.id,
                                                partner_mapping_id: patner_mapping_data.id,
                                                didYouConnectLastNight: answer1,
                                                WhoInitiative: answer2,
                                              };
                                              let completeData = {
                                                id: monthly_goal_data.id,
                                                complete_count: parseInt(monthly_goal_data.complete_count) + 1,
                                                contribution1:
                                                  monthly_goal_data.user_id === user_id
                                                    ? parseInt(monthly_goal_data.contribution1) + 1
                                                    : parseInt(monthly_goal_data.contribution1),
                                                contribution2:
                                                  monthly_goal_data.user_id === user_id
                                                    ? parseInt(monthly_goal_data.contribution2)
                                                    : parseInt(monthly_goal_data.contribution2) + 1,
                                              };
                                              goalSerObject.updateCompleteCount(
                                                completeData,
                                                function (err, update_monthly_data) {
                                                  if (err) {
                                                    return res.send({
                                                      status: 400,
                                                      message: err,
                                                    });
                                                  } else {
                                                    if (update_monthly_data) {
                                                      completionSerObject.saveCompletionGoal(
                                                        comepletion_goal,
                                                        function (err, save_data) {
                                                          if (err) {
                                                            return res.send({
                                                              status: 504,
                                                              message: "something Went Wrong",
                                                            });
                                                          } else {
                                                            if (save_data) {
                                                              return res.send({
                                                                status: 200,
                                                                message: "Update successfully",
                                                              });
                                                            } else {
                                                              return res.send({
                                                                status: 504,
                                                                message: "something Went Wrong",
                                                              });
                                                            }
                                                          }
                                                        }
                                                      );
                                                    } else {
                                                      return res.send({
                                                        status: 504,
                                                        message: "something Went Wrong",
                                                      });
                                                    }
                                                  }
                                                }
                                              );
                                            } else {
                                              return res.send({
                                                status: 200,
                                                message: "Contribution is alredy added",
                                              });
                                            }
                                          } else {
                                            return res.send({
                                              status: 500,
                                              message: "Quicky is not found!",
                                            });
                                          }
                                        }
                                      });
                                    }, 21600000);

                                    userSerObject.getUserById(user_id, function (err, userData) {
                                      if (err) {
                                        return res.send({
                                          status: 400,
                                          message: "something went wrong.",
                                        });
                                      } else {
                                        if (userData) {
                                          userSerObject.getPartnerById(user_id, function (err, partnerData) {
                                            if (err) {
                                              return res.send({
                                                status: 400,
                                                message: "something went wrong.",
                                              });
                                            } else {
                                              goalSerObject.getGoalDetails(
                                                user_id,
                                                partner_data.id,
                                                function (err, monthly_goal_data) {
                                                  const monthend = new Date(monthly_goal_data.month_end);
                                                  const diffTime = Math.abs(new Date() - monthend);
                                                  const REMAININGDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));

                                                  const remainingConnections =
                                                    monthly_goal_data.connect_number - monthly_goal_data.complete_count;
                                                  const final = Math.ceil(REMAININGDays / remainingConnections);

                                                  {
                                                    if (monthly_goal_data) {
                                                      const [
                                                        time,
                                                        modifier,
                                                      ] = monthly_goal_data.intimate_request_time.split(" ");
                                                      let [hours, minutes] = time.split(":");
                                                      if (hours === "12") {
                                                        hours = "00";
                                                      }
                                                      if (modifier === "PM") {
                                                        hours = parseInt(hours, 10) + 12;
                                                      }
                                                      var now = new Date();
                                                      var night = new Date(
                                                        now.getFullYear(),
                                                        now.getMonth(),
                                                        now.getDate(),
                                                        hours,
                                                        minutes,
                                                        0
                                                      );

                                                      var month = current_datetime.format(night, "MM", true);
                                                      var year = current_datetime.format(night, "YYYY", true);
                                                      minutes = current_datetime.format(night, "mm");
                                                      hours = current_datetime.format(night, "HH");
                                                      let day = parseInt(
                                                        new Date(year, month, 0).getDate() /
                                                        monthly_goal_data.connect_number
                                                      );
                                                      if (day <= 0) {
                                                        day = 1;
                                                      }
                                                      //${parseInt(minutes)} ${hours} */${final} * *
                                                      cron.schedule(
                                                        `${parseInt(minutes)} ${hours} */${final} * *`,
                                                        () => {
                                                          // cron.schedule(`* * * * *`, (err, ress) => {
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
                                                            goalSerObject.getGoalDetails(
                                                              userData.id,
                                                              partnerData.id,
                                                              function (err, monthlyGoal_data) {
                                                                if (err) {
                                                                  return res.send({
                                                                    status: 404,
                                                                    message: "Something went wrong!",
                                                                  });
                                                                } else {
                                                                  if (monthlyGoal_data) {

                                                                    // const monthend = new Date(
                                                                    //   monthly_goal_data.month_end
                                                                    // );
                                                                    // const diffTime = Math.abs(new Date() - monthend);
                                                                    // const REMAININGDays = Math.ceil(
                                                                    //   diffTime / (1000 * 60 * 60 * 24)
                                                                    // );

                                                                    // const remainingConnections =
                                                                    //   monthly_goal_data.connect_number -
                                                                    //   monthly_goal_data.complete_count;
                                                                    // const final = Math.ceil(
                                                                    //   REMAININGDays / remainingConnections
                                                                    // );
                                                                    var date = new Date();
                                                                    var Startdate = new Date(monthlyGoal_data.month_start).getTime();
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
                                                                    // let per =
                                                                    //   (monthly_goal_data.complete_count /
                                                                    //     monthly_goal_data.connect_number) *
                                                                    //   100;
                                                                    // let Notificationmessage = {
                                                                    //   PR: per.toFixed(2),
                                                                    //   remaing_days: diffTime,
                                                                    // };
                                                                    let contribution1 = monthlyGoal_data.contribution1;
                                                                    let contribution2 = monthlyGoal_data.contribution2;
                                                                    let initiator_count1 = monthlyGoal_data.initiator_count;
                                                                    let initiator_count2 = monthlyGoal_data.initiator_count1;
                                                                    let connect_number = monthlyGoal_data.connect_number;
                                                                    let totalcontribution1 = connect_number * initiator_count1 / 100
                                                                    let totalcontribution2 = connect_number * initiator_count2 / 100
                                                                    let ct1 = contribution1 * 100 / totalcontribution1
                                                                    let ct2 = contribution2 * 100 / totalcontribution2
                                                                    let Check = false;
                                                                    if (user_id != monthlyGoal_data.user_id) {
                                                                      if (ct1 < ct2) {
                                                                        Check = false;
                                                                      }
                                                                      else if (ct2 < ct1) {
                                                                        Check = true;
                                                                      }
                                                                      else if (ct1 === ct2) {
                                                                        if (initiator_count1 < initiator_count2) {
                                                                          Check = true;
                                                                        }
                                                                        else if (initiator_count2 < initiator_count1) {
                                                                          Check = false;
                                                                        }
                                                                        else {
                                                                          Check = false;
                                                                        }
                                                                      }
                                                                    }
                                                                    else {
                                                                      if (ct1 < ct2) {
                                                                        Check = true;
                                                                      }
                                                                      else if (ct2 < ct1) {
                                                                        Check = false;
                                                                      }
                                                                      else if (ct1 === ct2) {
                                                                        if (initiator_count1 < initiator_count2) {
                                                                          Check = false;
                                                                        }
                                                                        else if (initiator_count2 < initiator_count1) {
                                                                          Check = true;
                                                                        }
                                                                        else {
                                                                          Check = true;
                                                                        }
                                                                      }
                                                                    }
                                                                    let quikceydata = {
                                                                      user_id: Check === true ? monthlyGoal_data.user_id : partnerData.id,
                                                                      partner_mapping_id: patner_mapping_data.id,

                                                                    }
                                                                    quickynObject.saveQuickybeforenotification(quikceydata, function (err, quickeydata) {
                                                                      if (err) {
                                                                        res.send({
                                                                          status: 404,
                                                                          message: "Something went wrong!!"
                                                                        })
                                                                      } else {
                                                                        let notification = {
                                                                          user_id: userData.id,
                                                                          goal_id: monthly_goal_data.id,
                                                                          device_id: userData.fcmid,
                                                                          notification_id: "null"

                                                                        };
                                                                        notificationObject.saveNotification(
                                                                          notification,
                                                                          function (err, response) {
                                                                            let notificationdata = {
                                                                              user_id: user_id,
                                                                              title: "Dating",
                                                                              message: `You are at ${Notificationmessage.PR}% of goal with ${Notificationmessage.remaing_days} days left in the month.
                                                                            Would you like to make a connection tonight?`,
                                                                              type: "remember",
                                                                              checkans: Check,
                                                                              quickey_id: quickeydata.id
                                                                            }
                                                                            notificationObject.addnotification(notificationdata,
                                                                              function (err, response) {
                                                                                notificationObject.notification(
                                                                                  userData.fcmid,
                                                                                  Notificationmessage,
                                                                                  Check,
                                                                                  response.id,
                                                                                  response.quickey_id,
                                                                                  function (err, response) {
                                                                                  }
                                                                                );
                                                                              }
                                                                            );
                                                                          })

                                                                        if (err) {
                                                                          res.send({
                                                                            status: 404,
                                                                            message: "Something went wrong!!"
                                                                          })
                                                                        } else {
                                                                          let notification1 = {
                                                                            user_id: partnerData.id,
                                                                            goal_id: monthly_goal_data.id,
                                                                            device_id: partnerData.fcmid,
                                                                            notification_id: "null",
                                                                          };
                                                                          notificationObject.saveNotification(
                                                                            notification1,
                                                                            function (err, response) {
                                                                              let notificationdata = {
                                                                                user_id: user_id,
                                                                                title: "Dating",
                                                                                message: `You are at ${Notificationmessage.PR}% of goal with ${Notificationmessage.remaing_days} days left in the month.
                                                                            Would you like to make a connection tonight?`,
                                                                                type: "remember",
                                                                                checkans: Check,
                                                                                quickey_id: quickeydata.id
                                                                              }
                                                                              notificationObject.addnotification(notificationdata,
                                                                                function (err, response) {
                                                                                  notificationObject.notification(
                                                                                    partnerData.fcmid,
                                                                                    Notificationmessage,
                                                                                    !Check,
                                                                                    response.id,
                                                                                    response.quickey_id,
                                                                                    function (err, response) {
                                                                                    }

                                                                                  );
                                                                                }
                                                                              );

                                                                            }
                                                                          )
                                                                        }


                                                                      }
                                                                    })
                                                                  }


                                                                }
                                                              }
                                                            );
                                                          }
                                                        }
                                                      );
                                                    } else {
                                                      return res.send({
                                                        status: 500,
                                                        message: "Partner is not found.",
                                                      });
                                                    }
                                                  }
                                                }
                                              );
                                            }
                                          });
                                        }
                                      }
                                    });

                                    return res.send({
                                      status: 200,
                                      message: "Update successfully",
                                    });
                                  }
                                } else {
                                  return res.send({
                                    status: 400,
                                    message: "Quicky update error",
                                  });
                                }
                              }
                            });
                          } else {
                            return res.send({
                              status: 200,
                              message: "something wrong with quickie !",
                            });
                          }
                        }
                      });
                    } else {
                      return res.send({
                        status: 200,
                        message: "You did not connect last night",
                      });
                    }
                  } else {
                    return res.send({
                      status: 504,
                      message: "Something went wrong! please try again.",
                    });
                  }
                }
              });
            } else {
              return res.send({
                status: 400,
                message: "Goal is not found. please setup a goal first.",
              });
            }
          }
        });
      } else {
        return res.send({
          status: 504,
          message: "partner is not found",
        });
      }
    }
  });
});

//get priovus monthly goal
router.get("/previousMonthlyGoal", verifyToken, function (req, res) {
  let user_id = jwt.decode(req.headers["x-access-token"]).id;

  userSerObject.getPartnerById(user_id, function (err, partner_data) {
    if (err) {
      return res.send({
        status: 400,
        message: "something went wrong!",
      });
    } else {
      if (partner_data) {
        goalSerObject.GetPreviousMonthyGoalById(user_id, partner_data.id, function (err, previous_monthly_goal_data) {
          if (err) {
            return res.send({
              status: 400,
              message: "something went wrong!",
            });
          } else {
            userSerObject.getUserById(user_id, function (err, userdata) {
              if (err) {
                return res.send({
                  status: 400,
                  message: "User is not found.",
                });
              } else {
                if (userdata) {
                  userSerObject.getPartnerById(user_id, function (err, patnerData) {
                    if (patnerData) {
                      if (previous_monthly_goal_data) {
                        let dashboard = {
                          connect_number: previous_monthly_goal_data.connect_number,
                          initiator_count1:
                            previous_monthly_goal_data.user_id === user_id
                              ? previous_monthly_goal_data.initiator_count
                              : previous_monthly_goal_data.initiator_count1,
                          initiator_count2:
                            previous_monthly_goal_data.user_id === user_id
                              ? previous_monthly_goal_data.initiator_count1
                              : previous_monthly_goal_data.initiator_count,
                          complete_count: previous_monthly_goal_data.complete_count,
                          contribution1:
                            previous_monthly_goal_data.user_id === user_id
                              ? previous_monthly_goal_data.contribution1
                              : previous_monthly_goal_data.contribution2,
                          contribution2:
                            previous_monthly_goal_data.user_id === user_id
                              ? previous_monthly_goal_data.contribution2
                              : previous_monthly_goal_data.contribution1,
                          patner1_user_id: userdata.id,
                          patner1_first_name: userdata.first_name,
                          patner1_last_name: userdata.last_name,
                          patner1_gender: userdata.gender,
                          patner1_profile_image: userdata.profile_image
                            ? `${config.site_url}profile_images/${userdata.profile_image}`
                            : null,
                          patner2_user_id: patnerData.id,
                          patner2_first_name: patnerData.first_name,
                          patner2_last_name: patnerData.last_name,
                          patner2_gender: patnerData.gender,
                          patner2_profile_image: patnerData.profile_image
                            ? `${config.site_url}profile_images/${patnerData.profile_image}`
                            : null,
                        };
                        return res.send({
                          status: 200,
                          result: dashboard,
                        });
                      } else {
                        let dashboard = {
                          connect_number: "0",
                          initiator_count1: "0",
                          initiator_count2: "0",
                          complete_count: "0",
                          contribution1: "0",
                          contribution2: "0",
                          patner1_user_id: userdata.id,
                          patner1_first_name: userdata.first_name,
                          patner1_last_name: userdata.last_name,
                          patner1_gender: userdata.gender,
                          patner1_profile_image: userdata.profile_image
                            ? `${config.site_url}profile_images/${userdata.profile_image}`
                            : null,
                          patner2_user_id: patnerData.id,
                          patner2_first_name: patnerData.first_name,
                          patner2_last_name: patnerData.last_name,
                          patner2_gender: patnerData.gender,
                          patner2_profile_image: patnerData.profile_image
                            ? `${config.site_url}profile_images/${patnerData.profile_image}`
                            : null,
                        };
                        return res.send({
                          status: 200,
                          result: dashboard,
                        });
                      }
                    }
                    if (err) {
                      return res.send({
                        status: 400,
                        messgae: "partner is not found",
                      });
                    }
                  });
                } else {
                  return res.send({
                    status: 504,
                    message: "User is not found",
                  });
                }
              }
            });
          }
        });
      } else {
        return res.send({
          status: 504,
          message: "partner is not found",
        });
      }
    }
  });
});

//create new monthly goal
router.post("/createNewmonthlygoal", verifyToken, function (req, res) {
  // let partner_mapping_id = req.body.partner_mapping_id;
  let user_id = jwt.decode(req.headers["x-access-token"]).id;
  let connect_number = req.body.connect_number;
  // let percentage         = req.body.percentage;/
  let intimate_account_time = req.body.intimate_account_time;
  let intimate_request_time = req.body.intimate_request_time;
  let intimate_time = req.body.intimate_time;
  let initiator_count = req.body.initiator_count;
  let initiator_count1 = req.body.initiator_count1;
  let hours = req.body.hours;

  if (!user_id) {
    return res.send({
      status: 400,
      message: "User id is required.",
    });
  }

  if (!formValidator.isInt(user_id)) {
    return res.send({
      status: 400,
      message: "Please enter a valid user id.",
    });
  }

  if (!connect_number) {
    return res.send({
      status: 400,
      message: "Please enter a valid information.",
    });
  }

  if (!formValidator.isInt(connect_number)) {
    return res.send({
      status: 400,
      message: "Please enter a valid information.",
    });
  }

  if (!intimate_account_time) {
    return res.send({
      status: 400,
      message: "Please enter a valid information.",
    });
  }

  if (!intimate_request_time) {
    return res.send({
      status: 400,
      message: "Please enter a valid information.",
    });
  }

  if (!intimate_time) {
    return res.send({
      status: 400,
      message: "Please enter a valid information.",
    });
  }

  if (!initiator_count) {
    return res.send({
      status: 400,
      message: "Please enter a valid information.",
    });
  }

  if (!initiator_count1) {
    return res.send({
      status: 400,
      message: "Please enter a valid information.",
    });
  }
  // Check goal exists or not
  goalSerObject.checkParternstage(user_id, function (err, partnerMappingData) {
    if (err) {
      return res.send({
        status: 500,
        message: "something went wrong",
      });
    } else {
      if (partnerMappingData) {
        userSerObject.getUserById(partnerMappingData.partner_two_id, function (err, partenerData) {
          if (err) {
            return res.send({
              status: 400,
              message: "Invalid partner id provided",
            });
          } else {
            if (partenerData) {
              if (partenerData.stage === 7) {
                return res.send({
                  status: 400,
                  message: "Please Wait! The goal setup is already in progress by your partner.",
                });
              } else {
                var user_checker = 0;
                if (partnerMappingData.partner_one_id == user_id) {
                  user_checker++;
                }

                if (partnerMappingData.partner_two_id == user_id) {
                  user_checker++;
                }

                if (user_checker == 0) {
                  return res.send({
                    status: 400,
                    message: "Invalid partner id provided",
                  });
                } else {
                  const now = new Date();
                  var parter_id = 0;
                  if (partnerMappingData.partner_one_id != user_id) {
                    parter_id = partnerMappingData.partner_one_id;
                  }
                  if (partnerMappingData.partner_two_id != user_id) {
                    parter_id = partnerMappingData.partner_two_id;
                  }
                  // var initiator_count = customHelper.h_getNumberOfTimesPercentage(connect_number, percentage);
                  // var partner_percentage = 100 - percentage;
                  // var partner_initiator_count = connect_number - initiator_count;
                  let monthlyGoalData = {
                    partner_mapping_id: partnerMappingData.id,
                    user_id: user_id,
                    month_start: current_datetime.format(now, "YYYY-MM-DD"),
                    month_end: customHelper.h_get30daysAdvanceDate(),
                    connect_number: connect_number,
                    // 'percentage': percentage,
                    initiator_count: initiator_count,
                    initiator_count1: initiator_count1,
                    status: 1,
                    intimate_time: intimate_time,
                    intimate_request_time: intimate_request_time,
                    intimate_account_time: intimate_account_time,
                    partner_id: parter_id,
                    // 'partner_percentage': partner_percentage,
                    partner_initiator_count: initiator_count,
                    hours: hours,
                  };
                  goalSerObject.createMonthlyGoal(monthlyGoalData, function (err, monthlyGoalDataSaved) {
                    if (err) {
                      return res.send({
                        status: 504,
                        message: "something went wrong.",
                      });
                    } else {
                      if (monthlyGoalDataSaved) {
                        // schedules.stop();
                        userSerObject.getUserById(user_id, function (err, userData) {
                          if (err) {
                            return res.send({
                              status: 400,
                              message: "something went wrong.",
                            });
                          } else {
                            if (userData) {
                              userSerObject.getPartnerById(user_id, function (err, partnerData) {
                                if (err) {
                                  return res.send({
                                    status: 400,
                                    message: "something went wrong.",
                                  });
                                } else {
                                  if (partnerData) {
                                    const [time, modifier] = monthlyGoalDataSaved.intimate_request_time.split(" ");
                                    let [hours, minutes] = time.split(":");
                                    if (hours === "12") {
                                      hours = "00";
                                    }
                                    if (modifier === "PM") {
                                      hours = parseInt(hours, 10) + 12;
                                    }
                                    var night = new Date(
                                      now.getFullYear(),
                                      now.getMonth(),
                                      now.getDate(),
                                      hours,
                                      minutes,
                                      0
                                    );

                                    // var month = date.getMonth() + 1;
                                    // var year = date.getFullYear();
                                    var month = current_datetime.format(night, "MM", true);
                                    var year = current_datetime.format(night, "YYYY", true);
                                    minutes = current_datetime.format(night, "mm");
                                    hours = current_datetime.format(night, "HH");
                                    let day = parseInt(
                                      new Date(year, month, 0).getDate() / monthlyGoalDataSaved.connect_number
                                    );
                                    if (day <= 0) {
                                      day = 1;
                                    }
                                    let day1 = parseInt(new Date().getDate());
                                    schedules1 && schedules1.stop();
                                    //${parseInt(minutes)} ${hours} ${day1} ${month} *
                                    schedules1 = cron.schedule(
                                      `${parseInt(minutes)} ${hours} ${day1} ${month} *`,
                                      () => {
                                        // cron.schedule(`* * * * *`, (err, ress) => {
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
                                          goalSerObject.getGoalDetails(
                                            userData.id,
                                            partnerData.id,
                                            function (err, monthlyGoal_data) {
                                              if (err) {
                                                return res.send({
                                                  status: 404,
                                                  message: "Something went wrong!",
                                                });
                                              } else {
                                                if (monthlyGoal_data) {
                                                  let contribution1 = monthlyGoal_data.contribution1;
                                                  let contribution2 = monthlyGoal_data.contribution2;
                                                  let initiator_count1 = monthlyGoal_data.initiator_count;
                                                  let initiator_count2 = monthlyGoal_data.initiator_count1;
                                                  let connect_number = monthlyGoal_data.connect_number;
                                                  let totalcontribution1 = connect_number * initiator_count1 / 100
                                                  let totalcontribution2 = connect_number * initiator_count2 / 100
                                                  let ct1 = contribution1 * 100 / totalcontribution1
                                                  let ct2 = contribution2 * 100 / totalcontribution2
                                                  let Check = false;
                                                  if (user_id != monthlyGoal_data.user_id) {
                                                    if (ct1 < ct2) {
                                                      Check = false;
                                                    }
                                                    else if (ct2 < ct1) {
                                                      Check = true;
                                                    }
                                                    else if (ct1 === ct2) {
                                                      if (initiator_count1 < initiator_count2) {
                                                        Check = true;
                                                      }
                                                      else if (initiator_count2 < initiator_count1) {
                                                        Check = false;
                                                      }
                                                      else {
                                                        Check = false;
                                                      }
                                                    }
                                                  }
                                                  else {
                                                    if (ct1 < ct2) {
                                                      Check = true;
                                                    }
                                                    else if (ct2 < ct1) {
                                                      Check = false;
                                                    }
                                                    else if (ct1 === ct2) {
                                                      if (initiator_count1 < initiator_count2) {
                                                        Check = false;
                                                      }
                                                      else if (initiator_count2 < initiator_count1) {
                                                        Check = true;
                                                      }
                                                      else {
                                                        Check = true;
                                                      }
                                                    }
                                                  }
                                                  let quikceydata = {
                                                    user_id: Check === true ? monthlyGoal_data.user_id : partnerData.id,
                                                    partner_mapping_id: partnerMappingData.id,
                                                  }
                                                  quickynObject.saveQuickybeforenotification(quikceydata, function (err, quickeydata) {
                                                    if (err) {
                                                      return res.send({
                                                        status: 404,
                                                        message: "Something went wrong!!"
                                                      })
                                                    }
                                                    else {
                                                      var date = new Date();
                                                      var Startdate = new Date(monthlyGoal_data.month_start).getTime();
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
                                                      let notification1 = {
                                                        user_id: userData.id,
                                                        goal_id: monthlyGoalDataSaved.id,
                                                        device_id: userData.fcmid,
                                                        notification_id: "null",
                                                      };
                                                      notificationObject.saveNotification(
                                                        notification1,
                                                        function (err, response) {
                                                          let notificationdata = {
                                                            user_id: user_id,
                                                            title: "Dating",
                                                            message: `You are at ${Notificationmessage.PR}% of goal with ${Notificationmessage.remaing_days} days left in the month.
                                                              Would you like to make a connection tonight?`,
                                                            type: "remember",
                                                            checkans: Check,
                                                            quickey_id: quickeydata.id
                                                          }
                                                          notificationObject.addnotification(notificationdata,
                                                            function (err, response) {
                                                              notificationObject.notification(
                                                                userData.fcmid,
                                                                Notificationmessage,
                                                                Check,
                                                                response.id,
                                                                response.quickey_id,
                                                                function (err, response) { }
                                                              );
                                                            }
                                                          )
                                                        }
                                                      );
                                                      let notification12 = {
                                                        user_id: partnerData.id,
                                                        goal_id: monthlyGoalDataSaved.id,
                                                        device_id: partnerData.fcmid,
                                                        notification_id: "null",
                                                      };
                                                      notificationObject.saveNotification(
                                                        notification12,
                                                        function (err, response) {
                                                          let notificationdata = {
                                                            user_id: partnerData.id,
                                                            title: "Dating",
                                                            message: `You are at ${Notificationmessage.PR}% of goal with ${Notificationmessage.remaing_days} days left in the month.
                                                              Would you like to make a connection tonight?`,
                                                            type: "remember",
                                                            checkans: !Check,
                                                            quickey_id: quickeydata.id
                                                          }
                                                          notificationObject.addnotification(notificationdata,
                                                            function (err, response) {
                                                              notificationObject.notification(
                                                                partnerData.fcmid,
                                                                Notificationmessage,
                                                                !Check,
                                                                response.id,
                                                                response.quickey_id,
                                                                function (err, response) { }
                                                              );
                                                            }
                                                          )
                                                        }
                                                      );
                                                    }
                                                  })
                                                  //${parseInt(minutes)} ${hours} */${day} * *
                                                  cron.schedule(`${parseInt(minutes)} ${hours} */${day} * *`, () => {
                                                    // cron.schedule(`* * * * *`, (err, ress) => {
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
                                                      goalSerObject.getGoalDetails(
                                                        userData.id,
                                                        partnerData.id,
                                                        function (err, monthlyGoal_data) {
                                                          if (err) {
                                                            return res.send({
                                                              status: 404,
                                                              message: "Something went wrong!",
                                                            });
                                                          } else {
                                                            if (monthlyGoal_data) {
                                                              let contribution1 = monthlyGoal_data.contribution1;
                                                              let contribution2 = monthlyGoal_data.contribution2;
                                                              let initiator_count1 = monthlyGoal_data.initiator_count;
                                                              let initiator_count2 = monthlyGoal_data.initiator_count1;
                                                              let connect_number = monthlyGoal_data.connect_number;
                                                              let totalcontribution1 = connect_number * initiator_count1 / 100
                                                              let totalcontribution2 = connect_number * initiator_count2 / 100
                                                              let ct1 = contribution1 * 100 / totalcontribution1
                                                              let ct2 = contribution2 * 100 / totalcontribution2
                                                              let Check = false;
                                                              if (user_id != monthlyGoal_data.user_id) {
                                                                if (ct1 < ct2) {
                                                                  Check = false;
                                                                }
                                                                else if (ct2 < ct1) {
                                                                  Check = true;
                                                                }
                                                                else if (ct1 === ct2) {
                                                                  if (initiator_count1 < initiator_count2) {
                                                                    Check = true;
                                                                  }
                                                                  else if (initiator_count2 < initiator_count1) {
                                                                    Check = false;
                                                                  }
                                                                  else {
                                                                    Check = false;
                                                                  }
                                                                }
                                                              }
                                                              else {
                                                                if (ct1 < ct2) {
                                                                  Check = true;
                                                                }
                                                                else if (ct2 < ct1) {
                                                                  Check = false;
                                                                }
                                                                else if (ct1 === ct2) {
                                                                  if (initiator_count1 < initiator_count2) {
                                                                    Check = false;
                                                                  }
                                                                  else if (initiator_count2 < initiator_count1) {
                                                                    Check = true;
                                                                  }
                                                                  else {
                                                                    Check = true;
                                                                  }
                                                                }
                                                              }
                                                              let quikceydata = {
                                                                user_id: Check === true ? monthlyGoal_data.user_id : partnerData.id,
                                                                partner_mapping_id: partnerMappingData.id,
                                                              }

                                                              quickynObject.saveQuickybeforenotification(quikceydata, function (err, quickeydata) {

                                                                var date = new Date();
                                                                var Startdate = new Date(
                                                                  monthlyGoal_data.month_start
                                                                ).getTime();
                                                                var lastDay = new Date(
                                                                  monthlyGoal_data.month_end
                                                                ).getTime();
                                                                var current_date = lastDay - Startdate;
                                                                let remaing = current_date / (1000 * 3600 * 24);
                                                                // var lastDay = new Date(
                                                                //   date.getFullYear(),
                                                                //   date.getMonth() + 1,
                                                                //   0
                                                                // ).getDate();
                                                                // var current_date = date.getDate();
                                                                // let remaing = lastDay - current_date;
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
                                                                let notification1 = {
                                                                  user_id: userData.id,
                                                                  goal_id: monthlyGoalDataSaved.id,
                                                                  device_id: userData.fcmid,
                                                                  notification_id: "null",
                                                                };
                                                                notificationObject.saveNotification(
                                                                  notification1,
                                                                  function (err, response) {
                                                                    let notificationdata = {
                                                                      user_id: user_id,
                                                                      title: "Dating",
                                                                      message: `You are at ${Notificationmessage.PR}% of goal with ${Notificationmessage.remaing_days} days left in the month.
                                                                          Would you like to make a connection tonight?`,
                                                                      type: "remember",
                                                                      checkans: Check,
                                                                      quickey_id: quickeydata.id
                                                                    }
                                                                    notificationObject.addnotification(notificationdata,
                                                                      function (err, response) {
                                                                        notificationObject.notification(
                                                                          userData.fcmid,
                                                                          Notificationmessage,
                                                                          Check,
                                                                          response.id,
                                                                          response.quickey_id,
                                                                          function (err, response) { }
                                                                        );
                                                                      }
                                                                    )
                                                                  }
                                                                );
                                                                let notification12 = {
                                                                  user_id: partnerData.id,
                                                                  goal_id: monthlyGoalDataSaved.id,
                                                                  device_id: partnerData.fcmid,
                                                                  notification_id: "null",
                                                                };
                                                                notificationObject.saveNotification(
                                                                  notification12,
                                                                  function (err, response) {
                                                                    let notificationdata = {
                                                                      user_id: partnerData.id,
                                                                      title: "Dating",
                                                                      message: `You are at ${Notificationmessage.PR}% of goal with ${Notificationmessage.remaing_days} days left in the month.
                                                                          Would you like to make a connection tonight?`,
                                                                      type: "remember",
                                                                      checkans: !Check,
                                                                      quickey_id: quickeydata.id
                                                                    }
                                                                    notificationObject.addnotification(notificationdata,
                                                                      function (err, response) {
                                                                        notificationObject.notification(
                                                                          partnerData.fcmid,
                                                                          Notificationmessage,
                                                                          !Check,
                                                                          response.id,
                                                                          response.quickey_id,
                                                                          function (err, response) { }
                                                                        );
                                                                      }
                                                                    )
                                                                  }
                                                                );
                                                              }
                                                              )
                                                            }
                                                          }
                                                        });
                                                    }
                                                  });
                                                }
                                              }
                                            }
                                          );
                                        }
                                      }
                                    );
                                    schedules1.start();
                                    return res.send({
                                      status: 200,
                                      message: "The monthly goal has been successfully created.",
                                      stage: userData.stage,
                                      fcmid: partnerData.fcmid,
                                      Patner1_first_name: userData.first_name,
                                      Patner1_last_name: userData.last_name,
                                      patner1_stage: userData.stage,
                                      Patner2_first_name: partnerData.first_name,
                                      Patner2_last_name: partnerData.last_name,
                                      patner2_stage: partnerData.stage,
                                    });
                                  } else {
                                    return res.send({
                                      status: 500,
                                      message: "Partner is not found.",
                                    });
                                  }
                                }
                              });
                            } else {
                              return res.send({
                                status: 500,
                                message: "User is not found.",
                              });
                            }
                          }
                        });
                      }
                    }
                  });
                }
              }
            } else {
              return res.send({
                status: 504,
                messgae: "Patner is not found",
              });
            }
          }
        });
      } else {
        return res.send({
          status: 400,
          message: "This mapping has been expired",
        });
      }
    }
  });
});

//track unschedule

router.post("/sendtrackernotification", function (req, res) {
  let user_id = jwt.decode(req.headers["x-access-token"]).id;
  let answer2 = req.body.answer2;
  var now = new Date();
  var onTime = new Date(now.getFullYear(), now.getMonth(), now.getDate());
  userSerObject.getUserById(user_id, function (err, userData) {
    if (err) {
      return res.send({
        status: 400,
        message: "something went wrong.",
      });
    } else {
      if (userData) {
        setTimeout(() => {
          let data1 = {
            title: "Looks like you've made progress towards your monthly goal!",
            message: `testing`,
            type: "Reminder",
            answer2: answer2,
            onTime: onTime,
          };
          notificationObject.Sendnotificationfortracker(userData.fcmid, data1, function (err, response) {
            let notificationdata = {
              user_id: partnerData.id,
              title: "Looks like you've made progress towards your monthly goal!",
              message: `testing`,
              type: "Reminder",
            }
            notificationObject.addnotification(notificationdata,
              function (err, response) {
              }
            );
            if (err) {
              return res.send({
                status: 404,
                message: "Something went wrong",
              });
            } else {
              return res.send({
                status: 200,
                message: "Success",
              });
            }
          });
        });
      } else {
        return res.send({
          status: 400,
          message: "Partner is not found.",
        });
      }
    }
  });
});
//update count

router.post("/updateTracker", verifyToken, function (req, res) {
  let user_id = jwt.decode(req.headers["x-access-token"]).id;
  let answer2 = req.body.whoinitiative;
  userSerObject.getPartnerById(user_id, function (err, partner_data) {
    if (err) {
      return res.send({
        status: 400,
        message: "something went wrong!",
      });
    } else {
      if (partner_data) {
        goalSerObject.getGoalDetails(user_id, partner_data.id, function (err, monthly_goal_data) {
          if (err) {
            return res.send({
              status: 400,
              message: "something went wrong!",
            });
          } else {
            if (monthly_goal_data) {
              goalSerObject.getPartnerData(user_id, function (err, patner_mapping_data) {
                if (err) {
                  return res.send({
                    status: 400,
                    message: "something went wrong",
                  });
                } else {
                  let userID;

                  if (answer2 === "true") {
                    userID = user_id;
                  } else {
                    userID = partner_data.id;
                  }
                  let comepletion_goal = {
                    user_id: userID,
                    goal_id: monthly_goal_data.id,
                    partner_mapping_id: patner_mapping_data.id,
                    didYouConnectLastNight: "true",
                    whoinitiative: answer2,
                  };
                  let completeData = {
                    id: monthly_goal_data.id,
                    complete_count: parseInt(monthly_goal_data.complete_count) + 1,
                    contribution1:
                      monthly_goal_data.user_id === comepletion_goal.user_id
                        ? parseInt(monthly_goal_data.contribution1) + 1
                        : parseInt(monthly_goal_data.contribution1),
                    contribution2:
                      monthly_goal_data.user_id === comepletion_goal.user_id
                        ? parseInt(monthly_goal_data.contribution2)
                        : parseInt(monthly_goal_data.contribution2) + 1,
                  };
                  goalSerObject.updateCompleteCount(completeData, function (err, update_monthly_data) {
                    if (err) {
                      return res.send({
                        status: 400,
                        message: err,
                      });
                    } else {

                      if (update_monthly_data) {
                        completionSerObject.saveCompletionGoal(comepletion_goal, function (err, save_data) {
                          if (err) {
                            return res.send({
                              status: 504,
                              message: "something Went Wrong",
                            });
                          } else {
                            let untrackdata = {
                              user_id: userID,
                              whoinitiative: answer2,
                            };
                            if (save_data) {
                              goalSerObject.SaveUntrack(untrackdata, function (err, saveuntrack) {
                                if (err) {
                                  return res.send({
                                    status: 504,
                                    message: "something Went Wrong",
                                  });
                                } else {
                                  if (saveuntrack) {
                                    return res.send({
                                      status: 200,
                                      message: "save successfully",
                                      fcmid: partner_data.fcmid,
                                    });
                                  } else {
                                    return res.send({
                                      status: 504,
                                      message: "something Went Wrong",
                                    });
                                  }
                                }
                              });
                            } else {
                              return res.send({
                                status: 504,
                                message: "something Went Wrong",
                              });
                            }
                          }
                        });
                      }
                      else {
                        return res.send({
                          status: 400,
                          message: "Something went wrong!!",
                        });
                      }
                    }
                  });
                }
              });
            }
            else {
              return res.send({
                status: 400,
                message: "Goal are not found!!",
              });
            }
          }
        });
      }
      else {
        return res.send({
          status: 400,
          message: "Partner data not found!!",
        });
      }
    }
  });
});

// get untrack data
router.get("/getuntrack/:id", verifyToken, function (req, res, next) {
  let user_id = jwt.decode(req.headers["x-access-token"]).id;
  const TODAY = new Date();
  if (!user_id) {
    return res.send({
      status: 400,
      message: "User Id is required.",
    });
  }
  goalSerObject.getPartnerData(user_id, function (err, parner_data) {
    if (err) {
      return res.send({
        status: 500,
        message: "something went wrong",
      });
    } else {
      let data = {
        user_id: user_id,
        today: TODAY,
      };
      goalSerObject.getUntrackdata(data, parner_data, function (err, patnerData) {
        if (err) {
          return res.send({
            status: 500,
            message: "something went wrong7 please try after some time.",
          });
        } else {
          if (patnerData.length) {
            return res.send({
              status: 400,
              message: `${patnerData[0].whoinitiative === "true" ? "You" : "Your partner"} just tracked unscheduled sex. Looks like you're making progress towards your monthly goal!`,
              todaysSchedule: patnerData.length
            });
          }
          return res.send({
            status: 400,
            message: "You can track unscheduled sex ",
            todaysSchedule: patnerData.length
          });
        }
      });
    }
  });
});



router.post("/connectiontonight/:id", verifyToken, function (req, res, next) {
  let user_id = jwt.decode(req.headers["x-access-token"]).id;
  let quicky_id = req.params.id;
  let response = req.body.answer;
  quickynObject.getSingleQuickyRecord(quicky_id, function (err, QuickyResponse) {
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
        quickynObject.updateUserIntrest(
          quickData,
          function (err, UpdatedQuicky) {
            if (err) {
              res.send({
                status: 400,
                message: "Something Went Wrong!",
              });
            } else {
              if (UpdatedQuicky) {
                userSerObject.getPartnerById(
                  user_id,
                  function (err, PartnerData) {
                    if (err) {
                      res.send({
                        status: 400,
                        message: "Something Went Wrong!",
                      });
                    } else {
                      if (PartnerData) {
                        if (response === "true") {
                          if (QuickyResponse.user_id == user_id) {
                            if (
                              UpdatedQuicky.partner1_intrest ==
                              true &&
                              UpdatedQuicky.partner2_intrest ==
                              true
                            ) {
                              userSerObject.getUserById(
                                user_id,
                                function (err, userData) {

                                  if (err) {
                                    res.send({
                                      status: 400,
                                      message:
                                        "Something Went Wrong!",
                                    });
                                  } else {
                                    let quikceydata = {
                                      user_id: user_id,
                                      partner_mapping_id: QuickyResponse.partner_mapping_id,
                                    }

                                    quickynObject.saveQuickybeforenotification(quikceydata, function (err, quickeydata) {
                                      if (err) {
                                        res.send({
                                          status: 404,
                                          message: "Soemthing went wrong!!"
                                        })
                                      } else {
                                        let notificationdata = {
                                          user_id: user_id,
                                          title: "Connection confirmed",
                                          message: `Oh Yes! It's your lucky night!`,
                                          type: "Inform",
                                          checkans: "null",
                                          quickey_id: quickeydata.id
                                        }
                                        notificationObject.addnotification(notificationdata,
                                          function (err, response) {
                                            let data = {
                                              title:
                                                "OPTIMIZE | HARMONIZE",
                                              message: `You have an alert from Oh!. Log in to respond…`,
                                              type:
                                                "Inform",
                                              notification_id: response.id,
                                              quickey_id: response.quickey_id,
                                            };
                                            notificationObject.Sendnotification(
                                              PartnerData.fcmid,
                                              data,
                                              response.id,
                                              response.quickey_id,
                                              function (err, response) {
                                              }
                                            )
                                          }

                                        );
                                        let notificationdata1 = {
                                          user_id: PartnerData.id,
                                          title: "Connection confirmed",
                                          message: `Oh Yes! It's your lucky night!`,
                                          type: "Inform",
                                          checkans: "null",
                                          quickey_id: quickeydata.id
                                        }
                                        notificationObject.addnotification(notificationdata1,
                                          function (err, response) {
                                            let data = {
                                              title:
                                                "OPTIMIZE | HARMONIZE",
                                              message: `You have an alert from Oh!. Log in to respond…`,
                                              type:
                                                "Inform",
                                              notification_id: response.id,
                                              quickey_id: response.quickey_id,
                                            };
                                            notificationObject.Sendnotification(
                                              PartnerData.fcmid,
                                              data,
                                              response.id,
                                              response.quickey_id,
                                              function (err, response) {
                                              }
                                            )
                                          }

                                        );

                                      }
                                    })
                                  }
                                });
                            }

                            if (UpdatedQuicky.partner2_intrest == false) {
                              res.send({
                                status: 400,
                                message:
                                  "Your partner is not interested to make a connection tonight.",
                                fcmid: PartnerData.fcmid,
                                partner1_intrest: UpdatedQuicky.partner1_intrest,
                                partner2_intrest: UpdatedQuicky.partner2_intrest
                              });
                            }
                            else if (UpdatedQuicky.partner2_intrest == true) {
                              res.send({
                                status: 200,
                                message: "User intrest save successfully",
                                fcmid: PartnerData.fcmid,
                                partner1_intrest: UpdatedQuicky.partner1_intrest,
                                partner2_intrest: UpdatedQuicky.partner2_intrest,
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
                                quickynObject.getSingleQuickyRecord(
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
                                            partner1_intrest: Quickies.partner1_intrest,
                                            partner2_intrest: Quickies.partner2_intrest,
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
                                            partner1_intrest: Quickies.partner1_intrest,
                                            partner2_intrest: Quickies.partner2_intrest,
                                          });
                                        } else {
                                          userSerObject.getUserById(
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
                                                  userSerObject.getPartnerById(
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
                                                          goalSerObject.getGoalDetails(
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
                                                                          let quickeydata = {
                                                                            user_id: user_id,
                                                                            partner_mapping_id: QuickyResponse.partner_mapping_id,
                                                                          }
                                                                          quickynObject.saveQuickybeforenotification(quickeydata, function (err, quickeydata) {
                                                                            if (err) {
                                                                              return res.send({
                                                                                status: 404,
                                                                                message: "Something went wrong!!"
                                                                              })
                                                                            }
                                                                            else {
                                                                              let notificationdata = {
                                                                                user_id: user_id,
                                                                                title: "FeedBack for last night",
                                                                                message: `Did you connect last night?`,
                                                                                type: "feedback",
                                                                                checkans: "null",
                                                                                quickey_id: quickeydata.id
                                                                              }
                                                                              notificationObject.addnotification(notificationdata,
                                                                                function (err, response) {
                                                                                  let data = {
                                                                                    title:
                                                                                      "OPTIMIZE | HARMONIZE",
                                                                                    message: `You have an alert from Oh!. Log in to respond…`,
                                                                                    type:
                                                                                      "feedback",
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
                                                                                    ) {
                                                                                    }
                                                                                  );
                                                                                }

                                                                              );

                                                                              let notificationdata2 = {
                                                                                user_id: partnerData.id,
                                                                                title: "FeedBack for last night",
                                                                                message: `Did you connect last night?`,
                                                                                type: "feedback",
                                                                                checkans: "null",
                                                                                quickey_id: quickeydata.id
                                                                              }
                                                                              notificationObject.addnotification(notificationdata2,
                                                                                function (err, response) {
                                                                                  let data = {
                                                                                    title:
                                                                                      "OPTIMIZE | HARMONIZE",
                                                                                    message: `You have an alert from Oh!. Log in to respond…`,
                                                                                    type:
                                                                                      "feedback",
                                                                                    notification_id: response.id,
                                                                                    quickey_id: response.quickey_id,
                                                                                  };
                                                                                  notificationObject.Sendnotification(
                                                                                    userData.fcmid,
                                                                                    data,
                                                                                    response.id,
                                                                                    response.quickey_id,
                                                                                    function (
                                                                                      err,
                                                                                      response
                                                                                    ) { }
                                                                                  );
                                                                                }
                                                                              );
                                                                            }
                                                                          })
                                                                        },
                                                                        timeout
                                                                      );
                                                                    } else {

                                                                      setTimeout(
                                                                        () => {
                                                                          let quickeydata = {
                                                                            user_id: user_id,
                                                                            partner_mapping_id: QuickyResponse.partner_mapping_id,

                                                                          }
                                                                          quickynObject.saveQuickybeforenotification(quickeydata, function (err, quickeydata) {
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
                                                                                checkans: "null",
                                                                                quickey_id: quickeydata.id
                                                                              }
                                                                              notificationObject.addnotification(notificationdata,
                                                                                function (err, response) {
                                                                                  let data = {
                                                                                    title:
                                                                                      "OPTIMIZE | HARMONIZE",
                                                                                    message: `You have an alert from Oh!. Log in to respond…`,
                                                                                    type:
                                                                                      "feedback",
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
                                                                                  );
                                                                                }
                                                                              );


                                                                              let notificationdata2 = {
                                                                                user_id: partnerData.id,
                                                                                title: "FeedBack for last night",
                                                                                message: `Did you connect last night?`,
                                                                                type: "feedback",
                                                                                checkans: "null",
                                                                                quickey_id: quickeydata.id
                                                                              }
                                                                              notificationObject.addnotification(notificationdata2,
                                                                                function (err, response) {
                                                                                  let data = {
                                                                                    title:
                                                                                      "OPTIMIZE | HARMONIZE",
                                                                                    message: `You have an alert from Oh!. Log in to respond…`,
                                                                                    type:
                                                                                      "feedback",
                                                                                    notification_id: response.id,
                                                                                    quickey_id: response.quickey_id,
                                                                                  };
                                                                                  notificationObject.Sendnotification(
                                                                                    userData.fcmid,
                                                                                    data,
                                                                                    response.id,
                                                                                    response.quickey_id,
                                                                                    function (
                                                                                      err,
                                                                                      response
                                                                                    ) { }
                                                                                  );
                                                                                }
                                                                              );
                                                                            }
                                                                          })

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
                                message: "User interest save successfully",
                                fcmid: PartnerData.fcmid,
                                partner1_intrest: UpdatedQuicky.partner1_intrest,
                                partner2_intrest: UpdatedQuicky.partner2_intrest,
                              });
                            }
                          } else {
                            if (
                              UpdatedQuicky.partner1_intrest ==
                              true &&
                              UpdatedQuicky.partner2_intrest ==
                              true
                            ) {
                              userSerObject.getUserById(
                                user_id,
                                function (err, userData) {
                                  if (err) {
                                    res.send({
                                      status: 400,
                                      message:
                                        "Something Went Wrong!",
                                    });
                                  } else {
                                    let quickeydata = {
                                      user_id: user_id,
                                      partner_mapping_id: QuickyResponse.partner_mapping_id,
                                    }

                                    quickynObject.saveQuickybeforenotification(quickeydata, function (err, quickeydata) {

                                      if (err) {
                                        return res.send({
                                          status: 404,
                                          message: "Something went wrong!!"
                                        })
                                      } else {
                                        let notificationdata = {
                                          user_id: user_id,
                                          title: "Connection confirmed",
                                          message: `Oh Yes! It's your lucky night!`,
                                          type: "Inform",
                                          checkans: "null",
                                          quickey_id: quickeydata.id
                                        }
                                        notificationObject.addnotification(notificationdata,
                                          function (err, response) {
                                            let data = {
                                              title:
                                                "OPTIMIZE | HARMONIZE",
                                              message: `You have an alert from Oh!. Log in to respond…`,
                                              type:
                                                "Inform",
                                              notification_id: response.id,
                                              quickey_id: response.quickey_id,
                                            };
                                            notificationObject.Sendnotification(
                                              PartnerData.fcmid,
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

                                        let notificationdata2 = {
                                          user_id: PartnerData.id,
                                          title: "Connection confirmed",
                                          message: `Oh Yes! It's your lucky night!`,
                                          type: "Inform",
                                          checkans: "null",
                                          quickey_id: quickeydata.id
                                        }
                                        notificationObject.addnotification(notificationdata2,
                                          function (err, response) {
                                            let data = {
                                              title:
                                                "OPTIMIZE | HARMONIZE",
                                              message: `You have an alert from Oh!. Log in to respond…`,
                                              type:
                                                "Inform",
                                              notification_id: response.id,
                                              quickey_id: response.quickey_id,
                                            };
                                            notificationObject.Sendnotification(
                                              userData.fcmid,
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
                                  }
                                });
                            }
                            if (UpdatedQuicky.partner1_intrest == false) {
                              res.send({
                                status: 200,
                                message: "User interest save successfully!!!!",
                                fcmid: PartnerData.fcmid,
                                partner1_intrest: UpdatedQuicky.partner1_intrest,
                                partner2_intrest: UpdatedQuicky.partner2_intrest,
                              });
                            } else if (UpdatedQuicky.partner1_intrest == true) {
                              res.send({
                                status: 200,
                                message: "User interest save successfully",
                                fcmid: PartnerData.fcmid,
                                partner1_intrest: UpdatedQuicky.partner1_intrest,
                                partner2_intrest: UpdatedQuicky.partner2_intrest,
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
                                quickynObject.getSingleQuickyRecord(
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
                                            status: 400,
                                            message:
                                              "Any one partner is not intrested.",
                                            fcmid: PartnerData.fcmid,
                                            partner1_intrest: Quickies.partner1_intrest,
                                            partner2_intrest: Quickies.partner2_intrest
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
                                          userSerObject.getUserById(
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
                                                  userSerObject.getPartnerById(
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
                                                          goalSerObject.getGoalDetails(
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
                                                                          let quickeydata = {
                                                                            user_id: user_id,
                                                                            partner_mapping_id: QuickyResponse.partner_mapping_id,
                                                                          }
                                                                          quickynObject.saveQuickybeforenotification(quickeydata, function (err, quickeydata) {
                                                                            if (err) {
                                                                              return res.send({
                                                                                status: 404,
                                                                                message: "Something went wrong!"
                                                                              })
                                                                            } else {
                                                                              let notificationdata = {
                                                                                user_id: user_id,
                                                                                title: "FeedBack for last night",
                                                                                message: `Did you connect last night?`,
                                                                                type: "feedback",
                                                                                checkans: "null",
                                                                                quickey_id: quickeydata.id
                                                                              }
                                                                              notificationObject.addnotification(notificationdata,
                                                                                function (err, response) {
                                                                                  let data = {
                                                                                    title:
                                                                                      "OPTIMIZE | HARMONIZE",
                                                                                    message: `You have an alert from Oh!. Log in to respond…`,
                                                                                    type:
                                                                                      "feedback",
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
                                                                                  );
                                                                                }
                                                                              );

                                                                              let notificationdata2 = {
                                                                                user_id: PartnerData.id,
                                                                                title: "FeedBack for last night",
                                                                                message: `Did you connect last night?`,
                                                                                type: "feedback",
                                                                                checkans: "null",
                                                                                quickey_id: quickeydata.id
                                                                              }
                                                                              notificationObject.addnotification(notificationdata2,
                                                                                function (err, response) {
                                                                                  let data = {
                                                                                    title:
                                                                                      "OPTIMIZE | HARMONIZE",
                                                                                    message: `You have an alert from Oh!. Log in to respond…`,
                                                                                    type:
                                                                                      "feedback",
                                                                                    notification_id: response.id,
                                                                                    quickey_id: response.quickey_id,

                                                                                  };
                                                                                  notificationObject.Sendnotification(
                                                                                    userData.fcmid,
                                                                                    data,
                                                                                    response.id,
                                                                                    response.quickey_id,
                                                                                    function (
                                                                                      err,
                                                                                      response
                                                                                    ) { }
                                                                                  );
                                                                                }
                                                                              );

                                                                            }
                                                                          })
                                                                        },
                                                                        timeout
                                                                      );
                                                                    } else {

                                                                      setTimeout(
                                                                        () => {
                                                                          let quickeydata = {
                                                                            user_id: user_id,
                                                                            partner_mapping_id: QuickyResponse.partner_mapping_id,
                                                                          }
                                                                          quickynObject.saveQuickybeforenotification(quickeydata, function (err, quickeydata) {
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
                                                                                checkans: "null",
                                                                                quickey_id: quickeydata.id
                                                                              }
                                                                              notificationObject.addnotification(notificationdata,
                                                                                function (err, response) {
                                                                                  let data = {
                                                                                    title:
                                                                                      "OPTIMIZE | HARMONIZE",
                                                                                    message: `You have an alert from Oh!. Log in to respond…`,
                                                                                    type:
                                                                                      "feedback",
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
                                                                                  );
                                                                                }
                                                                              );

                                                                              let notificationdata2 = {
                                                                                user_id: partnerData.id,
                                                                                title: "FeedBack for last night",
                                                                                message: `Did you connect last night?`,
                                                                                type: "feedback",
                                                                                checkans: "null",
                                                                                quickey_id: quickeydata.id
                                                                              }
                                                                              notificationObject.addnotification(notificationdata2,
                                                                                function (err, response) {
                                                                                  let data = {
                                                                                    title:
                                                                                      "OPTIMIZE | HARMONIZE",
                                                                                    message: `You have an alert from Oh!. Log in to respond…`,
                                                                                    type:
                                                                                      "feedback",
                                                                                    notification_id: response.id,
                                                                                    quickey_id: response.quickey_id,
                                                                                  };
                                                                                  notificationObject.Sendnotification(
                                                                                    userData.fcmid,
                                                                                    data,
                                                                                    response.id,
                                                                                    response.quickey_id,
                                                                                    function (
                                                                                      err,
                                                                                      response
                                                                                    ) { }
                                                                                  );
                                                                                }
                                                                              );
                                                                            }
                                                                          })
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
                                message: "User interest save successfully",
                                fcmid: PartnerData.fcmid,
                                partner1_intrest: UpdatedQuicky.partner1_intrest,
                                partner2_intrest: UpdatedQuicky.partner2_intrest,
                              });
                            }
                          }
                        }
                        else if (response === "false") {
                          res.send({
                            status: 200,
                            message: "You are not interested to make a connection tonight.",
                            fcmid: PartnerData.fcmid,
                            partner1_intrest: UpdatedQuicky.partner1_intrest,
                            partner2_intrest: UpdatedQuicky.partner2_intrest,
                          })
                          let quikceydata = {
                            user_id: QuickyResponse.user_id,
                            partner_mapping_id: QuickyResponse.partner_mapping_id,
                          }

                          quickynObject.saveQuickybeforenotification(quikceydata, function (err, quickeydata) {

                            let notificationdata = {
                              user_id: PartnerData.id,
                              title: "Connection request rejected",
                              message: "Your partner is not interested to make a connection tonight.",
                              type: "Inform",
                              checkans: "null",
                              quickey_id: quickeydata.id
                            }
                            notificationObject.addnotification(notificationdata,
                              function (err, response) {
                                let data = {
                                  title:
                                    "OPTIMIZE | HARMONIZE",
                                  message: `You have an alert from Oh!. Log in to respond…`,
                                  type:
                                    "Inform",
                                  notification_id: response.id,
                                  quickey_id: response.quickey_id,
                                };
                                notificationObject.Sendnotification(
                                  PartnerData.fcmid,
                                  data,
                                  response.id,
                                  response.quickey_id,
                                  function (err, response) {
                                  }
                                )
                              }
                            )
                          })

                        } else {
                          res.send({
                            status: 200,
                            message: "User interest save successfully!!",
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
module.exports = router;
