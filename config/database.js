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


// const promise = require('bluebird');
// const config   = require('./config');

// var options = {
//   promiseLib: promise
// };

// const pgp = require('pg-promise')(options);
// var pg_cn = {
//     host: config.postgres_host,
//     port: config.postgres_port,
//     database: config.postgres_database,
//     user: config.postgres_username,
//     password: config.postgres_password
// };

// let dbObj = pgp(pg_cn);

// dbObj.connect()
// .then(obj => {
//     const serverVersion = obj.client.serverVersion;
//     console.log('Database connected with PostgreSQL: '+serverVersion);
// })
// .catch(error => {
//     console.log('Database Connection Error: ', error.message || error);
// });

module.exports = dbObj;