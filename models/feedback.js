/** 
  * @desc this file will define the schema for note table
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file question_options.js
*/

const Sequelize = require('sequelize');
const database  = require('../config/database');

const feed_back = database.define('contact_us',
  {
	feedback_details: {
		type: Sequelize.TEXT,
		allowNull: false,
	},
	user_id: {
		type: Sequelize.BIGINT,
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

module.exports = feed_back;