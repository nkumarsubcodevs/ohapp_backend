/** 
  * @desc this file will define the schema for note table
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file faqlink.js
*/

const Sequelize = require('sequelize');
const database = require('../config/database');

const faqlink = database.define('faqlinks',
    {
        title: {
            type: Sequelize.TEXT,
            allowNull: false,
        },
        link: {
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

module.exports = faqlink;