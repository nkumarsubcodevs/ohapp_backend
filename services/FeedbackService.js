
/** 
  * @desc this service file will define all the functions related to the goal
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file FeedBackServices.js
*/


const feedbackObject  = require('../models/feedback');
const userObject  = require('../models/user');
const current_datetime = require('date-and-time');
const db = require('../config/database');
const Sequelize = require('sequelize');
const Op = Sequelize.Op

class FeedBackServices
{

	// Save Goal Setting
	async saveFeedback(userID, feedback, callback){

		const now = new Date();
		let settingData = new feedbackObject({
			user_id: userID,
			feedback_details: feedback,
			create_time: current_datetime.format(now, 'YYYY-MM-DD hh:mm:ss'),
			update_time: current_datetime.format(now, 'YYYY-MM-DD hh:mm:ss')
		});

		callback(null,await settingData.save());
	}

	async getfeedback(user_id, callback) {
		let response = await feedbackObject.findOne({where: {user_id: user_id}});
		callback(null, response);
	}

	async updatefeedback(user_id,feedback, callback) {
		let response = await feedbackObject.update({feedback_details: feedback},{where : {user_id: user_id}})
		callback(null, response)
	}

	async getfeedbackWithUser(paginationData,callback) {
		feedbackObject.belongsTo(userObject, {foreignKey: 'user_id'});
		await feedbackObject.findAndCountAll({
			include: [{
						model: userObject,
					 }]
		}).then(res => {
			callback(null, res)
		}).catch(err => {
			console.log(err)
			callback(err.message, null)
		});
	}

}

module.exports = FeedBackServices;
