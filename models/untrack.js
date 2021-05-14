/** 
  * @desc this file will define the schema for goal settings
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file untrack.js
*/

const Sequelize = require('sequelize');
const database = require('../config/database');

const untrack = database.define('untracks',
    {
        user_id: {
            type: Sequelize.BIGINT,
            allowNull: false,
        },
        whoinitiative: {
            type: Sequelize.TEXT,
            allowNull: false,
        },
        createddate: {
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

module.exports = untrack;