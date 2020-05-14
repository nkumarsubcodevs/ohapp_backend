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
const messageRoutes = require('./routes/api/messages');
const imagesRoutes = require('./routes/api/images');
const notificationRoute = require('./routes/api/notification');
const feedbackRoute = require('./routes/api/feedback');

// routes of users
apiRoutes.use('/users', usersRoutes);

// routes of notes
apiRoutes.use('/pages', pageRoutes);

//routes of pattern
apiRoutes.use('/goals', goalRoutes);

//routes of chat messages
apiRoutes.use('/messages', messageRoutes);

//routes of images
apiRoutes.use('/images', imagesRoutes);

//routes of notification
apiRoutes.use('/notification', notificationRoute);

//routes of notification
apiRoutes.use('/feedback', feedbackRoute);

module.exports = apiRoutes;