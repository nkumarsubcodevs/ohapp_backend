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
                    res.send({
                      status: 200,
                      message: "Plan save successfully",
                      result: responseData
                    })
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
          console.log(UserData.receipt)
          SubscripationObject.VerifyReceipt(UserData, function(err, VerifyData) {
            if(err) {
              res.send({
                status: 404,
                message: "something went wrong"
              })
            } else {
              if(VerifyData) {

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

module.exports = router;