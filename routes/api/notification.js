/** 
  * @desc this file will contains the routes for pages api
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file pages.js
*/

const express = require('express');
const NotificationService = require('../../services/NotificationService');
const goalService = require('../../services/GoalService');
const userService = require('../../services/UserService');
const jwt = require('jsonwebtoken');
const formValidator = require('validator');

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

module.exports = router;