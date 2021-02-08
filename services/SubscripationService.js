/**
 * @desc this service file will define all the functions related to the notes
 * @author Navneet Kumar navneet.kumar@subcodevs.com
 * @file subscripationService.js
 */

const SubscripationObject = require("../models/subscripation");
const current_datetime = require("date-and-time");
var iap = require("in-app-purchase");
const config = require('../config/config');
// const file = require("../oh-app-e402b-6cb90fac6f17.json");
const User = require("../models/user");
const now = new Date();
class subscripationService {
  // get all pages lists
  async saveSubscripation(quickyData, callback) {
    var date = new Date();
    if (
      quickyData.subscripation_plan == "com.oh.yearly" ||
      quickyData.subscripation_plan == "oneyear.subscription.oh.com" ||
      quickyData.subscripation_plan == "yearly"
    ) {
      date = current_datetime.addYears(now, 1);
    }  
    if (
      quickyData.subscripation_plan == "com.oh.monthly" ||
      quickyData.subscripation_plan == "monthly.subscription.oh.com" ||
      quickyData.subscripation_plan == "monthly"
    ) {
      date = current_datetime.addDays(now, 30);
    }
    console.log("curret subscription date", date);
    let saverecord = new SubscripationObject({
      user_id: quickyData.user_id,
      partner_mapping_id: quickyData.partner_mapping_id,
      purchase_plan_id: quickyData.purchase_plan_id,
      amount: quickyData.amount,
      device_name: quickyData.device_name,
      subscripation_plan: quickyData.subscripation_plan,
      receipt: quickyData.receipt,
      status: 1,
      expiry_date: date,
      create_time: current_datetime.format(now, "YYYY-MM-DD hh:mm:ss"),
      update_time: current_datetime.format(now, "YYYY-MM-DD hh:mm:ss"),
    });
    callback(null, await saverecord.save());
  }

  //get single page record
  async VerifyReceipt(UserData, callback) {
    if (UserData.device_name == "ios") {
      iap.config({
        appleExcludeOldTransactions: true,
        applePassword: "1891906ec2a247fda3a41747cf8d6866",
      });
      iap.setup(function (error) {
        if (error) {
          console.log("Setup", error);
        }
        iap.validate(UserData.receipt, function (error, response) {
          if (error) {
            callback(error, null);
          }
          if (iap.isValidated(response)) {
            const responseData = {
              status: response.status,
              message: null,
              data: {
                id: UserData.id,
                expire_at: response.latest_receipt_info[0].expires_date,
                status: "complated",
                created_at: response.receipt.receipt_creation_date,
                transaction_id:
                  response.pending_renewal_info[0].original_transaction_id,
                canceled_at: null,
              },
            };
            callback(null, responseData);
          }
        });
      });
    } else if (UserData.device_name == "android") {
    const data = JSON.parse(UserData.receipt);
      iap.config({
        googleServiceAccount: {
          clientEmail: config.client_email,
          privateKey: config.private_key
        },
      });
      const recipes = {
        packageName: data.packageName,
        productId: data.productId,
        purchaseToken: data.purchaseToken,
        subscription: true
    }
      iap
        .setup()
        .then(() => {
          iap
            .validate(recipes)
            .then((res) =>{
              const responseData = {
                status: res.status,
                message: null,
                data: {
                  id: UserData.id,
                  expire_at: res.expiryTimeMillis,
                  status: "completed",
                  created_at: res.startTimeMillis,
                  transaction_id:res.kind,
                  canceled_at: null,
                },
              };
              callback(null, responseData);
            })
            .catch((err)=> {
              callback(err, null)
            } );
        })
        .catch((error) => {
          callback(error, null)
        });
    } else {
     callback("Device name is undefine", null);
    }
  }

  //update page details
  async getSubscripation(quickyData, callback) {
    callback(
      null,
      await SubscripationObject.findOne({
        where: {user_id: quickyData},
        order: [["create_time", "DESC"]],
      })
    );
  }
}

module.exports = subscripationService;
