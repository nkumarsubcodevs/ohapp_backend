/** 
  * @desc this file will define the schema for note table
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file subscripation.js
*/

const Sequelize = require('sequelize');
const database  = require('../config/database');

const subscripation = database.define('subscripations',
  {
	user_id: {
		type: Sequelize.BIGINT,
		allowNull: false,
	},
	partner_mapping_id: {
		type: Sequelize.BIGINT,
		allowNull: false,
	},
	device_name: {
		type: Sequelize.STRING(200),
		allowNull: true,
	},
	receipt: {
		type: Sequelize.TEXT,
		allowNull: true,
	},
	subscripation_plan: {
		type: Sequelize.STRING(200),
		allowNull: true,
	},
	expiry_date: {
		type: Sequelize.DATE,
		allowNull: true,
	},
	purchase_plan_id: {
		type: Sequelize.TEXT,
		allowNull: true,
	},
	amount: {
		type: Sequelize.BIGINT,
		allowNull: false,
	},
	status: {
		type: Sequelize.BIGINT,
		allowNull: true,
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

module.exports = subscripation;