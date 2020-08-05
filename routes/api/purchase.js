/** 
  * @desc this file will contains the routes for feedback api
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file feedback.js
*/

const express = require('express');
const subscripationService = require('../../services/SubscripationService');
const GoalService = require('../../services/GoalService');
const UserService = require('../../services/UserService');
const jwt = require('jsonwebtoken')
const current_datetime = require('date-and-time');
var iap = require('in-app-purchase');

// verifytoken middleware
const verifyToken = require('./verifytoken');
const helmet = require('helmet');

// Create route object
let router =  express.Router();

// Create user model object
var SubscripationObject = new subscripationService();

// Create Goal model object
var goalObject = new GoalService();

// Create USer model object
var userSerObject = new UserService();

// Save quicky data
router.post('/', verifyToken, function(req, res) {
  let purchase_plan_id = req.body.purchase_plan_id;
  let receipt = req.body.receipt;
  let amount = req.body.amount;
  let device_name = req.body.device_name;
  let subscripation_plan = req.body.subscripation_plan;
	let user_id = jwt.decode(req.headers['x-access-token']).id;

	goalObject.getPartnerData(user_id, function(err, partnerMappingData){
	  if(err) {
      res.send({
        status: 404,
        message: "something went wrong!"
      })
	  } else {
      if(partnerMappingData) {
        let data = {
          user_id: user_id,
          purchase_plan_id: purchase_plan_id,
          receipt: receipt,
          partner_mapping_id: partnerMappingData.id,
          amount: amount,
          device_name: device_name,
          subscripation_plan: subscripation_plan,
        }
        SubscripationObject.saveSubscripation(data, function(err, responseData) {
          if(err) {
            res.send({
              status: 400,
              message: "something went wrong"
            })
          } else {
            if(responseData) {
              userSerObject.UpdateSubscripation(data, function(err, UpdateData) {
                if(err) {
                  res.send({
                    status: 404,
                    message: "Something went worng"
                  })
                } else {
                  if(UpdateData) {
                    const bothPartnerId = {
                      stage: 5,
                      user_id: partnerMappingData. partner_one_id,
                      partner_id: partnerMappingData. partner_two_id,
                    }
                    userSerObject.updateBothPartnerStage(bothPartnerId, function(err, updatedData){
                      if(err){
                        res.send({
                          status: 400,
                          message: "Something went wrong"
                        });
                      }else{
                        if(updatedData){
                          res.send({
                            status: 200,
                            message: "Plan save successfully",
                            result: responseData
                          })
                        }
                      }
                    });
                  } else {
                    res.send({
                      status: 504,
                      message: "Something went worng"
                    })
                  }
                }
              })
            } else {
              res.send({
                status: 504,
                message: "Something went worng"
              })
            }
          }
        })
      }
        else {
        res.send({
          status: 504,
          message: "partner is not found"
        })
      }
    }
	})
})

