/** 
  * @desc this file will define the schema for note table
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file notification.js
*/

const Sequelize = require('sequelize');
const database = require('../config/database');

const Message = database.define('notifications',
    {
        user_id: {
            type: Sequelize.BIGINT,
            allowNull: false,
        },
        quickey_id: {
            type: Sequelize.BIGINT,
            allowNull: false,
        },
        title: {
            type: Sequelize.TEXT,
            allowNull: false,
        },
        message: {
            type: Sequelize.TEXT,
            allowNull: false,
        },
        type: {
            type: Sequelize.BIGINT,
            allowNull: false,
        },
        status: {
            type: Sequelize.BIGINT,
            allowNull: false,
        },
        checkans: {
            type: Sequelize.TEXT,
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
