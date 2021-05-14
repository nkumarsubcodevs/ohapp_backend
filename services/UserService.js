/**
 * @desc this service file will define all the functions related to the user
 * @author Navneet Kumar navneet.kumar@subcodevs.com
 * @file UserService.js
 */

const userObject = require("../models/user");
const unavailabilityObject = require("../models/unavailabilities");
const partnerMappingObject = require("../models/partner_mappings");
const monthlyGoalObject = require("../models/monthly_goals");
const dbObj = require("../config/database");
const config = require("../config/config");
const bcrypt = require("bcryptjs");
const current_datetime = require("date-and-time");
const jwt = require("jsonwebtoken");
const randomstring = require("randomstring");
const fs = require("fs");
const nodemailer = require("nodemailer");
const handlebars = require("handlebars");
const Sequelize = require("sequelize");
const Op = Sequelize.Op;
var iap = require("in-app-purchase");
const sgMail = require("@sendgrid/mail");
sgMail.setApiKey(config.send_grid_api_key);
class UserService {
  // Generate unique code
  async generateUniqueCode() {
    var u_code = randomstring.generate({
      length: 4,
      charset: "alphabetic",
      capitalization: "uppercase",
    });

    const user = await userObject.findOne({ where: { unique_code: u_code } });

    if (user) {
      return this.generateUniqueCode();
    } else {
      return u_code;
    }
  }

  // ReGenerate unique code
  async reGenerateUniqueCode(user_id, callback) {
    var u_code = randomstring.generate({
      length: 4,
      charset: "alphabetic",
      capitalization: "uppercase",
    });
    const user = await userObject.findOne({ where: { unique_code: u_code } });
    if (user) {
      return this.reGenerateUniqueCode(user_id);
    } else {
      await userObject.update({ unique_code: u_code }, { where: { id: user_id } });
      this.getUserById(user_id, function (err, updatedData) {
        if (updatedData) {
          callback(null, updatedData);
        }
      });
    }
  }

  async createUser(newUser, callback) {
    const u_code = await this.generateUniqueCode();

    if (u_code) {
      const now = new Date();
      var user_password = randomstring.generate({
        length: 6,
        charset: "alphabetic",
        capitalization: "uppercase",
      });


      let userData = new userObject({
        role_id: newUser.role_id,
        first_name: newUser.first_name,
        last_name: newUser.last_name,
        gender: newUser.gender,
        email: newUser.email.toLowerCase(),
        password: user_password,
        unique_code: u_code,
        status: newUser.status,
        create_time: current_datetime.format(now, "YYYY-MM-DD hh:mm:ss"),
        update_time: current_datetime.format(now, "YYYY-MM-DD hh:mm:ss"),
      });
      bcrypt.genSalt(10, function (err, salt) {
        bcrypt.hash(userData.password, salt, function (err, hash) {
          userData.password = hash;
          var readHTMLFile = function (path, callback) {
            fs.readFile(path, { encoding: "utf-8" }, function (err, html) {
              if (err) {
                throw err;
                callback(err);
              } else {
                callback(null, html);
              }
            });
          };

          readHTMLFile(config.signup_template, function (err, html) {
            var template = handlebars.compile(html);
            var replacements = {
              username: newUser.first_name,
              user_email: newUser.email,
              user_password: user_password,
              site_logo: config.signUp_Template_Image,
            };
            var htmlToSend = template(replacements);
            let mailOptions = {
              to: newUser.email,
              from: "OH Team <" + config.from_email + ">",
              subject: "Login details for Oh! App",
              html: htmlToSend,
            };
            sgMail
              .send(mailOptions)
              .then((res) => {
                console.log("Email is sent successfully..!");
              })
              .catch((error) => {
                console.error("...", error);
              });
            //*******  Email Code
            userData.save().then(function (saveData) {
              callback(null, saveData);
            });
          });
        });
      });
    }
  }



  // get user by email
  async getUserByEmail(email, callback) {
    const user = await userObject.findOne({
      where: { email: email.toLowerCase() },
    });
    callback(null, user);
  }

  // check unique code of the user
  async checkUniqueCode(u_code, callback) {
    const unique_code = await userObject.findOne({
      where: { unique_code: u_code },
    });
    callback(null, unique_code);
  }

