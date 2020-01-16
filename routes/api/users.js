/** 
  * @desc this file will contains the routes for user api
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file users.js
*/

const express = require('express');
const userService = require('../../services/UserService');
const emailvalidator = require("email-validator");
const path = require('path');

// JWT web token
const jwt         = require('jsonwebtoken');

// Get API secret
const config      = require('../../config/config');

// verifytoken middleware
const verifyToken = require('./verifytoken');

// Include image upload lib
const multer  =   require('multer');

const multerConf = {
	storage : multer.diskStorage({
		destination: (req, file, next) => {
			next(null, 'public/profile_images')
		},
		filename: function(req, file, next){
			const ext = file.mimetype.split("/")[1];
			next(null, file.fieldname + '-' + Date.now()+'.'+ext);
		}
	}),
	limits: {
        fileSize: 250000
    },
	fileFilter: function(req, file, next){
		
		if(!file)
		{
			next();
		}
		
		const image = file.mimetype.startsWith('image/');

		if(image)
		{
			next(null, true);
		}
		else
		{
			next({message:"Please upload valid file format(jpg, jpeg, png)"}, false);
		}
	}
};

var uploadObject = multer(multerConf).single('user_photo');

// Create route object
let router =  express.Router();

// Create user model object
var userSerObject = new userService();

// Get user detail
router.get('/getuserdetail', verifyToken, function(req, res, next) {

	userSerObject.getUserById(req.id, function(err, userData)
	{
		if(err)
		{
			res.send({
				status: 500,
				message: 'There was a problem finding the user.',
			});
		}
		else
		{
			if(userData)
			{
				let userDetail = {
					'name': userData.name,
					'email': userData.email,
					'role_id': userData.role_id,
					'image_name': userData.user_image,
					'bio': userData.bio,
					'website': userData.website,
					'status': userData.status
				};

				res.send({
					status: 200,
					result: userDetail,
				});
			}
			else
			{
				res.send({
					status: 404,
					message: 'No user found.',
				});
			}	
		}
	});
});

// New user registration
router.post('/register', function(req, res){

	let first_name = req.body.first_name;
	let last_name  = req.body.last_name;
	let gender     = req.body.gender;
	let email      = req.body.email;
	let password = req.body.password;
	let confirm_password     = req.body.confirm_password;
	let role_id  = 2;
	let status   = 1;

	if(!email) 
	{
		return res.send({
			status: 400,
			message: 'Email is required',
		});
	}

	if(!emailvalidator.validate(email)) 
	{
		return res.send({
			status: 400,
			message: 'Please enter a valid email',
		});
	}

	if(!password) 
	{
		return res.send({
			status: 400,
			message: 'Password is required',
		});
	}

	if(!confirm_password) 
	{
		return res.send({
			status: 400,
			message: 'Confirm password is required',
		});
	}

	if(password!=confirm_password) 
	{
		return res.send({
			status: 400,
			message: 'Password and confirm password should be same.',
		});
	}

	let userData = {
		'role_id': role_id,
		'first_name': first_name,
		'last_name': last_name,
		'gender': gender,
		'email': email.toLowerCase(),
		'password': password,
		'status': status
	};

	userSerObject.getUserByEmail(email, function(err, user) 
	{
		if(err)
		{
			res.send({
				status: 500,
				message: 'something went wrong',
			});
		}
		else
		{
			if(user) 
			{
				return res.send({
					status: 405,
					message: 'Email-Id already exists: '+email,
				});
			}
			else
			{
				userSerObject.createUser(userData, function(err, userData)
				{
					if(err)
					{
						res.send({
							status: 500,
							message: 'something went wrong',
						});
					}
					else
					{
						var token = jwt.sign({ id: userData.id }, config.secret, {
							expiresIn: 86400 // expires in 24 hours
						});

						res.send({
							status: 200,
							message: 'success',
							result: userData,
							token: token
						});
					}
				});
			}
		}
	});
});

// User login
router.post('/login', function(req, res) {

	let email    = req.body.email;
	let password = req.body.password;

	if(!email) 
	{
		return res.send({
			status: 400,
			message: 'Email is required',
		});
	}

	if(!emailvalidator.validate(email)) 
	{
		return res.send({
			status: 400,
			message: 'Please enter a valid email',
		});
	}

	if(!password) 
	{
		return res.send({
			status: 400,
			message: 'Password is required',
		});
	}

	let userData = {
		'email': email,
		'password': password,
	};

	userSerObject.getUserByEmail(email, function(err, user) 
	{
		if(err)
		{
			res.send({
				status: 500,
				message: 'something went wrong',
			});
		}
		else
		{
			if(user) 
			{
				userSerObject.comparePassword(password, user.password, function(err, isMatch) 
				{
					if(err)
					{
						res.send({
							status: 500,
							message: 'something went wrong',
						});
					}

					if(isMatch)
					{
						var token = jwt.sign({ id: user._id }, config.secret, {
							expiresIn: 86400 // expires in 24 hours
						});

						res.send({
							status: 200,
							message: 'success',
							token: token
						});
					}
					else
					{
						return res.send({
							status: 401,
							message: 'Invalid email or password.',
							auth: false, 
							token: null
						});
					}
				});
			}
			else
			{
				return res.send({
					status: 400,
					message: 'No user found',
				});
			}
		}
	});
});

