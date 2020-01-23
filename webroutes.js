/** 
  * @desc this file will contains all the routes for web
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file webroutes.js
*/


const express   = require('express');
const appRoutes = express();

const indexRoutes = require('./index');
const userRoutes  = require('./routes/web/users');
//const patternRoutes = require('./routes/web/patterns');

// routes of index
appRoutes.use('/', indexRoutes);

// routes of users
appRoutes.use('/users', userRoutes);

// routes of categories
//appRoutes.use('/patterns', patternRoutes);

module.exports = appRoutes;
