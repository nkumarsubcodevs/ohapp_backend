
/** 
  * @desc this service file will define all the functions related to the goal
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file FeedBackServices.js
*/


const feedbackObject = require('../models/feedback');
const userObject = require('../models/user');
const current_datetime = require('date-and-time');
const db = require('../config/database');
const Sequelize = require('sequelize');
const Op = Sequelize.Op

class FeedBackServices {

	// Save Goal Setting
	async saveFeedback(userID, feedback, callback) {

		const now = new Date();
		let settingData = new feedbackObject({
			user_id: userID,
			feedback_details: feedback,
			create_time: current_datetime.format(now, 'YYYY-MM-DD hh:mm:ss'),
			update_time: current_datetime.format(now, 'YYYY-MM-DD hh:mm:ss')
		});

		callback(null, await settingData.save());
	}

	// Get Feedback data by Id
	async getfeedback(user_id, callback) {
		let response = await feedbackObject.findOne({ where: { user_id: user_id } });
		callback(null, response);
	}

	// Update feedback
	async updatefeedback(user_id, feedback, callback) {
		let response = await feedbackObject.update({ feedback_details: feedback }, { where: { user_id: user_id } })
		callback(null, response)
	}

	// Get All feedback data with user data for Admin panel
	async getfeedbackWithUser(paginationData, callback) {
		feedbackObject.belongsTo(userObject, { foreignKey: 'user_id' });
		await feedbackObject.findAndCountAll({
			include: [{
				model: userObject,
			}]
		}).then(res => {
			callback(null, res)
		}).catch(err => {

			callback(err.message, null)
		});
	}

	// Count Total no. of Feedback
	async getAllFeedbackCount(callback) {
		await feedbackObject.findAndCountAll().then(res => {
			callback(null, res)
		}).catch(err => {

			callback(err.message, null)
		});
	}

	// Get Today Feedback data with User data and Count Total no. of feedback for today in Admin Panel
	async getNewfeedbackWithUser(callback) {
		feedbackObject.belongsTo(userObject, { foreignKey: 'user_id' });
		await feedbackObject.findAndCountAll({
			include: [{
				model: userObject,
			}],
			where: {
				create_time: {
					[Op.gte]: current_datetime.format(new Date(), "YYYY-MM-DD", true)
				}
			}
		}).then(res => {
			callback(null, res)
		}).catch(err => {
			callback(err.message, null)
		});
	}

	// Remove feedback data
	async RemoveFeedback(user_id, callback) {
		await feedbackObject.destroy({ where: { user_id: user_id } }).then(res => {
			callback(null, res);
		}).catch(err => {
			callback(err.message, null)
		})
	}
}

module.exports = FeedBackServices;
