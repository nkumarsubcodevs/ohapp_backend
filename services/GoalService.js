
/** 
  * @desc this service file will define all the functions related to the goal
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file GoalService.js
*/

const goalSettingsObject = require('../models/goal_settings');
const goalSettingAnswerObject  = require('../models/goal_setting_answers');
const partnerMappingObject   = require('../models/partner_mappings');
const monthlyGoalObject  = require('../models/monthly_goals');
const current_datetime = require('date-and-time');

class GoalService
{
	// get goal setting
	async getGoalSettings(callback){
		const goal_settings = await goalSettingsObject.findAll();
		callback(null,goal_settings);
	}

	// get goal by id
	async getGoalById(id, callback) {
		const response = await partnerMappingObject.findOne({ where: { id: id } });
		callback(null, response);
	}

	// get user combination
	async checkParterLink(partnerData, callback) {
		const response = await partnerMappingObject.findOne({ where: { partner_one_id: partnerData.partner_one_id, partner_two_id: partnerData.partner_two_id  } });
		callback(null, response);
	}

	// get setting question by id
	async getGoalSettingsQuestionById(id, callback) {
		const response = await goalSettingsObject.findOne({ where: { id: id } });
		callback(null, response);
	}

	// Save Goal Setting
	async saveSettings(goalSettingData, callback){

		const now = new Date();
		
		let settingData = new goalSettingAnswerObject({
			goal_id: goalSettingData.goal_id,
			question_id: goalSettingData.question_id,
			answer: goalSettingData.answer,
			status: 1,
			create_time: current_datetime.format(now, 'YYYY-MM-DD hh:mm:ss'),
			update_time: current_datetime.format(now, 'YYYY-MM-DD hh:mm:ss')
		});

		callback(null,settingData.save());
	}

	// Create monthly goal
	async createMonthlyGoal(monthlyData, callback){

		const now = new Date();
		
		let monthlyGoalData = new partnerMappingObject({
			partner_one_id: monthlyData.partner_one_id,
			partner_two_id: monthlyData.partner_two_id,
			status: 1,
			create_time: current_datetime.format(now, 'YYYY-MM-DD hh:mm:ss'),
			update_time: current_datetime.format(now, 'YYYY-MM-DD hh:mm:ss')
		});

		callback(null,monthlyGoalData.save());
	}
}

module.exports = GoalService;




