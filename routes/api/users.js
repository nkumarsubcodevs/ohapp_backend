/**
 * @desc this file will contains the routes for user api
 * @author Navneet Kumar navneet.kumar@subcodevs.com
 * @file users.js
 */

const express = require("express");
const UserService = require("../../services/UserService");
const GoalService = require("../../services/GoalService");
const QuickyService = require("../../services/QuickyService");
const FeedbackService = require("../../services/FeedbackService");
const NotificationService = require('../../services/NotificationService');
var notificationObject = new NotificationService();


const formValidator = require("validator");
const path = require("path");
const customHelper = require("../../helpers/custom_helper");
// JWT web token
const jwt = require("jsonwebtoken");

// Get API secret
const config = require("../../config/config");

// verifytoken middleware
const verifyToken = require("./verifytoken");

// Include image upload lib
const multer = require("multer");

const multerConf = {
  storage: multer.diskStorage({
    destination: (req, file, next) => {
      next(null, "public/profile_images");
    },
    filename: function (req, file, next) {
      const ext = file.mimetype.split("/")[1];
      next(null, Date.now() + "." + ext);
    },
  }),
  limits: {
    fileSize: 250000,
  },
  fileFilter: function (req, file, next) {
    if (!file) {
      next();
    }

    const image = file.mimetype.startsWith("image/");

    if (image) {
      next(null, true);
    } else {
      next({ message: "Please upload valid file format(jpg, jpeg, png)" }, false);
    }
  },
};

var uploadObject = multer(multerConf).single("user_photo");

// Create route object
let router = express.Router();

// Create user model object
var userSerObject = new UserService();

// Create goal model object
var goalObject = new GoalService();

// Create quicky model object
var quickyObject = new QuickyService();

// Create quicky model object
var feedbackObject = new FeedbackService();

// Get user detail
router.get("/getuserdetail/:user_id", verifyToken, function (req, res, next) {
  let user_id = req.params.user_id;

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

  userSerObject.getUserById(user_id, function (err, userData) {
    if (err) {
      res.send({
        status: 404,
        message: "Something went wrong please try after some time.",
      });
    } else {
      if (userData) {
        let userDetail = {
          id: userData.id,
          first_name: userData.first_name,
          last_name: userData.last_name,
          email: userData.email,
          role_id: userData.role_id,
          gender: userData.gender,
          image_profile: userData.profile_image,
          status: userData.status,
        };

        res.send({
          status: 200,
          result: userDetail,
        });
      } else {
        res.send({
          status: 404,
          message: "User is not found.",
        });
      }
    }
  });
});

// Get partner detail
router.get("/getpartnerdetail", verifyToken, function (req, res, next) {
  let user_id = jwt.decode(req.headers["x-access-token"]).id;

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

  userSerObject.getUserById(user_id, function (err, userData) {
    if (err) {
      res.send({
        status: 500,
        message: "Something went wrong please try after some time.",
      });
    } else {
      if (userData) {
        userSerObject.getPartnerById(user_id, function (err, partnerData, patner_mapping_data) {
          if (err) {
            res.send({
              status: 404,
              message: "Something went wrong please try after some time.",
            });
          } else {
            if (partnerData) {
              let partnerDetail = {
                id: partnerData.id,
                first_name: partnerData.first_name,
                last_name: partnerData.last_name,
                email: partnerData.email,
                role_id: partnerData.role_id,
                gender: partnerData.gender,
                image_profile: partnerData.profile_image
                  ? `${config.site_url}profile_images/${partnerData.profile_image}`
                  : null,
                status: partnerData.status,
                fcmID: partnerData.fcmid,
                stage: partnerData.stage,
              };
              if (partnerData.stage >= 4) {
                res.send({
                  status: 200,
                  result: partnerDetail,
                  patner_mapping_id: patner_mapping_data.id,
                  unique_id: patner_mapping_data.uniqe_id,
                });
              } else {
                res.send({
                  status: 400,
                  message: "Something went wrong please try after some time.",
                });
              }
            } else {
              res.send({
                status: 404,
                message: "Partner is not found.",
              });
            }
          }
        });
      } else {
        res.send({
          status: 404,
          message: "User is not found.",
        });
      }
    }
  });
});

