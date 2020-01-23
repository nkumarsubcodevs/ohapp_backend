
/** 
  * @desc this file will define the schema for goal settings
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file goal_settings.js
*/

const Sequelize = require('sequelize');
const database  = require('../config/database');

const GoalSetting = database.define('goal_settings',
{
    question: {
		type: Sequelize.STRING(500),
		allowNull: false,
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

module.exports = GoalSetting;