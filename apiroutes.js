/** 
  * @desc this file will contains all the routes for api
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file apiroutes.js
*/

const express   = require('express');
const apiRoutes = express();

const usersRoutes = require('./routes/api/users');
const noteRoutes = require('./routes/api/notes');
const patternRoutes = require('./routes/api/patterns');
const imagesRoutes = require('./routes/api/images');

// routes of users
apiRoutes.use('/users', usersRoutes);

// routes of notes
apiRoutes.use('/notes', noteRoutes);

//routes of pattern
apiRoutes.use('/patterns', patternRoutes);

//routes of images
apiRoutes.use('/images', imagesRoutes);

module.exports = apiRoutes;