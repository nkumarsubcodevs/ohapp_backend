/** 
  * @desc this file will hold database connection code and status 
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file database.js
*/

const Sequelize = require('sequelize');
const config   = require('./config');

const dbObj = new Sequelize(config.postgres_database, config.postgres_username, config.postgres_password, {
  host: config.postgres_host,
  dialect: 'postgres',
  logging: false,
  pool: {
      max: 5,
      min: 0,
      acquire: 30000,
      idle: 10000
  }
});

dbObj.authenticate().then(()=>{
    console.log('Database Connection has been established successfully with PostgreSQL.');
}).catch(error => {
    console.log('Unable to connect to the database:', error.message || error);
});

module.exports = dbObj;