// Get user unique code
router.get("/getuniquecode/:user_id", verifyToken, function (req, res, next) {
  let user_id = req.params.user_id;

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

  userSerObject.getUserById(user_id, function (err, userData) {
    if (err) {
      res.send({
        status: 500,
        message: "Something went wrong please try after some time.",
      });
    } else {
      if (userData) {
        userSerObject.updateUserStage(2, user_id, function (err, userStageData) {
          if (userStageData) {
            let userDetail = {
              unique_code: userStageData.unique_code,
              stage: userStageData.stage,
            };
            res.send({
              status: 200,
              result: userDetail,
            });
          }
        });
      } else {
        res.send({
          status: 404,
          message: "User is not found.",
        });
      }
    }
  });
});

// Create unique code
router.get("/createuniquecode", verifyToken, function (req, res, next) {
  let user_id = jwt.decode(req.headers["x-access-token"]).id;

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

  userSerObject.reGenerateUniqueCode(user_id, function (err, userData) {
    if (err) {
      res.send({
        status: 500,
        message: "There was a problem finding the user.",
      });
    } else {
      if (userData) {
        let userDetail = {
          unique_code: userData.unique_code,
        };

        res.send({
          status: 200,
          result: userDetail,
        });
      } else {
        res.send({
          status: 404,
          message: "User is not found.",
        });
      }
    }
  });
});

// New user registration API
router.post("/register", function (req, res) {
  let first_name = req.body.first_name;
  let last_name = req.body.last_name;
  let gender = req.body.gender;
  let email = req.body.email;
  // let password = req.body.password;
  // let confirm_password     = req.body.confirm_password;
  let role_id = 2;
  let status = 1;

  if (!first_name) {
    return res.send({
      status: 400,
      message: "First name is required",
    });
  }

  if (!formValidator.isAlpha(first_name, ["en-US"])) {
    return res.send({
      status: 400,
      message: "Please enter a valid first name",
    });
  }

  if (!last_name) {
    return res.send({
      status: 400,
      message: "Last name is required",
    });
  }

  if (!formValidator.isAlpha(last_name, ["en-US"])) {
    return res.send({
      status: 400,
      message: "Please enter a valid last name",
    });
  }

  if (!gender) {
    return res.send({
      status: 400,
      message: "Gender is required.",
    });
  }

  if (!formValidator.isAlpha(gender, ["en-US"])) {
    return res.send({
      status: 400,
      message: "Please enter a valid gender value(Male/Female).",
    });
  }

  if (!email) {
    return res.send({
      status: 400,
      message: "Email is required",
    });
  }

  if (!formValidator.isEmail(email)) {
    return res.send({
      status: 400,
      message: "Please enter a valid email",
    });
  }

  // if(!password)
  // {
  // 	return res.send({
  // 		status: 400,
  // 		message: 'Password is required',
  // 	});
  // }

  // if(!confirm_password)
  // {
  // 	return res.send({
  // 		status: 400,
  // 		message: 'Confirm password is required',
  // 	});
  // }

  // if(password!=confirm_password)
  // {
  // 	return res.send({
  // 		status: 400,
  // 		message: 'Password and confirm password should be same.',
  // 	});
  // }

  let userData = {
    role_id: role_id,
    first_name: first_name,
    last_name: last_name,
    gender: gender,
    email: email.toLowerCase(),
    // 'password': password,
    status: status,
  };

  userSerObject.getUserByEmail(email, function (err, user) {
    if (err) {
      res.send({
        status: 500,
        message: "something went wrong",
      });
    } else {
      if (user) {
        return res.send({
          status: 405,
          message: "Email-Id already registered: " + email,
        });
      } else {
        userSerObject.createUser(userData, function (err, userResultData) {
          if (err) {
            res.send({
              status: 500,
              message: "something went wrong",
            });
          } else {
            var access_token = jwt.sign({ id: userResultData.id }, config.secret, {
              expiresIn: 900,
            });

            var refresh_token = jwt.sign({ id: userResultData.id }, config.refreshsecret, {
              expiresIn: 86400,
            });

            res.cookie("access_token", access_token, { httpOnly: true });
            res.cookie("refresh_token", refresh_token, { httpOnly: true });

            res.send({
              status: 200,
              message: "success",
              result: userResultData.id,
              access_token: access_token,
              refresh_token: refresh_token,
            });
          }
        });
      }
    }
  });
});

