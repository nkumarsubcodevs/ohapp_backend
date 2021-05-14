/** 
  * @desc this file will define the schema for note table
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file question_options.js
*/

const Sequelize = require('sequelize');
const database  = require('../config/database');

const question_options = database.define('Options',
  {
	title: {
		type: Sequelize.STRING(250),
		allowNull: false,
	},
	question_id: {
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

module.exports = question_options;
