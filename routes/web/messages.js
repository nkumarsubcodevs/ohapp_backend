/** 
  * @desc this file will define the routes for web messages
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file messages.js
*/

const express = require('express');
const MessageService = require('../../services/InfoMessages');
const passport = require('passport');
const LocalStrategy = require('passport-local').Strategy;
const custom_helper = require('../../helpers/custom_helper');

let router =  express.Router();
var MessagesObject = new MessageService();

// Display new register screen
router.get('/:page', function(req, res){

	var perPage = 10;
	var page = req.params.page || 1;

	let paginationData = {
		'offset': (perPage * page) - perPage,
		'limit' : perPage,
	};

	MessagesObject.getAllMessages(paginationData, function(err, pageData)
	{
		    if(pageData)
			{
				if (err) 
				{  
					req.flash('error_message','Error Occured: Unable to fetch page list');
				}else 
				{
					const itemCount = pageData.count;
					res.render('messages/pages', {
						custom_helper: custom_helper,
						pageDataValue: pageData.rows,
						current: page,
						route_page: '/messages',
						pages: Math.ceil(itemCount / perPage)
					});
				}
			}
		});
});
router.get('/add/:pages?',function (req,res){
	res.render('messages/addlist', {
		option: 7
	});
});
router.post('/add',function (req,res){

	let data = {
		title: req.body.title,
		descripation: req.body.descripation,
		key: req.body.key,
		screen: req.body.screen
	}
	MessagesObject.saveMessages(data, function(err, response){
		if(err)
		{
			req.flash('error_message','Something went wrong');
		}else{
			if(response) {
				req.flash('success_message','saved Successfully');
				res.redirect('/messages/1');
			}
		}
	});
});
router.get('/edit/:id',function(req,res)
{
	var page_id = req.params.id;
	MessagesObject.getSingleInfoMessageById(page_id,function(err,pageData)
		{
			if (err)
			{
				req.flash('error_message', 'Unable to fetch page detail');

			}else
			{
				res.render('messages/updatelistPages',{
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
	var descripation = req.body.descripation;
	let UpdateData ={
		id: page_id,
		title: title,
		descripation: descripation,
		status: status
	}
	MessagesObject.UpdateMessages(UpdateData, function(err, RemoveOption) {
		if(err) {
			res.send({
				status: 404,
				message: "Something Went worn"
			})
		} else {
			if(RemoveOption) {
				req.flash('success_message','Updated Successfully');
				res.redirect('/messages/1');
			}
		}
	})
});

router.get('/delete/:id',function (req,res){

	var id = req.params.id;
	MessagesObject.removeMessages(id , function(err, response){
		if(err)
		{
			req.flash('error_message','Something went wrong');
		}else{
			if(response) {
				req.flash('error_message','Option delete Successfully');
				res.redirect('/messages/1');
			} else {
				req.flash('error_message','Something went wrong');
			}
		}
	});
});
module.exports = router;