// User login API
router.post("/login", function (req, res) {
  let email = req.body.email;
  let password = req.body.password;
  let fcmid = req.body.fcmid;
  if (!email) {
    return res.send({
      status: 400,
      message: "Email is required",
    });
  }

  if (!formValidator.isEmail(email)) {
    return res.send({
      status: 400,
      message: "Please enter a valid email",
    });
  }

  if (!password) {
    return res.send({
      status: 400,
      message: "Password is required",
    });
  }

  if (!fcmid) {
    return res.send({
      status: 400,
      message: "FcmID is required",
    });
  }

  let userData = {
    email: email,
    password: password,
    fcmid: fcmid,
  };

  userSerObject.getUserByEmail(email, function (err, user) {
    if (err) {
      res.send({
        status: 500,
        message: "something went wrong",
      });
    } else {
      if (user) {
        userSerObject.comparePassword(password, user.password, function (err, isMatch) {
          if (err) {

            res.send({
              status: 500,
              message: "something went wrong",
            });
          } else {
            if (isMatch) {
              let userFcmidData = {
                user_id: user.id,
                fcmid: fcmid,
              };

              userSerObject.updateUserFcmID(userFcmidData, function (err, userFcmIDRespone) {
                if (err) {
                  res.send({
                    status: 500,
                    message: "Something went wrong please try after some time.",
                  });
                } else {
                  if (userFcmIDRespone) {
                    var access_token = jwt.sign({ id: user.id }, config.secret);

                    var refresh_token = jwt.sign({ id: user.id }, config.refreshsecret);
                    res.cookie("access_token", access_token, {
                      httpOnly: true,
                    });
                    res.cookie("refresh_token", refresh_token, {
                      httpOnly: true,
                    });

                    if (user.stage > 3) {
                      goalObject.checkParternstage(user.id, function (err, partnerData) {
                        if (err) {
                          res.send({
                            status: 500,
                            message: "There was a problem finding the partner user.",
                          });
                        } else {
                          if (partnerData) {
                            user.profile_image = user.profile_image
                              ? `${config.site_url}profile_images/${user.profile_image}`
                              : null;
                            res.send({
                              status: 200,
                              message: "success",
                              access_token: access_token,
                              refresh_token: refresh_token,
                              user_id: user.id,
                              stage: user.stage,
                              result: user,
                              patner_mapping_id: partnerData.id,
                            });
                          } else {
                            res.send({
                              status: 504,
                              message: "something went wrong!",
                            });
                          }
                        }
                      });
                    } else {
                      user.profile_image = user.profile_image
                        ? `${config.site_url}profile_images/${user.profile_image}`
                        : null;
                      res.send({
                        status: 200,
                        message: "success",
                        access_token: access_token,
                        refresh_token: refresh_token,
                        user_id: user.id,
                        stage: user.stage,
                        result: user,
                      });
                    }
                  } else {
                    res.send({
                      status: 404,
                      message: "There was a problem in update user fcid.",
                    });
                  }
                }
              });
            } else {
              return res.send({
                status: 401,
                message: "Invalid email or password.",
                auth: false,
                access_token: null,
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

// update user profile API
router.post("/profileupdate", verifyToken, function (req, res, next) {
  let user_id = jwt.decode(req.headers["x-access-token"]).id;
  let first_name = req.body.first_name;
  let last_name = req.body.last_name;

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

  if (!first_name) {
    return res.send({
      status: 400,
      message: "First name is required",
    });
  }

  if (!formValidator.isAlpha(first_name, ["en-US"])) {
    return res.send({
      status: 400,
      message: "Please enter a valid first name",
    });
  }

  if (!last_name) {
    return res.send({
      status: 400,
      message: "Last name is required",
    });
  }

  if (!formValidator.isAlpha(last_name, ["en-US"])) {
    return res.send({
      status: 400,
      message: "Please enter a valid last name",
    });
  }

  let userData = {
    user_id: user_id,
    first_name: first_name,
    last_name: last_name,
  };

  userSerObject.updateUserProfile(userData, function (err, userData) {
    if (err) {
      res.send({
        status: 500,
        message: "There was a problem finding the user.",
      });
    } else {
      if (userData) {
        (userData.profile_image = userData.profile_image
          ? `${config.site_url}profile_images/${userData.profile_image}`
          : null),
          res.send({
            status: 200,
            message: "The Profile updated successfully",
            result: userData,
          });
      } else {
        res.send({
          status: 404,
          message: "User is not found.",
        });
      }
    }
  });
});

// JWT Refresh Token API
router.post("/refreshtoken", (req, res) => {
  const refresh_token = req.cookies.refresh_token || null;
  const postData = req.body;

  if (!postData.id) {
    return res.send({
      status: 400,
      message: "User Id is required.",
    });
  }

  if (!formValidator.isInt(postData.id)) {
    return res.send({
      status: 400,
      message: "Please enter a valid user id.",
    });
  }

  if (!postData.refreshToken) {
    return res.send({
      status: 400,
      message: "Please provide a valid refresh token.",
    });
  }

  if (postData.refreshToken && postData.refreshToken == refresh_token) {
    var access_token = jwt.sign({ id: postData.id }, config.secret, {
      expiresIn: 900,
    });

    res.send({
      status: 200,
      message: "success",
      access_token: access_token,
    });
  } else {
    res.send({
      status: 404,
      message: "Invalid request",
    });
  }
});

// Get Forgot Password Email API
router.post("/forgotpasswordemail", function (req, res) {
  let email = req.body.email;

  if (!email) {
    return res.send({
      status: 400,
      message: "Email is required",
    });
  }

  if (!formValidator.isEmail(email)) {
    return res.send({
      status: 400,
      message: "Please enter a valid email",
    });
  }

  let userData = {
    email: email,
  };

  userSerObject.getUserByEmail(email, function (err, userData) {
    if (err) {
      res.send({
        status: 500,
        message: "something went wrong",
      });
    } else {
      if (userData) {
        let userDataWithtoken = {
          email: email,
        };

        userSerObject.sendForgotEmail(userDataWithtoken, function (err, userData) {
          if (err) {
            res.send({
              status: 500,
              message: "something went wrong",
            });
          } else {
            if (userData) {
              res.send({
                status: 200,
                message: "Your new password has been sent to your email address.",
              });
            } else {
              res.send({
                status: 404,
                message: "User is not found.",
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

// Get Change Password API
router.post("/changepassword", verifyToken, function (req, res) {
  let user_id = req.body.user_id;
  let new_password = req.body.new_password;
  let confirm_password = req.body.confirm_password;

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

  if (!new_password) {
    return res.send({
      status: 400,
      message: "New password is required",
    });
  }

  if (!confirm_password) {
    return res.send({
      status: 400,
      message: "Confirm password is required",
    });
  }

  if (new_password != confirm_password) {
    return res.send({
      status: 400,
      message: "New password and confirm password should be same.",
    });
  }

  let userData = {
    user_id: user_id,
    new_password: new_password,
    confirm_password: confirm_password,
  };

  userSerObject.getUserById(user_id, function (err, userData) {
    if (err) {
      res.send({
        status: 500,
        message: "Something went wrong please try after some time.",
      });
    } else {
      if (userData) {
        let userDataUpdate = {
          user_id: user_id,
          new_password: new_password,
          confirm_password: confirm_password,
        };

        userSerObject.updateUserPassword(userDataUpdate, function (err, userDataUpdate) {
          if (err) {
            res.send({
              status: 500,
              message: "something went wrong in update the password.",
            });
          } else {
            if (userDataUpdate) {
              res.send({
                status: 200,
                message: "Password updated successfully.",
              });
            } else {
              res.send({
                status: 404,
                message: "No user found.",
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

// Set Unavailability API
router.post("/unavailability", verifyToken, function (req, res) {
  let user_id = req.body.user_id;
  let unavailability_start = customHelper.h_getTime(req.body.unavailability_start);
  let unavailability_end = customHelper.h_getTime(req.body.unavailability_end);

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

  if (!unavailability_start) {
    return res.send({
      status: 400,
      message: "Unavailability start is required",
    });
  }

  if (!unavailability_end) {
    return res.send({
      status: 400,
      message: "Unavailability end is required",
    });
  }

  if (BigInt(unavailability_start) <= BigInt(customHelper.h_getTodayDateInTimeStamp())) {
    return res.send({
      status: 400,
      message: "Unavailability start time should be greater than current time.",
    });
  }

  if (BigInt(unavailability_end) <= BigInt(customHelper.h_getTodayDateInTimeStamp())) {
    return res.send({
      status: 400,
      message: "Unavailability end time should be greater than current time.",
    });
  }

  if (BigInt(unavailability_start) >= BigInt(unavailability_end)) {
    return res.send({
      status: 400,
      message: "Unavailability start time should be greater than unavailability end time.",
    });
  }

  userSerObject.getUserById(user_id, function (err, userDataResponse) {
    if (err) {
      res.send({
        status: 500,
        message: "something went wrong",
      });
    } else {
      if (userDataResponse) {
        let userData = {
          user_id: req.body.user_id,
          unavailability_start: req.body.unavailability_start,
          unavailability_end: req.body.unavailability_end,
        };

        userSerObject.addUnavailability(userData, function (err, userSaveData) {
          if (err) {
            res.send({
              status: 500,
              message: "something went wrong to add new record.",
            });
          } else {
            if (userSaveData) {
              res.send({
                status: 200,
                message: "Record added successfully.",
              });
            } else {
              res.send({
                status: 404,
                message: "something went wrong to add new record.",
              });
            }
          }
        });
      } else {
        return res.send({
          status: 400,
          message: "No user found",
        });
      }
    }
  });
});

// User logout
router.get("/logout", function (req, res) {
  res.clearCookie("access_token");
  res.clearCookie("refresh_token");

  res.send({
    status: 200,
    message: "success",
    auth: false,
    token: null,
  });
});

// Update profile image
router.post("/profileimageupload", verifyToken, (req, res, next) => {
  uploadObject(req, res, function (err) {
    if (err) {
      res.send({
        status: 500,
        message: err.message,
      });
    } else {
      let upload_file = req.file;
      let user_id = req.id;

      if (!user_id) {
        return res.send({
          status: 400,
          message: "User id is required",
        });
      }

      if (!upload_file.filename) {
        return res.send({
          status: 400,
          message: "Please select a valid image.",
        });
      }

      let userImageData = {
        user_id: user_id,
        upload_file: upload_file.filename,
      };

      userSerObject.getUserById(user_id, function (err, userData) {
        if (err) {
          res.send({
            status: 500,
            message: "Something went wrong please try after some time.",
          });
        } else {
          if (userData) {
            userSerObject.updateProfileImage(userImageData, function (err, userImageData) {
              if (err) {
                res.send({
                  status: 500,
                  message: "Please select a valid image.",
                });
              } else {
                if (userImageData) {
                  res.send({
                    status: 200,
                    message: "Image uploaded successfully.",
                    image_name: upload_file.filename,
                  });
                } else {
                  res.send({
                    status: 404,
                    message: "Please select a valid image..",
                  });
                }
              }
            });
          } else {
            res.send({
              status: 404,
              message: "User is not found.",
            });
          }
        }
      });
    }
  });
});

// Remove Pairing
router.delete("/unparring", verifyToken, function (req, res) {
  let user_id = jwt.decode(req.headers["x-access-token"]).id;
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
  userSerObject.getUserById(user_id, function (err, GetuserDetail) {
    if (err) {
      res.send({
        status: 400,
        message: "Users is not found.",
        stage: 1,
      });
    } else {
      if (GetuserDetail) {
        if (GetuserDetail.stage < 4) {
          res.send({
            status: 400,
            message: "Pairing is not available",
            stage: 1,
          });
        } else {
          userSerObject.getPartnerById(user_id, function (err, partnerData, patner_mapping_id) {
            if (err) {
              res.send({
                status: 500,
                message: "Something went wrong please try after some time.",
              });
            } else {
              if (partnerData) {
                userSerObject.RemoveParring(user_id, function (err, response) {
                  if (response) {
                    userSerObject.RemoveMonthlyGoal(user_id, partnerData.id, function (err, removeableData) {
                      if (removeableData) {
                        userSerObject.updateUserStage(1, partnerData.id, function (err, updatedPatnerStage) {
                          if (updatedPatnerStage) {
                            userSerObject.updateUserStage(1, user_id, function (err, updatedStage) {
                              if (updatedStage) {
                                res.send({
                                  status: 200,
                                  message: "unpaired Successfully!",
                                  stage: updatedStage.stage,
                                  partner_fcmid: updatedPatnerStage.fcmid,
                                });
                              } else {
                                res.send({
                                  status: 504,
                                  message: "something went wrong!",
                                });
                              }
                            });
                          } else {
                            res.send({
                              status: 504,
                              message: "Something went wrong!",
                            });
                          }
                        });
                      } else {
                        res.send({
                          status: 504,
                          message: "something went wrong",
                        });
                      }
                    });
                  } else {
                    res.send({
                      status: 504,
                      message: "something went wrong!",
                    });
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
        }
      } else {
        res.send({
          status: 404,
          message: "user is not found",
        });
      }
    }
  });
});

// Remove user Account
router.delete("/removeAccount", verifyToken, function (req, res) {
  let user_id = jwt.decode(req.headers["x-access-token"]).id;
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
  userSerObject.getUserById(user_id, function (err, GetuserDetail) {
    if (err) {
      res.send({
        status: 400,
        message: "Users is not found.",
        stage: 1,
      });
    } else {
      if (GetuserDetail) {
        if (GetuserDetail.stage < 4) {
          res.send({
            status: 400,
            message: "Paring is not avalibale",
            stage: 1,
          });
        } else {
          userSerObject.getPartnerById(
            user_id,
            function (err, partnerData, patner_mapping_id) {
              if (err) {
                res.send({
                  status: 500,
                  message: "There was a problem finding the partner user.",
                });
              } else {
                if (partnerData) {
                  userSerObject.RemoveParring(
                    user_id,
                    function (err, response) {
                      if (response) {
                        userSerObject.RemoveMonthlyGoal(
                          user_id,
                          partnerData.id,
                          function (err, removeableData) {
                            if (removeableData) {
                              userSerObject.updateUserStage(
                                1,
                                partnerData.id,
                                function (err, updatedStage) {
                                  if (updatedStage) {
                                    userSerObject.updateUserStage(
                                      1,
                                      user_id,
                                      function (err, userupdatedStage) {
                                        if (userupdatedStage) {
                                          userSerObject.RemoveAccount(
                                            user_id,
                                            function (err, removeAccountData) {
                                              if (err) {
                                                res.send({
                                                  status: 400,
                                                  message:
                                                    "Something went wrong",
                                                });
                                              } else {
                                                if (removeAccountData) {
                                                  feedbackObject.RemoveFeedback(
                                                    user_id,
                                                    function (
                                                      err,
                                                      removeFeedbackdata
                                                    ) {
                                                      if (err) {
                                                        res.send({
                                                          status: 400,
                                                          message:
                                                            "Something went wrong",
                                                        });
                                                      } else {
                                                        res.send({
                                                          status: 200,
                                                          message:
                                                            "Account deleted successfully",
                                                          patner_fcmid:
                                                            updatedStage.fcmid,
                                                        });
                                                      }
                                                    }
                                                  );
                                                } else {
                                                  res.send({
                                                    status: 404,
                                                    message:
                                                      "User is not found",
                                                  });
                                                }
                                              }
                                            }
                                          );
                                        } else {
                                          res.send({
                                            status: 400,
                                            message: "Something Went worng",
                                          });
                                        }
                                      }
                                    );
                                  }
                                }
                              );
                            } else {
                              res.send({
                                status: 504,
                                message: "something went wrong",
                              });
                            }
                          }
                        );
                      } else {
                        res.send({
                          status: 504,
                          message: "something went wrong",
                        });
                      }
                    }
                  );
                } else {
                  res.send({
                    status: 504,
                    message: "something went wrong",
                  });
                }
              }
            }
          );
        }
      } else {
        res.send({
          status: 404,
          message: "user is not found",
        });
      }
    }
  });
});

// Get User profile data
router.get("/getProfile", verifyToken, function (req, res) {
  let user_id = jwt.decode(req.headers["x-access-token"]).id;
  if (!user_id) {
    return res.send({
      status: 400,
      message: "User id is required.",
    });
  }
  userSerObject.getUserById(user_id, function (err, profileData) {
    if (err) {
      res.send({
        status: 400,
        message: "User is not found",
      });
    } else {
      if (profileData) {
        let profiles = {
          id: profileData.id,
          first_name: profileData.first_name,
          last_name: profileData.last_name,
          gender: profileData.gender,
          email: profileData.email,
          profile_image: profileData.profile_image
            ? `${config.site_url}profile_images/${profileData.profile_image}`
            : null,
          notification_mute_status: profileData.notification_mute_status,
          notification_mute_end: profileData.notification_mute_end,
          stage: profileData.stage,
          fcmid: profileData.fcmid,
          unique_code: profileData.unique_code,
        };
        res.send({
          status: 200,
          result: profiles,
        });
      } else {
        res.send({
          status: 504,
          message: "User is not found",
        });
      }
    }
  });
});

// Get Dashboard data
router.get("/dashboard", verifyToken, function (req, res) {
  let user_id = jwt.decode(req.headers["x-access-token"]).id;
  if (!user_id) {
    return res.send({
      status: 400,
      message: "User id is required.",
    });
  }
  goalObject.getPartnerById(user_id, function (err, GoalData) {
    if (err) {
      res.send({
        status: 400,
        message: "Goal is not found",
      });
    } else {
      if (GoalData) {
        goalObject.getGoalDetails(GoalData.partner_one_id, GoalData.partner_two_id, function (err, patnerGoalData) {
          if (err) {
            res.send({
              status: 404,
              message: "Something Went worng",
            });
          } else {
            if (patnerGoalData) {
              userSerObject.getUserById(user_id, function (err, userdata) {
                if (err) {
                  res.send({
                    status: 400,
                    message: "User is not found.",
                  });
                } else {
                  if (userdata) {
                    userSerObject.getPartnerById(user_id, function (err, patnerData) {
                      if (err) {
                        res.send({
                          status: 400,
                          messgae: "patner is not found",
                        });
                      } else {
                        let contribution1 = patnerGoalData.contribution1;
                        let contribution2 = patnerGoalData.contribution2;
                        let initiator_count1 = patnerGoalData.initiator_count;
                        let initiator_count2 = patnerGoalData.initiator_count1;
                        let connect_number = patnerGoalData.connect_number;
                        let totalcontribution1 = connect_number * initiator_count1 / 100
                        let totalcontribution2 = connect_number * initiator_count2 / 100
                        let ct1 = contribution1 * 100 / totalcontribution1
                        let ct2 = contribution2 * 100 / totalcontribution2
                        let CompletedCount1;
                        let CompletedCount2;


                        if (user_id != patnerGoalData.user_id) {
                          CompletedCount1 = ct2;
                          CompletedCount2 = ct1;
                        } else {
                          CompletedCount1 = ct1;
                          CompletedCount2 = ct2;
                        }

                        if (patnerData) {
                          notificationObject.getNotificationunseenData(user_id, function (err, Notificationdata) {
                            let dashboard = {
                              connect_number: patnerGoalData.connect_number,
                              initiator_count1:
                                patnerGoalData.user_id === user_id
                                  ? patnerGoalData.initiator_count
                                  : patnerGoalData.initiator_count1,
                              initiator_count2:
                                patnerGoalData.user_id === user_id
                                  ? patnerGoalData.initiator_count1
                                  : patnerGoalData.initiator_count,
                              complete_count: patnerGoalData.complete_count,
                              contribution1:
                                patnerGoalData.user_id === user_id
                                  ? patnerGoalData.contribution1
                                  : patnerGoalData.contribution2,
                              contribution2:
                                patnerGoalData.user_id === user_id
                                  ? patnerGoalData.contribution2
                                  : patnerGoalData.contribution1,
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
                              Notificationdata: Notificationdata.length,
                              // checkans: Check?
                              //(isNaN(CompletedCount1)) ? 0 :
                              userContribution: CompletedCount1,
                              patnerContribution: CompletedCount2,
                            };
                            res.send({
                              status: 200,
                              result: dashboard,
                            });
                          })
                        } else {
                          res.send({
                            status: 504,
                            message: "Partner is not found",
                          });
                        }
                      }
                    });
                  } else {
                    res.send({
                      status: 504,
                      message: "User is not found",
                    });
                  }
                }
              });
            } else {
              res.send({
                status: 504,
                message: "Goal is not found",
              });
            }
          }
        });
      } else {
        res.send({
          status: 504,
          message: "Goal is not found",
        });
      }
    }
  });
});

router.get("/check_seen_or_unseen_notification/:id", verifyToken, function (req, res) {
  //pass the notification id
  let id = req.params.id;
  notificationObject.getnotificationseenorunseen(id, function (err, notificationdata) {
    if (err) {
      res.send({
        status: 400,
        message: "something Went wrong!!",
      });
    } else {
      if (notificationdata) {
        res.send({
          status: 200,
          result: notificationdata,
        });
      } else {
        res.send({
          status: 404,
          message: "Notification data is not found!!",
        });
      }
    }
  });
});

module.exports = router;