  // compare password
  async comparePassword(password, hash, callback) {
    bcrypt.compare(password, hash, function (err, isMatch) {
      if (err) throw err;
      callback(null, isMatch);
    });
  }

  // get user by id
  async getUserById(id, callback) {
    const response = await userObject.findOne({ where: { id: id } });
    callback(null, response);
  }

  // get partner by id
  async getPartnerById(id, callback) {
    var partner_id = 0;
    const partnerResponse = await partnerMappingObject.findAll({
      where: {
        [Op.or]: [
          {
            partner_one_id: {
              [Op.eq]: id,
            },
          },
          {
            partner_two_id: {
              [Op.eq]: id,
            },
          },
        ],
        [Op.and]: [
          {
            status: {
              [Op.eq]: 1,
            },
          },
        ],
      },
    });
    if (partnerResponse[0].partner_one_id == id) {
      partner_id = partnerResponse[0].partner_two_id;
    }

    if (partnerResponse[0].partner_two_id == id) {
      partner_id = partnerResponse[0].partner_one_id;
    }
    const response = await userObject.findOne({ where: { id: partner_id } });
    callback(null, response, partnerResponse[0]);
  }

  // send forgot password email
  async sendForgotEmail(userData, callback) {
    var new_password = randomstring.generate({
      length: 6,
      charset: "alphabetic",
      capitalization: "uppercase",
    });
    var user_detail = await userObject.findOne({
      where: { email: userData.email },
    });


    var readHTMLFile = function (path, callback) {
      fs.readFile(path, { encoding: "utf-8" }, function (err, html) {
        if (err) {
          throw err;
          callback(err);
        } else {
          callback(null, html);
        }
      });
    };

    readHTMLFile(config.forgot_password_template, function (err, html) {
      var template = handlebars.compile(html);
      var replacements = {
        username: user_detail.first_name,
        user_email: user_detail.email,
        new_password: new_password,
        site_url: config.site_url,
        site_logo: config.site_logo,
      };
      var htmlToSend = template(replacements);
      var mailOptions = {
        from: "OH Team<" + config.from_email + ">",
        to: userData.email,
        subject: "Password for Oh! App",
        html: htmlToSend,
      };

      sgMail
        .send(mailOptions)
        .then((res) => {
          console.log("Email is sent successfully..!");
        })
        .catch((error) => {
          console.error("...", error);
        });
    });

    bcrypt.genSalt(10, function (err, salt) {
      bcrypt.hash(new_password, salt, function (err, hash) {
        const now = new Date();
        callback(
          null,
          userObject.update(
            {
              password: hash,
              update_time: current_datetime.format(now, "YYYY-MM-DD hh:mm:ss"),
            },
            { where: { email: userData.email } }
          )
        );
      });
    });
  }


  // update user profile
  async updateUserProfile(userData, callback) {
    const now = new Date();
    userObject
      .update(
        {
          first_name: userData.first_name,
          last_name: userData.last_name,
          update_time: current_datetime.format(now, "YYYY-MM-DD hh:mm:ss"),
        },
        { where: { id: userData.user_id } }
      )
      .then(async (res) => {
        callback(null, await userObject.findOne({ where: { id: userData.user_id } }));
      })
      .catch((err) => {
        callback(err.message, null);
      });
  }

  // update user fcmid
  async updateUserFcmID(userFcmIDData, callback) {
    const now = new Date();
    callback(
      null,
      userObject.update(
        {
          fcmid: userFcmIDData.fcmid,
          update_time: current_datetime.format(now, "YYYY-MM-DD hh:mm:ss"),
        },
        { where: { id: userFcmIDData.user_id } }
      )
    );
  }

  // update user profile image
  async updateProfileImage(userImage, callback) {
    const now = new Date();
    callback(
      null,
      userObject.update(
        {
          profile_image: userImage.upload_file,
          update_time: current_datetime.format(now, "YYYY-MM-DD hh:mm:ss"),
        },
        { where: { id: userImage.user_id } }
      )
    );
  }

