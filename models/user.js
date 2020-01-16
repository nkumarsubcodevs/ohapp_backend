
/** 
  * @desc this file will define the schema for user table
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file user.js
*/

const mongoose = require('mongoose');

let UserSchema = mongoose.Schema({
	name:{
		type: String,
		index: true,
  	},
  	email:{
		type: String,
		required: true
  	},
  	password:{
		type: String,
		required: true
	},
	bio:{
		type: String,
	}, 
	website:{
		type: String,
	}, 
	user_image:{
		type: String,
	}, 
	token_key:{
		type: String,
	},   
	role_id:{
		type: Number,
		required: true
	},
	status:{
		type: Number,
		required: true
	}    
});

module.exports = mongoose.model('User', UserSchema);