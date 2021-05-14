/** 
  * @desc this file will define the schema for chat message table
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file messages.js
*/

const Sequelize = require('sequelize');
const database  = require('../config/database');

const Message = database.define('chat_messages',
  {
	goal_id: {
		type: Sequelize.BIGINT,
		allowNull: false,
	},
	sender_id: {
		type: Sequelize.BIGINT,
		allowNull: false,
	},
	receiver_id: {
		type: Sequelize.BIGINT,
		allowNull: false,
    },
	message: {
		type: Sequelize.TEXT,
		allowNull: false,
	},
	chat_status_id: {
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

module.exports = Message;
