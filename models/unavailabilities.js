/** 
  * @desc this file will define the schema for note table
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file unavailabilites.js
*/

const Sequelize = require('sequelize');
const database = require('../config/database');

const Unavailability = database.define('unavailabilities',
	{
		user_id: {
			type: Sequelize.BIGINT,
			allowNull: false,
		},
		unavailability_start: {
			type: Sequelize.DATE,
			allowNull: false,
		},
		unavailability_end: {
			type: Sequelize.DATE,
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

module.exports = Unavailability;
