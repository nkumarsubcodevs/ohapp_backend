/** 
  * @desc this file will verify the auth token
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file verifytoken.js
*/

const jwt      = require('jsonwebtoken');
const config   = require('../../config/config');

function verifyToken(req, res, next) 
{
	var token = req.headers['x-access-token'];
	
	if(!token) 
	{
		return res.send({
			status: 401,
			message: 'No token provided.',
			auth: false
		});
	}
	  		
	jwt.verify(token, config.secret, function(err, decoded) {
		
		if(err)
		{
			res.send({
				status: 500,
				message: 'Failed to authenticate token.',
				auth: false
			});
		}
		else
		{
			 // if everything good, save to request for use in other routes
			 req.id = decoded.id;
			 next();
		}
	});
}
  
module.exports = verifyToken;