// Get Forgot Password Email
router.post('/forgotpasswordemail', function(req, res) {

	let email    = req.body.email;

	if(!email) 
	{
		return res.send({
			status: 400,
			message: 'Email is required',
		});
	}

	if(!emailvalidator.validate(email)) 
	{
		return res.send({
			status: 400,
			message: 'Please enter a valid email',
		});
	}

	let userData = {
		'email': email,
	};

	userSerObject.getUserByEmail(email, function(err, userData) 
	{
		if(err)
		{
			res.send({
				status: 500,
				message: 'something went wrong',
			});
		}
		else
		{
			if(userData) 
			{

				let userDataWithtoken = {
					'email': email,
					'token_key': Math.floor(100000 + Math.random() * 900000),
				};

				userSerObject.sendForgotEmail(userDataWithtoken, function(err, userData) 
				{
					if(err)
					{
						res.send({
							status: 500,
							message: 'something went wrong',
						});
					}

					if(userData)
					{
						let passwordToken = {
							'security_code': userDataWithtoken.token_key,
						};
						
						res.send({
							status: 200,
							message: 'Email sent successfully.',
							result: passwordToken,
						});
					}
					else
					{
						res.send({
							status: 404,
							message: 'No user found.',
						});
					}
				});
			}
			else
			{
				return res.send({
					status: 400,
					message: 'No user found',
				});
			}
		}
	});
});

// Get Password Reset
router.post('/passwordreset', function(req, res) {

	let email         = req.body.email;
	let security_code = req.body.security_code;
	let new_password  = req.body.new_password;
	let confirm_password = req.body.confirm_password;

	if(!email) 
	{
		return res.send({
			status: 400,
			message: 'Email is required',
		});
	}

	if(!emailvalidator.validate(email)) 
	{
		return res.send({
			status: 400,
			message: 'Please enter a valid email',
		});
	}

	if(!security_code) 
	{
		return res.send({
			status: 400,
			message: 'Security code is required',
		});
	}

	if(!new_password) 
	{
		return res.send({
			status: 400,
			message: 'New password is required',
		});
	}

	if(!confirm_password) 
	{
		return res.send({
			status: 400,
			message: 'Confirm password is required',
		});
	}

	if(new_password!=confirm_password) 
	{
		return res.send({
			status: 400,
			message: 'New password and confirm password should be same.',
		});
	}

	let userData = {
		'email': email,
		'security_code': security_code,
		'new_password': new_password,
		'confirm_password': confirm_password,
	};

	userSerObject.getUserByEmail(email, function(err, userData) 
	{
		if(err)
		{
			res.send({
				status: 500,
				message: 'something went wrong',
			});
		}
		else
		{
			if(userData) 
			{

				let userDataUpdate = {
					'email': email,
					'security_code': security_code,
					'new_password': new_password,
					'confirm_password': confirm_password,
				};

				if(userData.token_key!=userDataUpdate.security_code) 
				{
					return res.send({
						status: 400,
						message: 'Invalid security code.',
					});
				}

				userSerObject.updateUserPassword(userDataUpdate, function(err, userDataUpdate) 
				{
					if(err)
					{
						res.send({
							status: 500,
							message: 'something went wrong in update the password.',
						});
					}

					if(userDataUpdate.nModified==1 && userDataUpdate.ok==1)
					{			
						res.send({
							status: 200,
							message: 'Password updated successfully.',
						});
					}
					else
					{
						res.send({
							status: 404,
							message: 'No user found.',
						});
					}
				});
			}
			else
			{
				return res.send({
					status: 400,
					message: 'No user found',
				});
			}
		}
	});
});

// update user profile
router.post('/profileupdate', verifyToken, function(req, res, next) {

	let user_id  = req.id;
	let name     = req.body.name;
	let bio      = req.body.bio;
	let website  = req.body.website;

	if(!name) 
	{
		return res.send({
			status: 400,
			message: 'Name is required',
		});
	}

	if(!bio) 
	{
		return res.send({
			status: 400,
			message: 'Bio is required',
		});
	}

	let userData = {
		'user_id': user_id,
		'name': name,
		'bio': bio,
		'website': website,
	};

	userSerObject.updateUserProfile(userData, function(err, userData)
	{
		if(err)
		{
			res.send({
				status: 500,
				message: 'There was a problem finding the user.',
			});
		}
		else
		{
			if(userData)
			{
				res.send({
					status: 200,
					message: 'Profile updated successfully',
				});
			}
			else
			{
				res.send({
					status: 404,
					message: 'No user found.',
				});
			}	
		}
	});
});

/**
 * @swagger
 * /users/logout:
 *   get:
 *     tags:
 *       - Logout
 *     description: Logout user
 *     produces:
 *       - application/json
 *     responses:
 *       200:
 *         description: success
 */

// User logout
router.get('/logout', function(req, res){
	res.send({
		status: 200,
		message: 'success',
		auth: false,
		token: null
	});
});


// Update profile image
router.post('/profileimageupdate', verifyToken, (req, res, next) => {

	uploadObject(req, res, function(err) {

		if(err) 
		{
			res.send({
				status: 500,
				message: err.message,
			});
		}
		else
		{
			let upload_file  = req.file;
			let user_id  = req.id;

			let userImageData = {
				'user_id': user_id,
				'upload_file': upload_file.filename,
			};
	
			userSerObject.updateProfileImage(userImageData, function(err, userImageData)
			{
				if(err)
				{
					res.send({
						status: 500,
						message: 'Error uploading file.',
					});
				}
				else
				{
					if(userImageData)
					{
						res.send({
							status: 200,
							message: 'Image uploaded successfully.',
							image_name: upload_file.filename
						});
					}
					else
					{
						res.send({
							status: 404,
							message: 'Error occured in image upload.',
						});
					}	
				}
			});
		}
	});
});

module.exports = router;