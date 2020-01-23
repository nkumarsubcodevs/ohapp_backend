/** 
  * @desc this file will contains all the routes for api
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file apiroutes.js
*/

const express   = require('express');
const apiRoutes = express();

const usersRoutes = require('./routes/api/users');
const pageRoutes = require('./routes/api/pages');
const goalRoutes = require('./routes/api/goals');
const imagesRoutes = require('./routes/api/images');

// routes of users
apiRoutes.use('/users', usersRoutes);

// routes of notes
apiRoutes.use('/pages', pageRoutes);

//routes of pattern
apiRoutes.use('/goals', goalRoutes);

//routes of images
apiRoutes.use('/images', imagesRoutes);

module.exports = apiRoutes;