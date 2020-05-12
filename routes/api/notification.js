/** 
  * @desc this file will contains the routes for pages api
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file pages.js
*/

const express = require('express');
const notificationService = require('../../services/notification');
const goalService = require('../../services/GoalService');
const userService = require('../../services/UserService');
const jwt = require('jsonwebtoken');
const formValidator = require('validator');

// verifytoken middleware
const verifyToken = require('./verifytoken');

// Create route object
let router =  express.Router();

// Create notification model object
var notificationObject = new notificationService();

// Create goal model object
var goalServiceObject = new goalService();

// Create user model object
var userServiceObject = new userService();

// Get single page content
router.put('/saveAnswer', verifyToken, function(req, res, next) {

  var notification_id = req.body.notification_id;
  var Answer = req.body.Answer;
  var user_id = jwt.decode(req.headers['x-access-token']).id;

  // if(!page_id) 
  // {
  //     return res.send({
  //       status: 400,
  //       message: 'Page id is required',
  //     });
  // }

  // if(!formValidator.isInt(page_id))   
	// {
	// 	return res.send({
	// 		status: 400,
	// 		message: 'Please enter a valid page id.',
	// 	});
	// }
  
  // let pageData = {
  //     'page_id': page_id,
  // };

  notificationObject.updateNotification(notification_id,  Answer, function(err, pageData)
  {
      if(err)
      {
          res.send({
            status: 500,
            message: 'There was a problem in fetching the page.',
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
              }
              if(patnerData) {
                notificationObject.getNotification(patnerData.partner_two_id, function(err, patner) {
                  if(err) {
                    res.send({
                      status: 400,
                      message: "something went wrong"
                    })
                  }
                  if(patner === null) {
                    res.send({
                      status: 504,
                      message: "patner is not found",
                    })
                  } else {
                    res.send({
                      status:200,
                      result: patner
                    })
                  }
                })
              }
            })
          }
          else
          {
              res.send({
                status: 404,
                message: 'No page found.',
              });
          }	
      }
  });
});



module.exports = router;