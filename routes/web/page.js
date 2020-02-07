/** 
  * @desc this file will define the routes for web pages
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file page.js
*/

const express = require('express');
const PageService = require('../../services/PageService');
const passport = require('passport');
const LocalStrategy = require('passport-local').Strategy;
let router =  express.Router();

var pageSerObject = new PageService();

// page listing
router.get('/', function(req, res){
	pageSerObject.getPageList(function(err, pageData)
	{
		if(pageData)
			{
				if (err) 
				{  
					req.flash('error_message','Error Occured: Unable to fetch patterns list');
					res.redirect('/pages/page');
				}
				else 
				{
					res.render('pages/page', {pageDataValue : pageData});
				}
			}
		});
});

	router.get('/edit/:id',function(req,res)
	{
		var mypage_id = req.params.id;
		if(mypage_id!=''){
			pageSerObject.getSinglePageRecord(mypage_id,function(err,pageData)
			{
			if(pageData){
				res.render('pages/updatelistPages',{pageValue : pageData});
			}
			else{
				console.log("error");
			}
			});
		}
	});

	router.post('/update',function (req,res){

		var page_id = req.body.page_id;
		var title = req.body.title;
		var status = req.body.status;
		var update_time = req.body.update_time;

		let pageData = {
			'id': page_id,
			'title': title,
			'status': status,
			'update_time': update_time
		};
	
	
		pageSerObject.updatepageDetails(pageData , function(err, response){
			if(err)
			{
				console.log('Something went wrong');
				
			}else{
				console.log("Successfully Updated");
			}
		});
	});

		
	
module.exports = router;