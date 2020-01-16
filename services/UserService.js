
/** 
  * @desc this service file will define all the functions related to the user
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file UserService.js
*/

const userObject = require('../models/user');
const dbObj      = require('../config/database');
const config     = require('../config/config');
const bcrypt     = require('bcryptjs');
const nodemailer = require('nodemailer');
const current_datetime = require('date-and-time');

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
	async sendForgotEmail(userDataWithtoken, callback){

		var transporter = nodemailer.createTransport({
			service: config.email_service,
			auth: {
			  user: config.gmail_id,
			  pass: config.gmail_password
			}
		  });

		var mailOptions = {
			from: '"Knitrino Support" <navneet.kumar@subcodevs.com>',
			to: userDataWithtoken.email,
			subject: 'Knitniro :: Forgot Password Email',
			html: '<h5>Hello,</h5><p>Please find the security code: <b>'+userDataWithtoken.token_key+'</b></p>'
		}

		transporter.sendMail(mailOptions, function(error, info){
			if (error) {
				console.log(error);
			} else {
				console.log('Email sent: ' + info.response);
			}
		});

		let condition  = {email: userDataWithtoken.email};
		let updateData = {token_key: userDataWithtoken.token_key};
		userObject.updateOne(condition, updateData, callback);
	}

	// update user profile
	async updateUserProfile(userData, callback){
		let condition  = {_id: userData.user_id};
		let updateData = {name: userData.name, bio: userData.bio, website: userData.website};
		userObject.updateOne(condition, updateData, callback);
	}

	// update user profile image
	async updateProfileImage(userImage, callback){
		let condition  = {_id: userImage.user_id};
		let updateData = {user_image: userImage.upload_file};
		userObject.updateOne(condition, updateData, callback);
	}

	// update user password
	async updateUserPassword(userDataUpdate, callback){
		let condition  = {email: userDataUpdate.email};
		let updateData = {token_key: ''};

		bcrypt.genSalt(10, function(err, salt) {
			bcrypt.hash(userDataUpdate.new_password, salt, function(err, hash) {
				updateData.password = hash;				
				userObject.updateOne(condition, updateData, callback);
			});
		});
	}
}

module.exports = UserService;




