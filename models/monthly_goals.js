
/** 
  * @desc this file will define the schema for monthly goal table
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file monthly_goals.js
*/

const Sequelize = require('sequelize');
const database  = require('../config/database');

const MonthlyGoal = database.define('monthly_goals',
  {
	partner_id: {
		type: Sequelize.BIGINT,
		allowNull: false,
	},
	goal_title: {
		type: Sequelize.STRING(500),
		allowNull: true,
	},
	goal_description: {
		type: Sequelize.TEXT,
		allowNull: true,
	},
	month: {
		type: Sequelize.STRING(50),
		allowNull: true,
	},
	connect_number: {
		type: Sequelize.STRING(50),
		allowNull: true,
	},
	partner_one_initiator_count: {
		type: Sequelize.STRING(50),
		allowNull: true,
	},
	partner_one_percentage: {
		type: Sequelize.STRING(50),
		allowNull: true,
	},
	partner_one_complete_count: {
		type: Sequelize.STRING(50),
		allowNull: true,
	},
	partner_one_complete_percentage : {
		type: Sequelize.STRING(50),
		allowNull: true,
	},
	partner_two_initiator_count: {
		type: Sequelize.STRING(50),
		allowNull: true,
	},
	partner_two_percentage: {
		type: Sequelize.STRING(50),
		allowNull: true,
	},
	partner_two_complete_count: {
		type: Sequelize.STRING(50),
		allowNull: true,
	},
	partner_two_complete_percentage: {
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