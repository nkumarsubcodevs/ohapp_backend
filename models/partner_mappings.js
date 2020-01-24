
/** 
  * @desc this file will define the schema for goal masters table
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file goal_masters.js
*/

const Sequelize = require('sequelize');
const database  = require('../config/database');

const PartnerMapping = database.define('partner_mappings',
  {
    partner_one_id: {
		type: Sequelize.BIGINT,
		allowNull: false,
	},
	partner_two_id: {
		type: Sequelize.BIGINT,
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

module.exports = PartnerMapping;