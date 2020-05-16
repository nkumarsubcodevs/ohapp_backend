/** 
  * @desc this file will contains the routes for feedback api
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file feedback.js
*/

const express = require('express');
const QuickyService = require('../../services/quickyService');
const GoalService = require('../../services/GoalService');
const userService = require('../../services/UserService');
const NotificationService = require('../../services/notification');
const formValidator = require('validator');
const jwt = require('jsonwebtoken')
// verifytoken middleware
const verifyToken = require('./verifytoken');

// Create route object
let router =  express.Router();

// Create user model object
var quickyObject = new QuickyService();

// Create Goal model object
var goalObject = new GoalService();

// Create USer model object
var userSerObject = new userService();

// Create notification model object
var notificationObject = new NotificationService();

// Save quicky data
router.post('/SaveQuicky', verifyToken, function(req, res) {
	let when = req.body.when;
	let where = req.body.where;
	let user_id = jwt.decode(req.headers['x-access-token']).id;

	goalObject.getPartnerData(user_id, function(err, partnerData){
	  if(err) {
		res.send({
		  status: 404,
		  message: "something went wrong!"
		})
	  }
	  if(partnerData) {
		  userSerObject.getUserById(partnerData.partner_two_id, function(err, partnerResponse) {
			  if(err) {
				  res.send({
					  status: 400,
					  message: "something went wrong"
				  })
			  } else {
				  if(partnerResponse) {
					  let data = {
						  user_id: user_id,
						  when: when,
						  where: where,
						  partner_mapping_id: partnerData.id
					  }
					quickyObject.saveQuicky(data, function(err, responseQuicky) {
						if(err) {
							res.send({
								status: 400,
								message: "something went wrong"
							})
						}
						if(responseQuicky) {
							res.send({
								status: 200,
                message: "quicky save successfully",
                quickyData: responseQuicky,
                partner_fcmid: partnerResponse.fcmid
							})
						}
					})
				  } else {
					  res.send({
						  status: 504,
						  message: "partner not found"
					  })
				  }
			  }
		  })
	  } else {
		res.send({
		  status: 504,
		  message: "Partner not found"
		})
	  }
	})
})

// Update quicky data
router.put('/updateQuicky/:id', verifyToken, function(req, res) {
	let when = req.body.when;
  let where = req.body.where;
  let partner_response = req.body.partner_response;
  let user_id = jwt.decode(req.headers['x-access-token']).id;
  let quicky_id = req.params.id

  quickyObject.getSingleQuickyRecord(quicky_id, function(err, QuickyData) {
    if(err) {
      res.send({
        status: 400,
        message: "something Went wrong!"
      })
    } else {
        if(QuickyData) {
          goalObject.getPartnerData(user_id, function(err, partnerData){
            if(err) {
            res.send({
              status: 404,
              message: "something went wrong!"
            })
            }
            if(partnerData) {
              userSerObject.getUserById(partnerData.partner_two_id, function(err, partnerResponse) {
                if(err) {
                  res.send({
                    status: 400,
                    message: "something went wrong"
                  })
                } else {
                  if(partnerResponse) {
                    let data = {
                      user_id: user_id,
                      when: when,
                      where: where,
                      partner_mapping_id: partnerData.id,
                      quicky_id: quicky_id,
                      partner_response: partner_response
                    }
                  quickyObject.updateQuicky(data, function(err, responseQuicky) {
                    if(err) {
                      res.send({
                        status: 400,
                        message: "something went wrong"
                      })
                    }
                    if(responseQuicky) {
                       if(responseQuicky.partner_response === true) {
                         userSerObject.getUserById(user_id, function(err, userData) {
                           if(err) {
                             res.send({
                               status: 404,
                               message: "something went wrong"
                             })
                           } else {
                             if(userData) {
                               goalObject.getGoalDetails(user_id, partnerResponse.id, function(err, Goaldata) {
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
                                     var night = new Date(
                                         now.getFullYear(),
                                         now.getMonth(),
                                         now.getDate() + 1,
                                         hours, minutes, 0
                                     );
                                     var diff =(night.getTime() - now.getTime()) / 1000 * 24 * 60;
                                     diff /= 60;
                                     let timeout =  Math.abs(Math.round(diff))
                                     setTimeout(() => {
                                       notificationObject.SendFeedbacknotification(partnerResponse.fcmid, function(err, response) {})
                                       notificationObject.SendFeedbacknotification(userData.fcmid, function(err, response) {})
                                     }, timeout)
                                   } else {
                                     res.send({
                                       status: 400,
                                       message: "Goal is not found"
                                     })
                                   }
                                 }
                               })

                             } else {
                               res.send({
                                 status: 504,
                                 message: "user not found"
                               })
                             }
                           }
                         })
                       }
                      res.send({
                        status: 200,
                        message: "quicky update successfully",
                        QuickyData: responseQuicky,
                        partner_fcmid: partnerResponse.fcmid
                      })
                    }
                  })
                  } else {
                    res.send({
                      status: 504,
                      message: "partner not found"
                    })
                  }
                }
              })
            } else {
            res.send({
              status: 504,
              message: "Partner not found"
            })
            }
          })
        } else {
          res.send({
            status: 504,
            message: "Quicky is not found"
          })
        }
    }
  })
})

// Get singal quicky data
router.get('/getQuicky/:id', verifyToken, function(req, res) {
  let quicky_id = req.params.id;
  quickyObject.getSingleQuickyRecord(quicky_id, function(err, QuickyData) {
    if(err) {
      res.send({
        status: 400,
        message: "something Went wrong!"
      })
    } else {
        if(QuickyData) {
          res.send({
            status: 200,
            result: QuickyData
          })
        } else {
          res.send({
            status: 404,
            message: "Quicky is not found"
          })
        }
      }
  })
})

module.exports = router;