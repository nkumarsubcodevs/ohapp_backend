/** 
  * @desc this file will contains the routes for feedback api
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file feedback.js
*/

const express = require('express');
const FeedbackService = require('../../services/FeedbackService');
const formValidator = require('validator');
const jwt = require('jsonwebtoken')
// verifytoken middleware
const verifyToken = require('./verifytoken');

// Create route object
let router =  express.Router();

// Create user model object
var feedbackObject = new FeedbackService();

// Get single page content
router.post('/savefeedback', verifyToken, function(req, res) {

  var user_id = jwt.decode(req.headers['x-access-token']).id;
  var feedback_details =  req.body.feedback;
  if(!user_id) 
  {
      return res.send({
        status: 400,
        message: 'user id is required',
      });
  }

  if(!formValidator.isInt(user_id))   
	{
		return res.send({
			status: 400,
			message: 'Please enter a valid user id.',
		});
	}
  feedbackObject.getfeedback(user_id, function(err, getFeedback) {
    if(err) {
      res.send({
        status: 400,
        message: "something went wrong"
      })
    }
    if(getFeedback) {
      feedbackObject.updatefeedback(user_id, feedback_details, function(err, updatedFeedback)
      {
          if(err)
          {
              res.send({
                status: 500,
                message: 'There was a problem in fetching the feedback.',
              });
          }
          else
          {
              if(updatedFeedback)
              {
                  res.send({
                    status: 200,
                    messge: "Updated successfully",
                    result: updatedFeedback,
                  });
              } 
          }
      });
    } else {
      feedbackObject.saveFeedback(user_id, feedback_details, function(err, savefeedback)
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
              if(savefeedback)
              {
                  res.send({
                    status: 200,
                    messge: "saved successfully",
                    result: savefeedback,
                  });
              } 
          }
      });
    }
  })
});



module.exports = router;