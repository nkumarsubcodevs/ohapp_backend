/** 
  * @desc this file will define the routes for web pages
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file page.js
*/

const express = require('express');
const PageService = require('../../services/PageService');
const GoalService = require('../../services/GoalService');
const custom_helper = require('../../helpers/custom_helper');
const formValidator = require('validator');

let router =  express.Router();
var pageSerObject = new PageService();
var GoalObject = new GoalService();

// page listing
router.get('/:page', function(req, res){

	var perPage = 10;
	var page = req.params.page || 1;

	let paginationData = {
		'offset': (perPage * page) - perPage,
		'limit' : perPage,
	};

	GoalObject.getQuestion(paginationData, function(err, pageData)
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
		GoalObject.getSingleQuestionRecord(page_id,function(err,pageData)
			{
				if (err)
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
		var option = req.body.Option
		let pageData = {
			'id': page_id,
			'title': title,
			'status': status,
			'update_time': update_time
		};
		GoalObject.removeOption(page_id, function(err, RemoveOption) {
			if(err) {
				res.send({
					status: 404,
					message: "Something Went worn"
				})
			} else {
				if(RemoveOption) {
					GoalObject.setQuestionOptions(option , page_id, function(err, response){
						if(err)
						{
							req.flash('error_message','Something went wrong');
						}else{
							req.flash('success_message','Updated Successfully');
							res.redirect('/pages/1');
						}
					});
				}
			}
		})
	});
	router.get('/add/:pages?',function (req,res){
		res.render('pages/addlist', {
			option: 7
		});
	});
	router.get('/add/options/:data', function(req, res) {
		res.render('pages/addlist', {
			option: parseInt(req.params.data) + 1
		})
	})
	router.post('/add/question',function (req,res){

		var title = req.body.title;
		var status = req.body.status;
		var descripation = req.body.descripation
		var option = req.body.Option

		let pageData = {
			'question_title': title,
			'question_descripation': descripation,
			'iscustom': status,
		};
	
		GoalObject.saveQuestionaries(pageData , function(err, response){
			if(err)
			{
				req.flash('error_message','Something went wrong');
			}else{
				if(response) {
					GoalObject.setQuestionOptions(option, response.id, function(err, SaveOption) {
						req.flash('success_message','saved Successfully');
						res.redirect('/pages/1');
					})
				}
			}
		});
	});
	router.get('/option/:id?',function (req,res){
		var page_id = req.params.id;

		GoalObject.GetQuestion(page_id,function(err,pageData)
			{
				if (err)
				{
					req.flash('error_message', 'Unable to fetch page detail');

				}else
				{
					res.render('pages/optionlist',{
						pageValue : pageData,
						custom_helper: custom_helper
					});
				}
			});

	});
	router.post('/option',function (req,res){

		var title = req.body.title;
		var id =  req.body.question_id
		GoalObject.SaveQuetionOption(title, id , function(err, response){
			if(err)
			{
				req.flash('error_message','Something went wrong');
			}else{
				req.flash('success_message','Option Added Successfully');
				res.redirect('/pages/1');
			}
		});
	});
	router.get('/delete/:id',function (req,res){

		var id = req.params.id;
		GoalObject.removeQuestionaries(id , function(err, response){
			if(err)
			{
				req.flash('error_message','Something went wrong');
			}else{
				if(response) {
					GoalObject.removeOption(id , function(err, response){
						if(err)
						{
							req.flash('error_message','Something went wrong');
						}else{
							if(response) {
								GoalObject.removeQuestionariesAnswer(id , function(err, response){
									if(err)
									{
										req.flash('error_message','Something went wrong');
									}else{
										if(response) {
											req.flash('error_message','Option delete Successfully');
											res.redirect('/pages/1');
										} else {
											req.flash('error_message','Something went wrong');
										}
									}
								});
							} else {
								req.flash('error_message','Something went wrong');
							}
						}
					});
				} else {
					req.flash('error_message','Something went wrong');
				}
			}
		});
	});
	router.get('/view/:id/:page', function(req, res) {
	let id = req.params.id
	var perPage = 5;
	var page = req.params.page || 1;
	
	let paginationData = {
		'offset': (perPage * page) - perPage,
		'limit' : perPage,
	};

	GoalObject.getQuestionOption(paginationData, id, function(err, pageData)
	{
		    if(pageData)
			{
				if (err) 
				{  
					req.flash('error_message','Error Occured: Unable to fetch page list');
				}else 
				{
					const itemCount = pageData.count;
					res.render('pages/optionview', {
						custom_helper: custom_helper,
						pageDataValue: pageData.rows,
						current: page,
						route_page: '/optionview',
						pages: Math.ceil(itemCount / perPage)
					});
				}
			}
		});
	})
module.exports = router;
