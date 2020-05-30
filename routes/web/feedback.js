/** 
  * @desc this file will define the routes for web messages
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file messages.js
*/

const express = require('express');
const FeedbackService = require('../../services/FeedbackService');
const custom_helper = require('../../helpers/custom_helper');

let router =  express.Router();
var FeedbackObject = new FeedbackService();

var sessionChecker = (req, res, next) => {
    if (!req.session.passport ) {
        res.redirect('/');
    } else {
        next();
    }
};

// Display new Feedback screen
router.get('/:page', sessionChecker, function(req, res){

	var perPage = 10;
	var page = req.params.page || 1;

	let paginationData = {
		'offset': (perPage * page) - perPage,
		'limit' : perPage,
	};

	FeedbackObject.getfeedbackWithUser(paginationData, function(err, pageData)
	{
		    if(pageData)
			{
				if (err) 
				{  
					req.flash('error_message','Error Occured: Unable to fetch page list');
				}else 
				{
					const itemCount = pageData.count;
					res.render('feedback/pages', {
						custom_helper: custom_helper,
						pageDataValue: pageData.rows,
						current: page,
						route_page: '/feedback',
						pages: Math.ceil(itemCount / perPage)
					});
				}
			}
		});
});
module.exports = router;