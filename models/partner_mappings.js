
/** 
  * @desc this file will define the schema for goal masters table
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file partner_mappings.js
*/

const Sequelize = require('sequelize');
const database = require('../config/database');

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
		uniqe_id: {
			type: Sequelize.STRING,
			allowNull: true
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