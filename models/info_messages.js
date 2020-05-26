/** 
  * @desc this file will define the schema for note table
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file info_messages.js
*/

const Sequelize = require('sequelize');
const database  = require('../config/database');

const info_messages = database.define('info_messages',
  {
	title: {
		type: Sequelize.STRING(250),
		allowNull: false,
	},
	key: {
		type: Sequelize.STRING(100),
		allowNull: false,
	},
	screen: {
		type: Sequelize.STRING(100),
		allowNull: false,
	},
	description: {
		type: Sequelize.TEXT,
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

module.exports = info_messages;
