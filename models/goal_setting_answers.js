
/** 
  * @desc this file will define the schema for goal settings answer
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file goal_setting_anwsers.js
*/

const Sequelize = require('sequelize');
const database  = require('../config/database');

const GoalSettingAnswer = database.define('goal_setting_answers',
{
	goal_id: {
		type: Sequelize.BIGINT,
		allowNull: false,
	},
	question_id: {
		type: Sequelize.BIGINT,
		allowNull: false,
	},
	user_id: {
		type: Sequelize.BIGINT,
		allowNull: false,
	},
	patner_mapping_id: {
		type: Sequelize.BIGINT,
		allowNull: false,
	},
    answer: {
		type: Sequelize.TEXT,
		allowNull: false,
	},
	custom_answer: {
		type: Sequelize.TEXT,
		allowNull:true
	},
	status: {
		type: Sequelize.INTEGER,
		allowNull: false,
	},
	create_time: {
		type: Sequelize.DATE,
		allowNull: false,
	},
	update_time: {
		type: Sequelize.DATE,
		allowNull: false,
	},
},
  { timestamps: false }
);

module.exports = GoalSettingAnswer;