router.get('/verify', verifyToken, function(req, res) {
  let user_id = jwt.decode(req.headers['x-access-token']).id;

  userSerObject.getUserById(user_id, function(err, UserData) {
    if(err) {
      res.send({
        status: 404,
        message: "something went wrong"
      })
    } else {
      if(UserData) {
        if(UserData.receipt) {
          SubscripationObject.VerifyReceipt(UserData, function(err, VerifyData) {
            if(err) {
              console.log(err)
              res.send({
                status: 404,
                message: "something went wrong"
              })
            } else {
              if(VerifyData) {
                    let date2 = current_datetime.format(new Date, 'YYYY-MM-DD HH:mm:ss', true);
                    let date1 = new Date(UserData.expiry_time);
                    date2 = new Date(date2);
                    if(date2.getTime() < date1.getTime()) {
                      res.send({
                        status: 200,
                        message: "Your Plan is Active!",
                        result: VerifyData
                      })
                    } else {
                      userSerObject.getPartnerById(user_id, function(err, PatnerData) {
                        if(err) {
                          res.send({
                            status: 404,
                            message: "something went wrong"
                          })
                        } else {
                          if(PatnerData) {
                            if(PatnerData.receipt) {
                              SubscripationObject.VerifyReceipt(PatnerData, function(err, VerifyData) {
                                if(err) {
                                  res.send({
                                    status: 404,
                                    message: "something went wrong"
                                  })
                                } else {
                                  if(VerifyData) {
                                        if(VerifyData.data.expire_at) {
                                          let currentDate = current_datetime.format(new Date, 'YYYY-MM-DD HH:mm:ss', true);
                                          let expiryDate = new Date(VerifyData.expiryTimeMillis);
                                          currentDate = new Date(currentDate);
                                          if(currentDate.getTime() < expiryDate.getTime()) {
                                            res.send({
                                              status: 200,
                                              message: "You and Your Patner's plan are Active!"
                                            })
                                          } else {
                                            res.send({
                                              status: 200,
                                              message: "You and Your Patner's plan are expired!"
                                            })
                                          }
                                        } else {
                                          res.send({
                                            status: 200,
                                            message: "Please Buy subscripation"
                                          })
                                        }
                                  } else {
                                  }
                                }
                              })
                            } else {
                              res.send({
                                status: 200,
                                message: "Please Buy subscripation"
                              })
                            }
                          } else {
                            res.send({
                              status: 504,
                              message: "Patner is not found"
                            })
                          }
                        }
                      })
                    }
              } else {

              }
            }
          })
        } else {
          userSerObject.getPartnerById(user_id, function(err, PatnerData) {
            if(err) {
              res.send({
                status: 404,
                message: "something went wrong"
              })
            } else {
              if(PatnerData) {
                if(PatnerData.receipt) {
                  SubscripationObject.VerifyReceipt(PatnerData, function(err, VerifyData) {
                    if(err) {
                      res.send({
                        status: 404,
                        message: "something went wrong"
                      })
                    } else {
                      if(VerifyData) {
                            if(PatnerData.expiry_time) {
                              let date2 = current_datetime.format(new Date, 'YYYY-MM-DD HH:mm:ss', true);
                              let date1 = new Date(PatnerData.expiry_time);
                              date2 = new Date(date2);
                              if(date2.getTime() < date1.getTime()) {
                                res.send({
                                  status: 200,
                                  message: "Your partner Plan is Active!"
                                })
                              } else {
                                res.send({
                                  status: 200,
                                  message: "Your patner Plan is expired!"
                                })
                              }
                            } else {
                              res.send({
                                status: 400,
                                message: "Please Buy subscripation"
                              })
                            }
                      } else {

                      }
                    }
                  })
                } else {
                  res.send({
                    status: 200,
                    message: "Please Buy subscripation"
                  })
                }
              } else {
                res.send({
                  status: 504,
                  message: "Patner is not found"
                })
              }
            }
          })
        }
      } else {
        res.send({
          status:504,
          message: "User is not found"
        })
      }
    }
  })
})

router.get('/subscripation', verifyToken, function(req, res) {
  let user_id = jwt.decode(req.headers['x-access-token']).id;
  SubscripationObject.getSubscripation(user_id, function(err, SubscripationData) {
    if(err) {
      res.send({
        status: 400,
        message:"something Went Wrong"
      })
    } else {
      if(SubscripationData) {
        if(SubscripationData.expiry_date && SubscripationData.expiry_date.getTime() > new Date().getTime()) {
          res.send({
            status: 200,
            message: "Your current Paln",
            result: SubscripationData
          })
        } else {
          res.send({
            status: 200,
            message: "Your Plan is expired"
          })
        }
      } else {
        res.send({
          status: 504,
          message:"Your Plan is not Avaliable"
        })
      }
    }
  })
})

router.get('/faild', verifyToken, function(req, res) {
  let user_id = jwt.decode(req.headers['x-access-token']).id;
  userSerObject.getPartnerById(user_id, function(err, partnerData) {
    if(err) {
      res.send({
        status: 400,
        message: "Something Went wrong!"
      })
    } else {
      if(partnerData) {
        let updateStage = {
          user_id: user_id,
          partner_id: partnerData.id,
          stage: 7,
          removeStage: 8
        }
        userSerObject.updateBothPartnerStageByFaild(updateStage, function(err, updatedData) {
          if(err) {
            res.send({
              status: 400,
              message: "Something Went wrong!"
            })
          } else {
            if(updatedData) {
              res.send({
                status: 200,
                message: "stage changed"
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
module.exports = router;