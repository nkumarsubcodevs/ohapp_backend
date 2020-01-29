/** 
  * @desc this file will hold all the common function for view/templating files
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file custom_helper.js
*/
const current_datetime = require('date-and-time');

var customHelper = {

	// get current date in timestamp
	h_getTodayDate() {

		var current_date = new Date();
		var dd = String(current_date.getDate()).padStart(2, '0');
		var mm = String(current_date.getMonth() + 1).padStart(2, '0');
		var yyyy = current_date.getFullYear();
		current_date = yyyy + '-' + mm + '-' + dd;

		return current_date;
	}, 

	// get current date in timestamp
	h_getTodayDateInTimeStamp() {

		var current_date = new Date();
		var dd = String(current_date.getDate()).padStart(2, '0');
		var mm = String(current_date.getMonth() + 1).padStart(2, '0');
		var yyyy = current_date.getFullYear();
		current_date = yyyy + '-' + mm + '-' + dd;

		var current_date    = new Date(current_date).getTime();

		return current_date;
	}, 

	// get number of times of percentage
	h_getNumberOfTimesPercentage(connect_number, percentage) {
		var initiator_count = Math.round((percentage*connect_number) / 100);
		return initiator_count;
	}, 

	// get current date in timestamp
	h_get30daysAdvanceDate(date_time) {
		var now = new Date();
		var today_date = new Date(current_datetime.format(now, 'YYYY-MM-DD'));
		today_date.setDate(today_date.getDate() + 30); 
		var final_date = today_date.toISOString().substr(0,10);
		return final_date;
	}, 

	// convert date and time in timestamp
	h_convertDateTimeInTimeStamp(date_time) {
		
		if(date_time)
		{
			var current_date = new Date(date_time.toISOString().substr(0,22));
		}
		else
		{
			var current_date = new Date();
		}
		
		var dd = String(current_date.getDate()).padStart(2, '0');
		var mm = String(current_date.getMonth() + 1).padStart(2, '0');
		var yyyy = current_date.getFullYear();

		var hour = String(current_date.getHours()).padStart(2, '0');
		var mins = String(current_date.getMinutes()).padStart(2, '0'); 
		var sece = String(current_date.getSeconds()).padStart(2, '0');

		current_date = yyyy + '-' + mm + '-' + dd +' '+ hour + ':' + mins + ':' + sece;
		return current_date;
	}, 
};

module.exports = customHelper;