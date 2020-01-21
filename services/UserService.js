
/** 
  * @desc this service file will define all the functions related to the user
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file UserService.js
*/

const userObject = require('../models/user');
const unavailabilityObject = require('../models/unavailabilities');
const dbObj      = require('../config/database');
const config     = require('../config/config');
const bcrypt     = require('bcryptjs');
const current_datetime = require('date-and-time');

const randomstring = require("randomstring");
const fs = require('fs');
const nodemailer = require('nodemailer');
const handlebars = require('handlebars');

class UserService
{
	// Create new user
	async createUser(newUser, callback){

		const now = new Date();

		let userData = new userObject({
			role_id: newUser.role_id,
			first_name: newUser.first_name,
			last_name: newUser.last_name,
			gender: newUser.gender,
			email: newUser.email,
			password: newUser.password,
			status: newUser.status,
			create_time: current_datetime.format(now, 'YYYY-MM-DD hh:mm:ss'),
			update_time: current_datetime.format(now, 'YYYY-MM-DD hh:mm:ss')
		});

		bcrypt.genSalt(10, function(err, salt) {
			bcrypt.hash(userData.password, salt, function(err, hash) {
				userData.password = hash;

				//*******  Email Code
				var readHTMLFile = function(path, callback) {
					fs.readFile(path, {encoding: 'utf-8'}, function (err, html) {
						if (err) {
							throw err;
							callback(err);
						}
						else {
							callback(null, html);
						}
					});
				};
		
				var transporter = nodemailer.createTransport({
					service: config.email_service,
					port: 587,
					secure: false,
					auth: {
						user: config.gmail_id,
						pass: config.gmail_password
					}
				});
		
				readHTMLFile(config.signup_template, function(err, html) {
					var template = handlebars.compile(html);
					var replacements = {
						username: newUser.first_name,
						user_email: newUser.email,
						site_logo: config.site_logo,
					};
					var htmlToSend = template(replacements);
		
					var mailOptions = {
						from: '"OH Team" <'+config.from_email+'>',
						to: newUser.email,
						subject: 'OH :: SignUp Email',
						html : htmlToSend
					}
		
					transporter.sendMail(mailOptions, function (error, info) {
						if (error) {
						console.log(error);
						} else {
						console.log('Email sent: ' + info.response);
						}
					});
				});
				//*******  Email Code

				callback(null,userData.save());
			});
		});
		
    }

	// get user by email
	async getUserByEmail(email, callback){
		const user = await userObject.findOne({ where: { email: email } });
		callback(null,user);
	}

	// compare password
	async comparePassword(password, hash, callback){
		bcrypt.compare(password, hash, function(err, isMatch){
			if(err) throw err;
			callback(null, isMatch);
		});
	}
	
	// get user by id
	async getUserById(id, callback) {
		const response = await userObject.findOne({ where: { id: id } });
		callback(null, response);
	}
	
	// send forgot password email
	async sendForgotEmail(userData, callback){

		var new_password = randomstring.generate(8);
		var user_detail = await userObject.findOne({ where: { email: userData.email } });

		var readHTMLFile = function(path, callback) {
			fs.readFile(path, {encoding: 'utf-8'}, function (err, html) {
				if (err) {
					throw err;
					callback(err);
				}
				else {
					callback(null, html);
				}
			});
		};

		var transporter = nodemailer.createTransport({
			service: config.email_service,
			port: 587,
			secure: false,
			auth: {
				user: config.gmail_id,
				pass: config.gmail_password
			}
		});


		readHTMLFile(config.forgot_password_template, function(err, html) {
			var template = handlebars.compile(html);
			var replacements = {
				username: user_detail.first_name,
				user_email: user_detail.email,
				new_password: new_password,
				site_url: config.site_url,
				site_logo: config.site_logo,
			};
			var htmlToSend = template(replacements);

			var mailOptions = {
				from: '"OH Team" <'+config.from_email+'>',
				to: userData.email,
				subject: 'OH :: Forgot Password Email',
				html : htmlToSend
			}

			transporter.sendMail(mailOptions, function (error, info) {
				if (error) {
				console.log(error);
				} else {
				console.log('Email sent: ' + info.response +' >> '+new_password);
				}
			});
		});

		bcrypt.genSalt(10, function(err, salt) {
			bcrypt.hash(new_password, salt, function(err, hash) {
				const now = new Date();
				callback(null, userObject.update({ password: hash, update_time: current_datetime.format(now, 'YYYY-MM-DD hh:mm:ss') }, { where: { email: userData.email }}));
			});
		});
	}

	// update user profile
	async updateUserProfile(userData, callback){
		const now = new Date();
		callback(null, userObject.update({ first_name:  userData.first_name, last_name:  userData.last_name, update_time: current_datetime.format(now, 'YYYY-MM-DD hh:mm:ss') }, { where: { id: userData.user_id }}) );
	}

	// update user profile image
	async updateProfileImage(userImage, callback){
		let condition  = {_id: userImage.user_id};
		let updateData = {user_image: userImage.upload_file};
		userObject.updateOne(condition, updateData, callback);
	}

	// update user password
	async updateUserPassword(userDataUpdate, callback){
		bcrypt.genSalt(10, function(err, salt) {
			bcrypt.hash(userDataUpdate.new_password, salt, function(err, hash) {
				const now = new Date();
				callback(null, userObject.update({ password: hash, update_time: current_datetime.format(now, 'YYYY-MM-DD hh:mm:ss') }, { where: { id: userDataUpdate.user_id }}));
			});
		});
	}

	// add unavailability
	async addUnavailability(userData, callback){

		const now = new Date();

		let userDataEntry = new unavailabilityObject({
			user_id: userData.user_id,
			unavailability_start: userData.unavailability_start,
			unavailability_end: userData.unavailability_end,
			status: 1,
			create_time: current_datetime.format(now, 'YYYY-MM-DD hh:mm:ss'),
			update_time: current_datetime.format(now, 'YYYY-MM-DD hh:mm:ss')
		});

		callback(null,userDataEntry.save());
	}
}

module.exports = UserService;




