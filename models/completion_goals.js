/** 
  * @desc this file will define the schema for note table
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file completion_goals.js
*/

const Sequelize = require('sequelize');
const database  = require('../config/database');

const completion_goals = database.define('completion_goals',
  {
	goal_id: {
		type: Sequelize.TEXT,
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
	didYouConnectLastNight: {
		type: Sequelize.BOOLEAN,
		allowNull: false,
	},
	WhoInitiative: {
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

module.exports = completion_goals;