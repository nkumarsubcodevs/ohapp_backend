/** 
  * @desc this file will hold database connection code and status 
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file database.js
*/

const promise = require('bluebird');
const config   = require('./config');

var options = {
  promiseLib: promise
};

const pgp = require('pg-promise')(options);
var pg_cn = {
    host: config.postgres_host,
    port: config.postgres_port,
    database: config.postgres_database,
    user: config.postgres_username,
    password: config.postgres_password
};

let dbObj = pgp(pg_cn);

dbObj.connect()
.then(obj => {
    const serverVersion = obj.client.serverVersion;
    console.log('Database connected with PostgreSQL: '+serverVersion);
})
.catch(error => {
    console.log('Database Connection Error: ', error.message || error);
});

module.exports = dbObj;