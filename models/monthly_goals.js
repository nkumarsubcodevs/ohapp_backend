
/** 
  * @desc this file will define the schema for monthly goal table
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file monthly_goals.js
*/

const Sequelize = require('sequelize');
const database  = require('../config/database');

const MonthlyGoal = database.define('monthly_goals',
  {
	partner_mapping_id: {
		type: Sequelize.BIGINT,
		allowNull: false,
	},
	user_id: {
		type: Sequelize.BIGINT,
		allowNull: false,
	},
	goal_identifier: {
		type: Sequelize.BIGINT,
		allowNull: false,
	},
	month_start: {
		type: Sequelize.STRING(50),
		allowNull: true,
	},
	month_end: {
		type: Sequelize.STRING(50),
		allowNull: true,
	},
	connect_number: {
		type: Sequelize.STRING(50),
		allowNull: true,
	},
	initiator_count: {
		type: Sequelize.STRING(50),
		allowNull: true,
	},
	initiator_count1: {
		type: Sequelize.STRING(50),
		allowNull: true,
	},
	intimate_time: {
		type: Sequelize.STRING(50),
		allowNull: true,
	},
	intimate_request_time: {
		type: Sequelize.STRING(50),
		allowNull: true,
	},
	intimate_account_time: {
		type: Sequelize.STRING(50),
		allowNull: true,
	},
	// percentage: {
	// 	type: Sequelize.STRING(50),
	// 	allowNull: true,
	// },
	contribution1: {
		type: Sequelize.BIGINT,
		allowNull: false,
	},
	contribution2: {
		type: Sequelize.BIGINT,
		allowNull: false,
	},
	complete_count: {
		type: Sequelize.STRING(50),
		allowNull: true,
	},
    complete_percentage : {
		type: Sequelize.STRING(50),
		allowNull: true,
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

module.exports = MonthlyGoal;