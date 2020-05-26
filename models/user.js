
/** 
  * @desc this file will define the schema for user table
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file user.js
*/

const Sequelize = require('sequelize');
const database  = require('../config/database');

const User = database.define('users',
  {
    role_id: {
		type: Sequelize.BIGINT,
		allowNull: false,
    },
	first_name: {
		type: Sequelize.STRING(100),
		allowNull: false,
	},
	last_name: {
		type: Sequelize.STRING(100),
		allowNull: false,
	},
	gender: {
		type: Sequelize.STRING(50),
		allowNull: false,
	},
	email: {
		type: Sequelize.STRING(100),
		allowNull: false,
		unique: true
	},
	password: {
		type: Sequelize.STRING(100),
		allowNull: false,
	},
	profile_image: {
		type: Sequelize.STRING(100),
	},
	face_id: {
		type: Sequelize.STRING(250),
	},
	touch_id: {
		type: Sequelize.STRING(250),
	},
	access_token: {
		type: Sequelize.STRING(150),
	},
	unique_code: {
		type: Sequelize.STRING(150),
	},
	fcmid: {
		type: Sequelize.STRING(250),
	},
	device_name: {
		type: Sequelize.STRING(100),
		allowNull: true
	},
	receipt: {
		type: Sequelize.TEXT,
		allowNull: true
	},
	notification_mute_status: {
		type: Sequelize.INTEGER,
	},
	notification_mute_end: {
		type: Sequelize.DATE,
	},
	notification_mute_start: {
		type: Sequelize.DATE,
	},
	status: {
		type: Sequelize.INTEGER,
		allowNull: false,
	},
	stage: {
		type: Sequelize.INTEGER,
		allowNull: true,
		default: 1
	},
	expiry_time: {
		type: Sequelize.DATE,
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

module.exports = User;