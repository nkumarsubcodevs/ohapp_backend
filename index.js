/** 
  * @desc this file will define the function to check the user authentication and used as middlewear
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file index.js
*/

const express = require('express');
const UserService = require('./services/UserService');
const GoalService = require('./services/GoalService');
const FeedbackService = require('./services/FeedbackService');
const custom_helper = require('./helpers/custom_helper');

let router =  express.Router();
var userObject = new UserService();
var goalObject = new GoalService();
var FeedbackObject = new FeedbackService();

router.get('/', isLoggedIn, function(req, res){
        userObject.getuserCount(function(err, response) {
                goalObject.getQuestionCount(function(err, quistionCount){
                        FeedbackObject.getAllFeedbackCount(function(err,Feedbackcount){
                                FeedbackObject.getNewfeedbackWithUser(function(err, newUserConcerns) {
                                        // const itemCount = pageData.count;
					res.render('pages/index', {
						custom_helper: custom_helper,
                                                pageDataValue: newUserConcerns.rows,
                                                TotalFeedback: Feedbackcount.count,
                                                TotalUser: response.count,
                                                TotalNewFeedBack: newUserConcerns.count,
                                                TotalQuestion: quistionCount.count,
						// current: page,
						route_page: '/',
						// pages: Math.ceil(itemCount / perPage)
					});
                                })
                        })
                })
        })
});

function isLoggedIn(req, res, next){
	if(req.isAuthenticated()){
        next();
	}
	else{
        res.redirect("/users/login");
    }
}

module.exports = router;