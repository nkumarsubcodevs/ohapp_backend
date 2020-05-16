/** 
  * @desc this file will define the schema for note table
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file quicky.js
*/

const Sequelize = require('sequelize');
const database  = require('../config/database');

const quicky = database.define('quickies',
  {
	when: {
		type: Sequelize.STRING(200),
		allowNull: false,
	},
	where: {
		type: Sequelize.STRING(200),
		allowNull: false,
	},
	user_id: {
		type: Sequelize.BIGINT,
		allowNull: false,
	},
	partner_mapping_id: {
		type: Sequelize.BIGINT,
		allowNull: false,
	},
	partner_response: {
		type: Sequelize.BOOLEAN,
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

module.exports = quicky;