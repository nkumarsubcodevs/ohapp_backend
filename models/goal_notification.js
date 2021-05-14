/** 
  * @desc this file will define the schema for note table
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file goal_notification.js
*/

const Sequelize = require('sequelize');
const database  = require('../config/database');

const GoalNotification = database.define('goal_notifications',
  {
	user_id: {
		type: Sequelize.BIGINT,
		allowNull: false,
    },
    goal_id: {
		type: Sequelize.BIGINT,
		allowNull: false,
    },
    device_id: {
        type: Sequelize.TEXT,
		allowNull: false,
    },
    notification_id: {
        type: Sequelize.TEXT,
		allowNull: true,
    },
    parent_notification_id: {
        type: Sequelize.BIGINT,
		allowNull: true,
    },
    answer: {
        type: Sequelize.TEXT,
		allowNull: true,
    },
    status: {
        type: Sequelize.BIGINT,
		allowNull: false,
    },
    stage: {
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

module.exports = GoalNotification;