  // update user password
  async updateUserPassword(userDataUpdate, callback) {
    bcrypt.genSalt(10, function (err, salt) {
      bcrypt.hash(userDataUpdate.new_password, salt, function (err, hash) {
        const now = new Date();
        callback(
          null,
          userObject.update(
            {
              password: hash,
              update_time: current_datetime.format(now, "YYYY-MM-DD hh:mm:ss"),
            },
            { where: { id: userDataUpdate.user_id } }
          )
        );
      });
    });
  }

  //to  show list of users
  async getuserList(paginationData, callback) {
    const response = await userObject.findAndCountAll({
      offset: paginationData.offset,
      limit: paginationData.limit,
    });
    callback(null, response);
  }

  // Search User for Admin Panel
  async getusersearchList(paginationData, callback) {
    const response = await userObject.findAndCountAll({
      where: { first_name: paginationData.name },
      offset: paginationData.offset,
      limit: paginationData.limit,
    });
    callback(null, response);
  }

  // Count Total no. of user for Admin panel
  async getuserCount(callback) {
    const response = await userObject.findAndCountAll();
    callback(null, response);
  }

  // Update User status for Admin panel
  async updateUserStatus(status, id, callback) {
    await userObject.update({ status: status }, { where: { id: id } });
    const response = await userObject.findOne({ where: { id: id } });
    if (response.status == status) {
      return callback(null, response);
    } else {
      return this.updateUserStage(status, id, callback);
    }
  }

  // Update stage value
  async updateUserStage(stage, id, callback) {
    await userObject.update({ stage: stage }, { where: { id: id } });
    const response = await userObject.findOne({ where: { id: id } });
    if (response.stage == stage) {
      return callback(null, response);
    } else {
      return this.updateUserStage(stage, id, callback);
    }
  }

  async updatePaymentStage(stage, id, callback) {
    await userObject.update({ paymentStage: stage }, { where: { id: id } });
    const response = await userObject.findOne({ where: { id: id } });
    if (response.paymentStage == stage) {
      return callback(null, response);
    } else {
      return this.updatePaymentStage(stage, id, callback);
    }
  }

