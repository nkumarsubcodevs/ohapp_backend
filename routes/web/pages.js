/** 
  * @desc this file will define the routes for web pages
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file page.js
*/

const express = require('express');
const PageService = require('../../services/PageService');
const custom_helper = require('../../helpers/custom_helper');
const formValidator = require('validator');

let router =  express.Router();
var pageSerObject = new PageService();

// page listing
router.get('/:page?', function(req, res){

	var perPage = 2;
	var page = req.params.page || 1;
	
	let paginationData = {
		'offset': (perPage * page) - perPage,
		'limit' : perPage,
	};

	pageSerObject.getPageList(paginationData, function(err, pageData)
	{
		    if(pageData)
			{
				if (err) 
				{  
					req.flash('error_message','Error Occured: Unable to fetch page list');
					
				}else 
				{
					const itemCount = pageData.count;
					res.render('pages/pages', {
						custom_helper: custom_helper,
						pageDataValue: pageData.rows,
						current: page,
						route_page: '/pages',
						pages: Math.ceil(itemCount / perPage)
					});
				}
			}
		});
	});

	router.get('/edit/:id',function(req,res)
	{
		var page_id = req.params.id;
		
		pageSerObject.getSinglePageRecord(page_id,function(err,pageData)
			{
				if (!err) 
				{  
					req.flash('error_message', 'Unable to fetch page detail');
					
				}else 
				{
					res.render('pages/updatelistPages',{
						pageValue : pageData,
						custom_helper: custom_helper
					});
				}
			});
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
				req.flash('error_message','Something went wrong');
				
			}else{
				req.flash('success_message','Updated Successfully');
				res.redirect('/pages');
			}
		});
	});

		
	
module.exports = router;