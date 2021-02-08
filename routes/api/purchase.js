/**
 * @desc this file will contains the routes for feedback api
 * @author Navneet Kumar navneet.kumar@subcodevs.com
 * @file feedback.js
 */

const express = require("express");
const subscripationService = require("../../services/SubscripationService");
const GoalService = require("../../services/GoalService");
const UserService = require("../../services/UserService");
const jwt = require("jsonwebtoken");
const current_datetime = require("date-and-time");
var iap = require("in-app-purchase");

// verifytoken middleware
const verifyToken = require("./verifytoken");
const helmet = require("helmet");
const User = require("../../models/user");

// Create route object
let router = express.Router();

// Create user model object
var SubscripationObject = new subscripationService();

// Create Goal model object
var goalObject = new GoalService();

// Create USer model object
var userSerObject = new UserService();

// Save Plan   data
router.post("/", verifyToken, function (req, res) {
  let purchase_plan_id = req.body.purchase_plan_id;
  let receipt = req.body.receipt;
  let amount = req.body.amount;
  let device_name = req.body.device_name;
  let subscripation_plan = req.body.subscripation_plan;
  let user_id = jwt.decode(req.headers["x-access-token"]).id;

  goalObject.getPartnerData(user_id, function (err, partnerMappingData) {
    if (err) {
      res.send({
        status: 404,
        message: "something went wrong!",
      });
    } else {
      if (partnerMappingData) {
        let data = {
          user_id: user_id,
          purchase_plan_id: purchase_plan_id,
          receipt: receipt,
          partner_mapping_id: partnerMappingData.id,
          amount: amount,
          device_name: device_name,
          subscripation_plan: subscripation_plan,
        };
        SubscripationObject.saveSubscripation(
          data,
          function (err, responseData) {
            if (err) {
              res.send({
                status: 400,
                message: "something went wrong",
              });
            } else {
              if (responseData) {
                userSerObject.UpdateSubscripation(
                  data,
                  function (err, UpdateData) {
                    if (err) {
                      res.send({
                        status: 404,
                        message: "Something went worng",
                      });
                    } else {
                      if (UpdateData) {
                        userSerObject.getUserById(
                          user_id,
                          function (err, UserData) {
                            if (err) {
                              res.send({
                                status: 400,
                                message: "Something went wrong!",
                              });
                            } else {
                              if (UserData) {
                                console.log("user data", UserData);
                                if (UserData.paymentStage == 2) {
                                  userSerObject.updatePaymentStage(
                                    1,
                                    partnerMappingData.partner_one_id,
                                    function (err, updateStage) {
                                      if (err) {
                                        res.send({
                                          status: 400,
                                          message: "Something went wrong",
                                        });
                                      } else {
                                        if (updateStage) {
                                          userSerObject.getPartnerById(
                                            user_id,
                                            (err, PartnersData) => {
                                              if (err) {
                                                res.send({
                                                  status: 404,
                                                  message:
                                                    "Something went wrong!",
                                                });
                                              } else {
                                                if (PartnersData) {
                                                  res.send({
                                                    status: 200,
                                                    message:
                                                      "Plan save successfully",
                                                    result: responseData,
                                                    partnerFCMToken:
                                                      PartnersData.fcmid,
                                                    userFCMToken:
                                                      UserData.fcmid,
                                                    userStage: UserData.stage,
                                                    partnerStage:
                                                      PartnersData.stage,
                                                  });
                                                } else {
                                                  res.send({
                                                    status: 400,
                                                    message:
                                                      "Partner is not found!",
                                                  });
                                                }
                                              }
                                            }
                                          );
                                        }
                                      }
                                    }
                                  );
                                } else {
                                  const bothPartnerId = {
                                    stage: 6,
                                    user_id: partnerMappingData.partner_one_id,
                                    partner_id:
                                      partnerMappingData.partner_two_id,
                                  };
                                  userSerObject.updateBothPartnerStage(
                                    bothPartnerId,
                                    function (err, updatedData) {
                                      if (err) {
                                        res.send({
                                          status: 400,
                                          message: "Something went wrong",
                                        });
                                      } else {
                                        if (updatedData) {
                                          userSerObject.getPartnerById(
                                            user_id,
                                            (err, PartnersData) => {
                                              if (err) {
                                                res.send({
                                                  status: 404,
                                                  message:
                                                    "Something went wrong!",
                                                });
                                              } else {
                                                if (PartnersData) {
                                                  res.send({
                                                    status: 200,
                                                    message:
                                                      "Plan save successfully",
                                                    result: responseData,
                                                    partnerFCMToken:
                                                      PartnersData.fcmid,
                                                    userFCMToken:
                                                      UserData.fcmid,
                                                    userStage: UserData.stage,
                                                    partnerStage:
                                                      PartnersData.stage,
                                                  });
                                                } else {
                                                  res.send({
                                                    status: 400,
                                                    message:
                                                      "Partner is not found!",
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
                              } else {
                                res.send({
                                  status: 400,
                                  message: "User is not found",
                                });
                              }
                            }
                          }
                        );
                      } else {
                        res.send({
                          status: 504,
                          message: "Something went worng",
                        });
                      }
                    }
                  }
                );
              } else {
                res.send({
                  status: 504,
                  message: "Something went worng",
                });
              }
            }
          }
        );
      } else {
        res.send({
          status: 504,
          message: "partner is not found",
        });
      }
    }
  });
});

router.get("/verify", verifyToken, function (req, res) {
  let user_id = jwt.decode(req.headers["x-access-token"]).id;
  VerifyData: null;

  userSerObject.getUserById(user_id, function (err, UserData) {
    if (err) {
      res.send({
        status: 404,
        message: "something went wrong",
      });
    } else {
      if (UserData) {
        if (UserData.stage >= 4) {
          if (UserData.receipt) {
            SubscripationObject.VerifyReceipt(
              UserData,
              function (err, VerifyData) {
                if (err) {
                  res.send({
                    status: 404,
                    message: "something went wrong",
                  });
                } else {
                  if (VerifyData) {
                    if (VerifyData.data.expire_at) {
                      let expiryDate;
                      if (UserData.device_name === "ios") {
                        let exDate = VerifyData.data.expire_at.replace(
                          " Etc/GMT",
                          ""
                        );
                        expiryDate = new Date(exDate).toISOString();
                      } else if (UserData.device_name === "android") {
                        expiryDate = new Date(VerifyData.data.expire_at * 1000);
                      }
                      let currentDate = current_datetime.format(
                        new Date(),
                        "YYYY-MM-DD HH:mm:ss",
                        true
                      );
                      currentDate = new Date(currentDate);
                      expiryDate = new Date(expiryDate);
                      if (currentDate.getTime() < expiryDate.getTime()) {
                        res.send({
                          status: 200,
                          message: "Your Plan is Active!",
                          result: VerifyData,
                          payment: 1,
                        });
                      } else {
                        userSerObject.getPartnerById(
                          user_id,
                          function (err, PatnerData) {
                            if (err) {
                              res.send({
                                status: 404,
                                message: "something went wrong",
                              });
                            } else {
                              if (PatnerData) {
                                if (PatnerData.receipt) {
                                  SubscripationObject.VerifyReceipt(
                                    PatnerData,
                                    function (err, VerifiesData) {
                                      if (err) {
                                        res.send({
                                          status: 404,
                                          message: "something went wrong",
                                        });
                                      } else {
                                        if (VerifiesData) {
                                          if (VerifiesData.data.expire_at) {
                                            let expiryDate;
                                            if (
                                              PatnerData.device_name === "ios"
                                            ) {
                                              let partnerExDate = VerifiesData.data.expire_at.replace(
                                                " Etc/GMT",
                                                ""
                                              );
                                              expiryDate = new Date(
                                                partnerExDate
                                              ).toISOString();
                                            } else if (
                                              PatnerData.device_name ===
                                              "android"
                                            ) {
                                              expiryDate = new Date(
                                                VerifiesData.data.expire_at *
                                                  1000
                                              );
                                            }

                                            let currentDate = current_datetime.format(
                                              new Date(),
                                              "YYYY-MM-DD HH:mm:ss",
                                              true
                                            );
                                            currentDate = new Date(currentDate);
                                            expiryDate = new Date(expiryDate);
                                            if (
                                              currentDate.getTime() <
                                              expiryDate.getTime()
                                            ) {
                                              res.send({
                                                status: 200,
                                                message:
                                                  "You and Your Patner's plan are Active!",
                                                payment: 1,
                                              });
                                            } else {
                                              res.send({
                                                status: 200,
                                                message:
                                                  "You and Your Patner's plan are expired!",
                                                payment: 0,
                                              });
                                            }
                                          } else {
                                            res.send({
                                              status: 200,
                                              message:
                                                "Pleases Buy subscripation",
                                              payment: 0,
                                            });
                                          }
                                        } else {
                                          res.send({
                                            status: 404,
                                            message:
                                              "Your Plan is expired, Please Buy subscripation!",
                                            payment: 0,
                                          });
                                        }
                                      }
                                    }
                                  );
                                } else {
                                  res.send({
                                    status: 200,
                                    message:
                                      "You and Your Patner's plan are expired!",
                                    payment: 0,
                                  });
                                }
                              } else {
                                res.send({
                                  status: 504,
                                  message: "Patner is not found",
                                  payment: 2,
                                });
                              }
                            }
                          }
                        );
                      }
                    } else {
                      res.send({
                        status: 200,
                        message: "Please Buy subscripation",
                        payment: 0,
                      });
                    }
                  } else {
                    res.send({
                      status: 400,
                      message: "Plan is not active!",
                      payment: 0,
                    });
                  }
                }
              }
            );
          } else {
            userSerObject.getPartnerById(user_id, function (err, PatnerData) {
              if (err) {
                res.send({
                  status: 404,
                  message: "something went wrong",
                });
              } else {
                if (PatnerData) {
                  if (PatnerData.receipt) {
                    SubscripationObject.VerifyReceipt(
                      PatnerData,
                      function (err, VerifyData) {
                        console.log("VerifyData : ", VerifyData);

                        if (err) {
                          console.log("err : ", err);
                          res.send({
                            status: 404,
                            message: "something went wrong",
                            err: err,
                          });
                        } else {
                          if (VerifyData) {
                            if (VerifyData.data.expire_at) {
                              let expiryDate;
                              if (PatnerData.device_name === "ios") {
                                let partnerExDate = VerifyData.data.expire_at.replace(
                                  " Etc/GMT",
                                  ""
                                );
                                expiryDate = new Date(
                                  partnerExDate
                                ).toISOString();
                              } else if (PatnerData.device_name === "android") {
                                expiryDate = new Date(
                                  VerifyData.data.expire_at * 1000
                                );
                              }

                              let currentDate = current_datetime.format(
                                new Date(),
                                "YYYY-MM-DD HH:mm:ss",
                                true
                              );
                              currentDate = new Date(currentDate);
                              expiryDate = new Date(expiryDate);

                              if (
                                currentDate.getTime() < expiryDate.getTime()
                              ) {
                                res.send({
                                  status: 200,
                                  message: "Your partner Plan is Active!",
                                  payment: 1,
                                });
                              } else {
                                res.send({
                                  status: 200,
                                  message: "Your patner Plan is expired!",
                                  payment: 0,
                                });
                              }
                            } else {
                              res.send({
                                status: 400,
                                message: "Please Buy subscripation",
                                payment: 0,
                              });
                            }
                          } else {
                            res.send({
                              status: 400,
                              message: "Please Buy subscripation",
                              payment: 0,
                            });
                          }
                        }
                      }
                    );
                  } else {
                    res.send({
                      status: 200,
                      message: "Please Buy subscripation",
                      payment: 0,
                    });
                  }
                } else {
                  res.send({
                    status: 504,
                    message: "Patner is not found",
                    payment: 2,
                  });
                }
              }
            });
          }
        } else {
          res.send({
            status: 404,
            message: "Paring is not avaliable",
            payment: 2,
          });
        }
      } else {
        res.send({
          status: 504,
          message: "User is not found",
        });
      }
    }
  });
});

router.get("/subscripation", verifyToken, function (req, res) {
  let user_id = jwt.decode(req.headers["x-access-token"]).id;
  SubscripationObject.getSubscripation(
    user_id,
    function (err, SubscripationData) {
      if (err) {
        res.send({
          status: 400,
          message: "something Went Wrong",
        });
      } else {
        if (SubscripationData) {
          if (
            SubscripationData.expiry_date &&
            SubscripationData.expiry_date.getTime() > new Date().getTime()
          ) {
            res.send({
              status: 200,
              message: "Your current Plan",
              result: SubscripationData,
            });
          } else {
            res.send({
              status: 200,
              message: "Your Plan is expired",
            });
          }
        } else {
          res.send({
            status: 504,
            message: "Your Plan is not Avaliable",
          });
        }
      }
    }
  );
});

router.get("/faild", verifyToken, function (req, res) {
  let user_id = jwt.decode(req.headers["x-access-token"]).id;
  userSerObject.getPartnerById(user_id, function (err, partnerData) {
    if (err) {
      res.send({
        status: 400,
        message: "Something Went wrong!",
      });
    } else {
      if (partnerData) {
        let updateStage = {
          user_id: user_id,
          partner_id: partnerData.id,
          stage: 4,
          removeStage: 5,
        };
        userSerObject.updateBothPartnerStageByFaild(
          updateStage,
          function (err, updatedData) {
            if (err) {
              res.send({
                status: 400,
                message: "Something Went wrong!",
              });
            } else {
              if (updatedData) {
                res.send({
                  status: 200,
                  message: "stage changed",
                });
              }
            }
          }
        );
      } else {
        res.send({
          status: 500,
          message: "Partner is not found",
        });
      }
    }
  });
});

router.post("/verifyreceipt", verifyToken, function (req, res) {
  let user_id = jwt.decode(req.headers["x-access-token"]).id;
  let receipt = req.body.receipt;

  goalObject.CheckRecipt(receipt, user_id, (err, checked) => {
    if (err) {
      res.send({
        status: 500,
        message: "invalid user",
      });
    } else {
      if (checked) {
        res.send({
          status: 200,
          message: "Valid user",
        });
      }
    }
  });
});

module.exports = router;