  // Update stage value for Both partner
  async updateBothPartnerStage(updatedData, callback) {
    // await userObject.update({ stage: updatedData.stage }, { where: { id: updatedData.user_id}});
    // const response = await userObject.findOne({ where: { id: id } });
    // if(response.stage == stage) {
    // 	return callback(null, response)
    // } else {
    // 	return this.updateUserStage(stage, id, callback)
    // }
    await userObject
      .update(
        {
          stage: updatedData.stage,
        },
        {
          where: {
            [Op.or]: [
              {
                id: {
                  [Op.eq]: updatedData.user_id,
                },
              },
              {
                id: {
                  [Op.eq]: updatedData.partner_id,
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
  async updateBothPartnerStageByFaild(updatedData, callback) {
    await userObject
      .update(
        {
          stage: updatedData.stage,
        },
        {
          where: {
            [Op.or]: [
              {
                id: {
                  [Op.eq]: updatedData.user_id,
                },
              },
              {
                id: {
                  [Op.eq]: updatedData.partner_id,
                },
              },
            ],
            [Op.and]: [
              {
                stage: {
                  [Op.eq]: updatedData.removeStage,
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
  // add unavailabilityddd
  async addUnavailability(userData, callback) {
    const now = new Date();

    let userDataEntry = new unavailabilityObject({
      user_id: userData.user_id,
      unavailability_start: userData.unavailability_start,
      unavailability_end: userData.unavailability_end,
      status: 1,
      create_time: current_datetime.format(now, "YYYY-MM-DD hh:mm:ss"),
      update_time: current_datetime.format(now, "YYYY-MM-DD hh:mm:ss"),
    });

    callback(null, userDataEntry.save());
  }

  // free security codes
  async freeSecurityCodes(freeData, callback) {
    const now = new Date();
    userObject.update({ unique_code: "" }, { where: { id: freeData.partner_one_id } });
    callback(null, userObject.update({ unique_code: "" }, { where: { id: freeData.partner_two_id } }));
  }

  // get user list for cron job.
  async getCronJobUserList(callback) {
    const userlist = await userObject.findAll({
      where: { unique_code: { [Op.ne]: "" }, role_id: 2, status: 1 },
    });
    callback(null, userlist);
  }

  // free security codes for cron
  async freeSecurityCodesForCron(userData, callback) {
    const now = new Date();
    callback(
      null,
      userObject.update(
        {
          unique_code: "",
          update_time: current_datetime.format(now, "YYYY-MM-DD hh:mm:ss"),
        },
        { where: { id: userData.user_id } }
      )
    );
  }

  // Remove Parring
  async RemoveParring(userId, callback) {
    const unparing = await partnerMappingObject.destroy({
      where: {
        [Op.or]: [
          {
            partner_one_id: {
              [Op.eq]: userId,
            },
          },
          {
            partner_two_id: {
              [Op.eq]: userId,
            },
          },
        ],
      },
    });
    callback(null, unparing);
  }

  // Remove Monthly Goal
  async RemoveMonthlyGoal(userID, patner_id, callback) {
    const unparing = await monthlyGoalObject.destroy({
      where: {
        [Op.or]: [
          {
            user_id: {
              [Op.eq]: userID,
            },
          },
          {
            user_id: {
              [Op.eq]: patner_id,
            },
          },
        ],
      },
    });
    callback(null, unparing);
  }

  // Remove User Account
  async RemoveAccount(userId, callback) {
    let removeUser = await userObject.destroy({
      where: {
        id: userId,
      },
    });
    callback(null, removeUser);
  }

  // Update Subscripation Plan
  async UpdateSubscripation(UpdateData, callback) {
    const now = new Date();
    var date = new Date();
    let expiryDate;
    // =======================================start =========================
    if (UpdateData.device_name == "ios") {
      iap.config({
        appleExcludeOldTransactions: true,
        applePassword: "1891906ec2a247fda3a41747cf8d6866",
      });
      iap.setup(function (error) {
        if (error) {
          console.log("Setup", error);
        }
        iap.validate(UpdateData.receipt)
          .then((res) => {

            userObject
              .update(
                {
                  device_name: UpdateData.device_name,
                  receipt: UpdateData.receipt,
                  expiry_time: res.latest_receipt_info[0].expires_date.replace(' Etc/GMT', ''),
                  update_time: current_datetime.format(now, "YYYY-MM-DD hh:mm:ss"),
                },
                { where: { id: UpdateData.user_id } }
              )
              .then(async (res) => {
                let response = await userObject.findOne({
                  where: { id: UpdateData.user_id },
                });

                callback(null, response);
              })
              .catch((err) => {
                callback(err.message, null);
              });
          })
      })
    } else if (UpdateData.device_name == "android") {
      const data = JSON.parse(UpdateData.receipt);
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
              let new_expiry_date = new Date(expiry);
              userObject
                .update(
                  {
                    device_name: UpdateData.device_name,
                    receipt: UpdateData.receipt,
                    expiry_time: current_datetime.format(new_expiry_date, "YYYY-MM-DD hh:mm:ss"),
                    update_time: current_datetime.format(now, "YYYY-MM-DD hh:mm:ss"),
                  },
                  { where: { id: UpdateData.user_id } }
                )
                .then(async (res) => {
                  let response = userObject.findOne({
                    where: { id: UpdateData.user_id },
                  });
                  callback(null, response);
                })
                .catch((err) => {
                  callback(err.message, null);
                });
            })
        })
        .catch((error) => {
          callback(error, null)
        });
    } else {
      callback("Something went wrong", null);
    }

  }

  // Update Notification mute data
  async UpdateNotificationMuteData(UpdatedData, callback) {
    await userObject
      .update(
        {
          notification_mute_end: UpdatedData.end_time,
          notification_mute_start: UpdatedData.start_time,
          notification_mute_status: UpdatedData.mute_status,
        },
        {
          where: {
            [Op.or]: [
              {
                id: {
                  [Op.eq]: UpdatedData.user_id,
                },
              },
              {
                id: {
                  [Op.eq]: UpdatedData.partner_id,
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

  // Update Notification mute Status
  async UpdateNotificationStatus(UpdatedData, callback) {
    await userObject
      .update(
        {
          notification_mute_status: UpdatedData.status,
        },
        {
          where: {
            [Op.or]: [
              {
                id: {
                  [Op.eq]: UpdatedData.user_id,
                },
              },
              {
                id: {
                  [Op.eq]: UpdatedData.partner_id,
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

module.exports = UserService;
