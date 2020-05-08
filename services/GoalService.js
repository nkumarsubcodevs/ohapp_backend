
/** 
  * @desc this service file will define all the functions related to the goal
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file GoalService.js
*/

const goalSettingsObject = require('../models/goal_settings');
const goalSettingAnswerObject  = require('../models/goal_setting_answers');
const partnerMappingObject   = require('../models/partner_mappings');
const monthlyGoalObject  = require('../models/monthly_goals');
const questionOptionsObject  = require('../models/question_options');
const userObject  = require('../models/user');
const current_datetime = require('date-and-time');

const Sequelize = require('sequelize');
const Op = Sequelize.Op

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

	async getGoalByUserId(user_id, callback) {
		const response = await monthlyGoalObject.findAll({ where: { user_id: user_id, status: 1 } });
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

	// Get setting question by patner mapping id
	async getGoalSettingByPatnerMappingId(id, callback) {
		const response = await goalSettingAnswerObject.findOne({ where: { patner_mapping_id: id } });
		callback(null, response);
	}

	// update setting answer quetion
	async updatesetting(updatedData, callback) {
		const now = new Date();
		await goalSettingAnswerObject.update({
			goal_id: updatedData.goal_id,
			question_id: updatedData.question_id,
			answer: updatedData.answer,
			user_id: updatedData.user_id,
			patner_mapping_id: updatedData.patner_mapping_id,
			status: 1,
			update_time: current_datetime.format(now, 'YYYY-MM-DD hh:mm:ss')
		},
		{ where: { id: updatedData.id }})
		const response = await goalSettingAnswerObject.findOne({ where: { patner_mapping_id:  updatedData.patner_mapping_id } });
		callback(null, response);
	}
	// Save Goal Setting
	async saveSettings(goalSettingData, callback){

		const now = new Date();
		console.log(goalSettingData)
		let settingData = new goalSettingAnswerObject({
			goal_id: goalSettingData.goal_id,
			question_id: goalSettingData.question_id,
			answer: goalSettingData.answer,
			user_id: goalSettingData.user_id,
			patner_mapping_id: goalSettingData.patner_mapping_id,
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
		// const response = await partnerMappingObject.findOne({ where: { id: id } });

		var partner_id = 0;
		const partnerResponse = await partnerMappingObject.findOne({ where: { 
			    [Op.or]: [
				  {
					partner_one_id: {
						[Op.eq]: id
					}
				  },
				  {
					partner_two_id: {
						[Op.eq]: id
					}
				  }
				],
				[Op.and]: [
					{
					  status: {
						  [Op.eq]: 1
					  }
					},
				]	
			}});
		callback(null, partnerResponse);
	}
	async checkParternstage(id, callback) {
		const partnerResponse = await partnerMappingObject.findOne({ where: { 
			    [Op.or]: [
				  {
					partner_one_id: {
						[Op.eq]: id
					}
				  }
				],
				[Op.and]: [
					{
					  status: {
						  [Op.eq]: 1
					  }
					},
				]	
			}});
		callback(null, partnerResponse);
	}

	// get partner data by id
	async getPartnerData(id, callback) {
		const partnerResponse = await partnerMappingObject.findOne({ where: { partner_one_id: id } });
		callback(null, partnerResponse);
	}

	// Create monthly goal
	async createMonthlyGoal(monthlyGoalData, callback){

		const now = new Date();
		const random_number = now.getTime()+Math.floor(Math.random() * 1000);

		callback(null, monthlyGoalObject.bulkCreate([
			{
				partner_mapping_id : monthlyGoalData.partner_mapping_id,
				user_id            : monthlyGoalData.user_id,
				goal_identifier	   : random_number,
				month_start        : monthlyGoalData.month_start,
				month_end          : monthlyGoalData.month_end,
				connect_number     : monthlyGoalData.connect_number,
				initiator_count    : monthlyGoalData.initiator_count,
				initiator_count1   : monthlyGoalData.initiator_count1,
				intimate_time      : monthlyGoalData.intimate_time,
				intimate_request_time : monthlyGoalData.intimate_request_time,
				intimate_account_time : monthlyGoalData.intimate_account_time,
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
				goal_identifier	   : random_number,
				month_start        : monthlyGoalData.month_start,
				month_end          : monthlyGoalData.month_end,
				connect_number     : monthlyGoalData.connect_number,
				initiator_count    : monthlyGoalData.initiator_count1,
				initiator_count1   : monthlyGoalData.initiator_count,
				intimate_time      : monthlyGoalData.intimate_time,
				intimate_request_time : monthlyGoalData.intimate_request_time,
				intimate_account_time : monthlyGoalData.intimate_account_time,
				percentage         : monthlyGoalData.partner_percentage,
				complete_count     : 0,
				complete_percentage: 0,
				status: 1,
				create_time: current_datetime.format(now, 'YYYY-MM-DD hh:mm:ss'),
				update_time: current_datetime.format(now, 'YYYY-MM-DD hh:mm:ss')
			}
		]));
	}

	// check Monthly Goal created or not
	async checkGoalCreated(partner_mapping_id, callback) {
		const now = new Date();
		const today = current_datetime.format(now, 'YYYY-MM-DD hh:mm:ss')
		monthlyGoalObject.belongsTo(userObject, {foreignKey: 'user_id'});
		const response = await monthlyGoalObject.findAll({
			where: { partner_mapping_id: partner_mapping_id, status:1 , month_end: {[Op.gt]: today}}, 
			include: [{
						model: userObject, 
						attributes: ['id', 'role_id', 'first_name', 'last_name', 'gender', 'email', 'profile_image', 'face_id', 'touch_id', 'notification_mute_status', 'notification_mute_end', 'status', 'update_time']
					 }]
		});
		callback(null, response)
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

	// Update monthly goal
	async getGoalDetails(partner_mapping_id, callback){

		monthlyGoalObject.belongsTo(userObject, {foreignKey: 'user_id'});
		const response = await monthlyGoalObject.findAll({
			where: { partner_mapping_id: partner_mapping_id, status:1 }, 
			include: [{
						model: userObject, 
						attributes: ['id', 'role_id', 'first_name', 'last_name', 'gender', 'email', 'profile_image', 'face_id', 'touch_id', 'notification_mute_status', 'notification_mute_end', 'status', 'update_time']
					 }]
		});

		callback(null, response);
	}

	// get user goal history via user_id
	async getAllGoalsHistoryByUserID(user_id, callback) {

		var goal_history = [];
		var partner_data;
		const response = await monthlyGoalObject.findAll({ 
			where: { user_id: user_id, status: 0 }
		});
		
		await Promise.all(response.map(async (element) => {

			monthlyGoalObject.belongsTo(userObject, {foreignKey: 'user_id'});

			partner_data = await monthlyGoalObject.findAll({ 
				where: { goal_identifier: element.goal_identifier, status: 0 },
				include: [{
					model: userObject, 
					attributes: ['id', 'first_name', 'last_name', 'gender', 'email', 'profile_image', 'face_id', 'touch_id', 'notification_mute_status', 'notification_mute_end', 'status', 'update_time']
				 }],
			});

			goal_history.push(partner_data);

		}));

		callback(null, goal_history);		
		
	}

	// Set Question Options
	async setQuestionOptions(title, callback) {
		const now = new Date();
		let Questiona_option = new questionOptionsObject({
			title: title,
			status: 1,
			create_time: current_datetime.format(now, 'YYYY-MM-DD hh:mm:ss'),
			update_time: current_datetime.format(now, 'YYYY-MM-DD hh:mm:ss')
		});
		callback(null,await Questiona_option.save())
	}

	// Get Question option
	async GetQuestionOption(callback) {
		const GetOption = await questionOptionsObject.findAll();
		callback(null,GetOption);
	}

	// Save Questionaries from Admin panel
	async saveQuestionaries(questionData, callback) {
		const now = new Date();
		let Questiona = new goalSettingsObject({
			question_descripation: questionData.question_descripation,
			question_title:questionData.question_title,
			iscustom:questionData.iscustom ? questionData.iscustom : false,
			status: 1,
			create_time: current_datetime.format(now, 'YYYY-MM-DD hh:mm:ss'),
			update_time: current_datetime.format(now, 'YYYY-MM-DD hh:mm:ss')
		});
		const data = await Questiona.save();
		callback(null,data)
	}

}

module.exports = GoalService;
