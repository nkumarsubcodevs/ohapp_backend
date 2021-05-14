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
const Sequelize = require('sequelize');
const Op = Sequelize.Op;
class subscripationService {
  // get all pages list
  async saveSubscripation(quickyData, callback) {

    const now = new Date();
    var date = new Date();
    let expiryDate;
    // =======================================start =========================
    if (quickyData.device_name == "ios") {
      iap.config({
        appleExcludeOldTransactions: true,
        applePassword: "1891906ec2a247fda3a41747cf8d6866",
      });
      iap.setup(function (error) {
        if (error) {
          console.log("Setup", error);
        }
        iap.validate(quickyData.receipt)
          .then((res) => {
            // var expiry = parseInt(res.expiryTimeMillis);
            // let new_expiry_date = new Date(expiry);

            let saverecord = new SubscripationObject({
              user_id: quickyData.user_id,
              partner_mapping_id: quickyData.partner_mapping_id,
              purchase_plan_id: quickyData.purchase_plan_id,
              amount: quickyData.amount,
              device_name: quickyData.device_name,
              subscripation_plan: quickyData.subscripation_plan,
              receipt: quickyData.receipt,
              status: 1,
              expiry_date: res.latest_receipt_info[0].expires_date.replace(' Etc/GMT', ''),
              create_time: current_datetime.format(now, "YYYY-MM-DD hh:mm:ss"),
              update_time: current_datetime.format(now, "YYYY-MM-DD hh:mm:ss"),

            })
            callback(null, saverecord.save());

          });
      })
    } else if (quickyData.device_name == "android") {
      const data = JSON.parse(quickyData.receipt);
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
            .then((res) => {

              var expiry = parseInt(res.expiryTimeMillis);
              console.log("expiry", expiry)
              let new_expiry_date = new Date(expiry);
              //expiryDate = new Date(res.expiryTimeMillis)
              let saverecord = new SubscripationObject({
                user_id: quickyData.user_id,
                partner_mapping_id: quickyData.partner_mapping_id,
                purchase_plan_id: quickyData.purchase_plan_id,
                amount: quickyData.amount,
                device_name: quickyData.device_name,
                subscripation_plan: quickyData.subscripation_plan,
                receipt: quickyData.receipt,
                status: 1,
                expiry_date: current_datetime.format(new_expiry_date, "YYYY-MM-DD hh:mm:ss"),
                create_time: current_datetime.format(now, "YYYY-MM-DD hh:mm:ss"),
                update_time: current_datetime.format(now, "YYYY-MM-DD hh:mm:ss"),
              });

              callback(null, saverecord.save());
            })
            .catch((err) => {
              callback(err, null)
            });
        })
        .catch((error) => {
          callback(error, null)
        });
    } else {

      callback("Device name is undefine", null);
    }
    // =======================================end =========================

  }
  //===================================================================================================================
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
            let exDate = response.latest_receipt_info[0].expires_date.replace(' Etc/GMT', '');
            let expiryDate = new Date(exDate).toISOString();
            const responseData = {
              status: response.status,
              message: null,
              data: {
                id: UserData.id,
                expire_at: expiryDate,
                status: "complated",
                created_at: response.receipt.receipt_creation_date,
                transaction_id:
                  response.pending_renewal_info[0].original_transaction_id,
                canceled_at: response.pending_renewal_info[0].userCancellationTimeMillis,
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
            .then((res) => {
              const responseData = {
                status: res.status,
                message: null,
                data: {
                  id: UserData.id,
                  expire_at: new Date(parseInt(res.expiryTimeMillis)),
                  status: "completed",
                  created_at: res.startTimeMillis,
                  transaction_id: res.kind,
                  canceled_at: new Date(parseInt(res.userCancellationTimeMillis)),
                },
              };
              callback(null, responseData);
            })
            .catch((err) => {
              callback(err, null)
            });
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
        where: { user_id: quickyData },
        order: [["create_time", "DESC"]],
      })
    );
  }

  // update stage
  async updateStage(updateStage, callback) {
    await SubscripationObject
      .update(
        {
          status: updateStage.status,
        },
        {
          where: {
            [Op.or]: [
              {
                user_id: {
                  [Op.eq]: updateStage.user_id,
                },
              },
            ],
          },
        }
      )
      .then((res) => {
        callback(null, res);
      })
      .catch((err) => {
        callback(err.message, null);
      });
  }
}

module.exports = subscripationService;
