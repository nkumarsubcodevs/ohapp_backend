/** 
  * @desc this file will define the schema for note table
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file faq.js
*/

const Sequelize = require('sequelize');
const database = require('../config/database');

const faq = database.define('faqs',
    {
        title: {
            type: Sequelize.TEXT,
            allowNull: false,
        },
        description: {
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

module.exports = faq;