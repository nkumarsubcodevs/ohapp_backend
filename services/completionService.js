
/** 
  * @desc this service file will define all the functions related to the goal
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file completionService.js
*/


const completion_goals  = require('../models/completion_goals');
const current_datetime = require('date-and-time');
const db = require('../config/database');
const Sequelize = require('sequelize');
const Op = Sequelize.Op

class completionService
{

	// Save Goal Setting
	async saveCompletionGoal(CompletionData, callback){

		const now = new Date();
		let settingData = new completion_goals({
			user_id: CompletionData.user_id,
			goal_id: CompletionData.goal_id,
			partner_mapping_id: CompletionData.partner_mapping_id,
			didYouConnectLastNight: CompletionData.didYouConnectLastNight,
			WhoInitiative: CompletionData.WhoInitiative,
			create_time: current_datetime.format(now, 'YYYY-MM-DD hh:mm:ss'),
			update_time: current_datetime.format(now, 'YYYY-MM-DD hh:mm:ss')
		});

		callback(null,await settingData.save());
	}
}

module.exports = completionService;
