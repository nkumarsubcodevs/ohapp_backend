/** 
  * @desc this file will define the routes for web users
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file users.js
*/

const express = require('express');
const userService = require('../../services/UserService');
const User = require('../../models/user')
const passport = require('passport');
const LocalStrategy = require('passport-local').Strategy;

let router =  express.Router();
var userSerObject = new userService();

var sessionChecker = (req, res, next) => {
    if (!req.session.passport ) {
        res.redirect('/');
    } else {
        next();
    }
};

// Display new register screen
router.get('/register', function(req, res){
  	res.render('users/register');
});

// Register new user
router.post('/register', function(req, res){
  	let name = req.body.name;
	let email = req.body.email;
	let password = req.body.password;
	let cfm_pwd = req.body.cfm_pwd;

	req.checkBody('name', 'Name is required').notEmpty();
	req.checkBody('email', 'Email is required').notEmpty();
	req.checkBody('email', 'Please enter a valid email').isEmail();
	req.checkBody('password', 'Password is required').notEmpty();
	req.checkBody('cfm_pwd', 'Confirm Password is required').notEmpty();
	req.checkBody('cfm_pwd', 'Confirm Password Must Matches With Password').equals(password);

	let errors = req.validationErrors();
	if(errors)
	{
		res.render('users/register',{errors: errors});
	}
	else
	{
		let user = new User({
		name: name,
		email: email,
		password: password
		});
		user.save().then(user =>{
			
		}).catch(err => {
				throw err
			})
		req.flash('success_message','You have registered, Now please login');
		res.redirect('login');
	}
});

// Display login screen to the user
router.get('/login', function(req, res){
  	res.render('users/login');
});

// Compare user password
passport.use(new LocalStrategy({
	usernameField: 'email',
	passwordField: 'password',
	passReqToCallback : true
},
    async function(req, email, password, done) {

		userSerObject.getUserByEmail(email, function(err, user) 
		{
			if (err) { return done(err); }
	  		if (!user) {
				return done(null, false, req.flash('error_message', 'No email is found'));
	  		}
			if (user.role_id == 1) {
				userSerObject.comparePassword(password, user.password, function(err, isMatch) 
				{
					if (err) { return done(err); }
					if(isMatch){
						  return done(null, user, req.flash('success_message', 'You have successfully logged in!!'));
					}
					else{
						  return done(null, false, req.flash('error_message', 'Incorrect Password'));
					}
				});
			} else {
				return done(null, false, req.flash('error_message', 'You are not able to login In Admin Panel'));
			}
		});
  	}
));

// Serialize user passport
passport.serializeUser(function(user, done) {
  	done(null, user.id);
});

// Deserialize user passport
passport.deserializeUser(function(id, done) {
	userSerObject.getUserById(id, function(err, user) {
		done(err, user);
  	});
});

// Login user
router.post('/login', passport.authenticate('local', {
	failureRedirect: '/users/login', failureFlash: true
	}),
	function(req, res){
  		res.redirect('/');
	}
);

// Logout user
router.get('/logout', function(req, res){
	req.logout();
	req.flash('success_message', 'You are logged out');
	res.redirect('/users/login');
});

// Display User screen
router.get('/:page?', sessionChecker, function(req, res){

	var perPage = 10;
	var page = req.params.page || 1;

	let paginationData = {
		'offset': (perPage * page) - perPage,
		'limit' : perPage,
	};

	userSerObject.getuserList(paginationData ,function(err, pageData)
	{
		if(pageData)
		{
			if (err)
			{
				req.flash('error_message','Error Occured: Unable to fetch users list');
				res.redirect('/users/users');
			}else
			{
				const itemCount = pageData.count;
				res.render('users/users', {
                    pageDataValue: pageData.rows,
					current: page,
					route_page: '/users',
                    pages: Math.ceil(itemCount / perPage)
                });
			}
		}
	});
});

// Implemented Seach for user screen
router.post('/search', sessionChecker, function(req, res) {

	var perPage = 10;
	var page = req.params.page || 1;
	var serach = req.body.search;
	let paginationData = {
		'offset': (perPage * page) - perPage,
		'limit' : perPage,
		'name'	: serach
	};

	userSerObject.getusersearchList(paginationData,function(err, pageData)
	{
		if(pageData)
		{
			if (err)
			{
				req.flash('error_message','Error Occured: Unable to fetch users list');
				res.redirect('/users/users');
			}else
			{
				const itemCount = pageData.count;
				res.render('users/users', {
                    pageDataValue: pageData.rows,
					current: page,
					route_page: '/users',
                    pages: Math.ceil(itemCount / perPage)
                });
			}
		}
	});
})

// Update User Account is active or deactive
router.get('/status/:status?/:id', sessionChecker, function(req, res) {
	userSerObject.updateUserStatus(req.params.status, req.params.id, function(err, response) {
		if(err) {
			req.flash('error_message','Error Occured: Unable to fetch users list');
			res.redirect('/users/1');
		} else {
			req.flash('success_message','Status changed success fully');
			res.redirect('/users/1');
		}
	} )
})
module.exports = router;