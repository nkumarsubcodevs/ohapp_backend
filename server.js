/** 
  * @desc this file is the entry point for the application and contains all the major settings and dependency
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file server.js
*/

// Include all the required modules
const express     = require('express');
const path        = require('path');
const cookeParser = require('cookie-parser');
const bodyParser  = require('body-parser');
const ejs         = require('ejs');
const expressValidator = require('express-validator');
const flash = require('connect-flash');
const session  = require('express-session');
const passport = require('passport');
const LocalStrategy = require('passport-local').Strategy;

// To set different header in request
const helmet = require('helmet');
const cors   = require('cors');
const morgan = require('morgan');

// Include Routing File
const webRoutes = require('./webroutes');
const apiRoutes = require('./apiroutes');

// connect to database and config
const config = require('./config/config');
const dbObj  = require('./config/database');

const app  = express();

// Server Setup
const PORT = config.port_no;

// app cron job
const cronJob  = require('./cron_jobs/cron_jobs');

// chat system job
const chatHandler  = require('./chat_system/chat_handler');

app.use(express.static(__dirname + '/public'));

// Setup view templating
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');

// Setup body parser
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended: false}));
app.use(cookeParser());

// Setup session settings
app.use(session({
	secret: 'ohapp_admin',
	resave: true,
	saveUninitialized: true,
	cookie: { maxAge: 8*60*60*1000 },
}));

app.use(passport.initialize());
app.use(passport.session());

// Setup expressjs validatior
app.use(expressValidator());
app.use(flash());

// Setup flash message globally for the application 
app.use(function(req, res, next){
	res.locals.success_message = req.flash('success_message');
	res.locals.error_message = req.flash('error_message');
	res.locals.errors = req.flash('errors');
	res.locals.user = req.user || null;
  	next();
});

/* Web Routing */
app.use('/', webRoutes);  


/* API Routing */
app.use(helmet()); // security
app.use(cors()); // enabling CORS for all requests
// app.use(morgan('combined')); // adding morgan to log HTTP requests
app.use('/v1.0', apiRoutes); // mount all api routes

  
// Print port with application title on console on application startup
app.listen(PORT, function(){
	console.log('OH application running on port: ',PORT);
});
