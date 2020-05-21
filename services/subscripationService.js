
/** 
  * @desc this service file will define all the functions related to the notes
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file subscripationService.js
*/

const SubscripationObject = require('../models/subscripation');
const current_datetime = require('date-and-time');
var iap = require('in-app-purchase');

const now = new Date();
class subscripationService
{
	// get all pages list
	async saveSubscripation(quickyData, callback){
		var date = new Date();
        if(quickyData.subscripation_plan == "yearly") {
			date = current_datetime.addYears(now, 1);
        }
        if(quickyData.subscripation_plan == "monthly") {
			date = current_datetime.addDays(now, 30);
        }
		let saverecord = new SubscripationObject({
			user_id: quickyData.user_id,
			partner_mapping_id: quickyData.partner_mapping_id,
			purchase_plan_id: quickyData.purchase_plan_id,
			amount: quickyData.amount,
			device_name: quickyData.device_name,
			subscripation_plan: quickyData.subscripation_plan,
			receipt: quickyData.receipt,
			status:1,
			expiry_date: date,
			create_time: current_datetime.format(now, 'YYYY-MM-DD hh:mm:ss'),
			update_time: current_datetime.format(now, 'YYYY-MM-DD hh:mm:ss')
		})
		callback(null,await saverecord.save());
	}

	//get single page record
	async VerifyReceipt(UserData, callback) {
		if(UserData.device_name == "apple") {
            iap.config({
              applePassword: ''
            });
            iap.setup(function (error) {
              if (error) {
               console.log("Setup", error)
              }
              iap.validate(UserData.receipt, function (error, response) {
                if (error) {

                  console.log("Error", error.message)
                }
                if (iap.isValidated(response)) {
                   console.log("Validated", response)
                }
              });
            });
          } else if(UserData.device_name == "goole"){

          } else {
            console.log('Invalid res', UserData)
          }
	}

	//update page details
	async getSubscripation(quickyData, callback){
		callback(null, await SubscripationObject.findOne({where: {user_id: quickyData }, order: [['create_time', 'DESC']] }))
	}
}

module.exports = subscripationService;




