
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
		const response = await monthlyGoalObject.findOne({ where: { id: id } });
		callback(null, response);
	}

	// get goal by partner_id
	async getAllGoalsByPartnerID(partner_id, callback) {
		const response = await monthlyGoalObject.findAll({ where: { partner_mapping_id: partner_id, status: 1 } });
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

	// Create partner mapping
	async createPartnerMapping(partnerData, callback){

		const now = new Date();
		
		let monthlyGoalData = new partnerMappingObject({
			partner_one_id: partnerData.partner_one_id,
			partner_two_id: partnerData.partner_two_id,
			status: 1,
			create_time: current_datetime.format(now, 'YYYY-MM-DD hh:mm:ss'),
			update_time: current_datetime.format(now, 'YYYY-MM-DD hh:mm:ss')
		});

		callback(null,monthlyGoalData.save());
	}

	// get partner mapping by id
	async getPartnerById(id, callback) {
		const response = await partnerMappingObject.findOne({ where: { id: id } });
		callback(null, response);
	}

	// Create monthly goal
	async createMonthlyGoal(monthlyGoalData, callback){

		const now = new Date();

		callback(null, monthlyGoalObject.bulkCreate([
			{
				partner_mapping_id : monthlyGoalData.partner_mapping_id,
				user_id            : monthlyGoalData.user_id,
				month_start        : monthlyGoalData.month_start,
				month_end          : monthlyGoalData.month_end,
				connect_number     : monthlyGoalData.connect_number,
				initiator_count    : monthlyGoalData.initiator_count,
				percentage         : monthlyGoalData.percentage,
				complete_count     : 0,
				complete_percentage: 0,
				status: 1,
				create_time: current_datetime.format(now, 'YYYY-MM-DD hh:mm:ss'),
				update_time: current_datetime.format(now, 'YYYY-MM-DD hh:mm:ss')
			}, 
			{
				partner_mapping_id : monthlyGoalData.partner_mapping_id,
				user_id            : monthlyGoalData.partner_id,
				month_start        : monthlyGoalData.month_start,
				month_end          : monthlyGoalData.month_end,
				connect_number     : monthlyGoalData.connect_number,
				initiator_count    : monthlyGoalData.partner_initiator_count,
				percentage         : monthlyGoalData.partner_percentage,
				complete_count     : 0,
				complete_percentage: 0,
				status: 1,
				create_time: current_datetime.format(now, 'YYYY-MM-DD hh:mm:ss'),
				update_time: current_datetime.format(now, 'YYYY-MM-DD hh:mm:ss')
			}
		]));
	}

	// Update monthly goal
	async updateMonthlyGoal(monthlyGoalData, callback){

		const now = new Date();

		const goalData = await monthlyGoalObject.findAll({ where: { partner_mapping_id: monthlyGoalData.partner_mapping_id } });

		var partner_goal_id = 0;

		if(goalData[0].id==monthlyGoalData.goal_id)
		{
			partner_goal_id = goalData[1].id;
		}

		if(goalData[1].id==monthlyGoalData.goal_id)
		{
			partner_goal_id = goalData[0].id;
		}
		
		monthlyGoalObject.update({
			month_start        : monthlyGoalData.month_start,
			month_end          : monthlyGoalData.month_end,
			connect_number     : monthlyGoalData.connect_number,
			initiator_count    : monthlyGoalData.initiator_count,
			percentage         : monthlyGoalData.percentage,
			complete_count     : 0,
			complete_percentage: 0,
			status: 1,
			create_time: current_datetime.format(now, 'YYYY-MM-DD hh:mm:ss'),
			update_time: current_datetime.format(now, 'YYYY-MM-DD hh:mm:ss')
		}, 
		{ where: { id: monthlyGoalData.goal_id }});

		var partner_percentage = 100 - monthlyGoalData.percentage;
		var partner_initiator_count = monthlyGoalData.connect_number - monthlyGoalData.initiator_count;

		callback(null, monthlyGoalObject.update({
			month_start        : monthlyGoalData.month_start,
			month_end          : monthlyGoalData.month_end,
			connect_number     : monthlyGoalData.connect_number,
			initiator_count    : partner_initiator_count,
			percentage         : partner_percentage,
			complete_count     : 0,
			complete_percentage: 0,
			status: 1,
			create_time: current_datetime.format(now, 'YYYY-MM-DD hh:mm:ss'),
			update_time: current_datetime.format(now, 'YYYY-MM-DD hh:mm:ss')
		}, 
		{ where: { id: partner_goal_id }}));

	}
}

module.exports = GoalService;
