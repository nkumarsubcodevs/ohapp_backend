
/** 
  * @desc this service file will define all the functions related to the goal
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file GoalService.js
*/

const goalSettingsObject = require('../models/goal_settings');
const goalSettingAnswerObject  = require('../models/goal_setting_answers');
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
		const response = await monthlyGoalObject.findOne({ where: { id: id } });
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
}

module.exports = GoalService;




