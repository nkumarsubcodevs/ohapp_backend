/** 
  * @desc this file will define the function to check the user authentication and used as middlewear
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file index.js
*/

const express = require('express');
let router =  express.Router();

router.get('/', isLoggedIn, function(req, res){
  	res.render('pages/index');
});

function isLoggedIn(req, res, next){
	if(req.isAuthenticated()){
        next();
	}
	else{
        res.redirect("/users/login");
    }
}

module.exports = router;