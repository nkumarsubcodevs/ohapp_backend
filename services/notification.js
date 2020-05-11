
/** 
  * @desc this service file will define all the functions related to the goal
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file GoalService.js
*/

var FCM = require('fcm-node');
// Get API secret
const config = require('../config/config');

var fcm = new FCM(config.firebase_server_key);
class NotificationService
{
	async notification(userid, callback) {
		var message = { //this may vary according to the message type (single recipient, multicast, topic, et cetera)
			to: userid, 
			notification: {
				title: 'Dating reminder', 
				body: 'Do you want to set plan of dating for tonight' 
			},
			data: {  //you can send only notification or only data(or include both)
				my_key: 'my value',
				my_another_key: 'my another value'
			}
		};
		fcm.send(message, function(err, response){
			if (err) {
				console.log("Something has gone wrong!", err);
			} else {
				console.log("Successfully sent with response: ", response);
			}
		});
	}
}

module.exports = NotificationService;
