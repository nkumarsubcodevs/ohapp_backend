
/** 
  * @desc this file will define the schema for monthly goal table
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file monthly_goals.js
*/

const Sequelize = require('sequelize');
const database  = require('../config/database');

const MonthlyGoal = database.define('monthly_goals',
  {
    his_id: {
		type: Sequelize.BIGINT,
		allowNull: false,
	},
	her_id: {
		type: Sequelize.BIGINT,
		allowNull: false,
    },
	goal_title: {
		type: Sequelize.STRING(500),
		allowNull: false,
	},
	goal_description: {
		type: Sequelize.TEXT,
		allowNull: false,
	},
	month: {
		type: Sequelize.STRING(50),
		allowNull: false,
	},
	connect_number: {
		type: Sequelize.STRING(50),
		allowNull: false,
		unique: true
	},
	his_initiator_count: {
		type: Sequelize.STRING(50),
		allowNull: false,
	},
	his_percentage: {
		type: Sequelize.STRING(50),
		allowNull: false,
	},
	his_complete_count: {
		type: Sequelize.STRING(50),
		allowNull: false,
	},
	his_complete_percentage : {
		type: Sequelize.STRING(50),
		allowNull: false,
	},
	her_initiator_count: {
		type: Sequelize.STRING(50),
		allowNull: false,
	},
	her_percentage: {
		type: Sequelize.STRING(50),
		allowNull: false,
	},
	her_complete_count: {
		type: Sequelize.STRING(50),
		allowNull: false,
	},
	her_complete_percentage: {
		type: Sequelize.STRING(50),
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

module.exports = MonthlyGoal;