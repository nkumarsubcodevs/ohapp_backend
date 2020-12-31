/**
 * @desc this service file will define all the functions related to the goal
 * @author Navneet Kumar navneet.kumar@subcodevs.com
 * @file GoalService.js
 */

const goalSettingsObject = require("../models/goal_settings");
const goalSettingAnswerObject = require("../models/goal_setting_answers");
const partnerMappingObject = require("../models/partner_mappings");
const monthlyGoalObject = require("../models/monthly_goals");
const questionOptionsObject = require("../models/question_options");
const userObject = require("../models/user");
const current_datetime = require("date-and-time");
const db = require("../config/database");
const Sequelize = require("sequelize");
const Op = Sequelize.Op;

class GoalService {
  // get goal setting
  async getGoalSettings(callback) {
    goalSettingsObject.hasMany(questionOptionsObject, {
      foreignKey: "question_id",
    });
    const goal_settings = await goalSettingsObject.findAll({
      include: [
        {
          model: questionOptionsObject,
        },
      ],
      order: [["id", "ASC"]],
    });
    callback(null, goal_settings);
  }
  // get all pages list
  async getQuestion(paginationData, callback) {
    const response = await goalSettingsObject.findAndCountAll({
      offset: paginationData.offset,
      limit: paginationData.limit,
    });
    callback(null, response);
  }

  // Count Total Question
  async getQuestionCount(callback) {
    const response = await goalSettingsObject.findAndCountAll();
    callback(null, response);
  }

  // Get Single question
  async GetQuestion(question_id, callback) {
    const response = await goalSettingsObject.findAll({
      where: { id: question_id },
    });
    callback(null, response);
  }

  //get single question record
  async getSingleQuestionRecord(question_id, callback) {
    goalSettingsObject.hasMany(questionOptionsObject, {
      foreignKey: "question_id",
    });
    const response = await goalSettingsObject.findAll({
      where: { id: question_id },
    });
    callback(null, response);
  }

  // Get Goal Setting Answer
  async getGoalSettingsAnswer(user_id, callback) {
    goalSettingsObject.hasMany(questionOptionsObject, {
      foreignKey: "question_id",
    });
    goalSettingAnswerObject.belongsTo(goalSettingsObject, {
      foreignKey: "question_id",
    });
    const goal_settings = await goalSettingAnswerObject.findAll({
      include: [
        {
          model: goalSettingsObject,
          include: [
            {
              model: questionOptionsObject,
            },
          ],
        },
      ],
      where: { user_id: user_id },
    });
    callback(null, goal_settings);
  }

  // get goal by id
  async getGoalById(id, callback) {
    const response = await monthlyGoalObject.findOne({ where: { id: id } });
    callback(null, response);
  }

  // get goal by partner_id
  async getAllGoalsByPartnerID(partner_id, callback) {
    const response = await monthlyGoalObject.findAll({
      where: { partner_mapping_id: partner_id, status: 1 },
    });
    callback(null, response);
  }

  // get goal by partner mappingid
  async getAllGoalsByPartnerMappingID(id, callback) {
    const response = await monthlyGoalObject.findOne({
      where: { partner_mapping_id: id, status: 1 },
      order: [["create_time", "DESC"]],
    });

    callback(null, response);
  }

  // Get Goal by user id
  async getGoalByUserId(user_id, callback) {
    const response = await monthlyGoalObject.findOne({
      where: { user_id: user_id, status: 1 },
      order: [["create_time", "DESC"]],
    });
    callback(null, response);
  }

  // get user combination
  async checkParterLink(partnerData, callback) {
    const response = await partnerMappingObject.findOne({
      where: {
        partner_one_id: partnerData.partner_one_id,
        partner_two_id: partnerData.partner_two_id,
      },
    });
    callback(null, response);
  }

  // get setting question by id
  async getGoalSettingsQuestionById(id, callback) {
    const response = await goalSettingsObject.findOne({ where: { id: id } });

    callback(null, response);
  }

  // Get setting question by patner mapping id
  async getGoalSettingByPatnerMappingId(id, question_id, callback) {
    const response = await goalSettingAnswerObject.findOne({
      where: { patner_mapping_id: id, question_id: question_id },
    });
    callback(null, response);
  }

  // update setting answer quetion
  async updatesetting(updatedData, callback) {
    const now = new Date();
    await goalSettingAnswerObject
      .update(
        {
          // goal_id: updatedData.goal_id,
          question_id: updatedData.question_id,
          answer: updatedData.answer,
          user_id: updatedData.user_id,
          // patner_mapping_id: updatedData.patner_mapping_id,
          custom_answer: updatedData.custom_answer,
          status: 1,
          update_time: current_datetime.format(now, "YYYY-MM-DD hh:mm:ss"),
        },
        { where: { id: updatedData.id } }
      )
      .then(async (res) => {
        let response = await goalSettingAnswerObject.findOne({
          where: { id: updatedData.id },
        });
        callback(null, response);
      })
      .catch((err) => {
        callback(err.message, null);
      });
  }
  // Save Goal Setting
  async saveSettings(goalSettingData, callback) {
    const fetch = await goalSettingAnswerObject.findAll({
      where: {
        question_id: goalSettingData.question_id,
        user_id: goalSettingData.user_id,
      },
    });
    const now = new Date();
    let settingData;
    if (fetch.length) {
      settingData = await goalSettingAnswerObject.update(
        {
          question_id: goalSettingData.question_id,
          answer: goalSettingData.answer,
          user_id: goalSettingData.user_id,
          custom_answer: goalSettingData.custom_answer,
          status: 1,
          update_time: current_datetime.format(now, "YYYY-MM-DD hh:mm:ss"),
        },
        {
          where: {
            question_id: goalSettingData.question_id,
            user_id: goalSettingData.user_id,
          },
        }
      );
      let response = await goalSettingAnswerObject.findOne({
        where: {
          question_id: goalSettingData.question_id,
          user_id: goalSettingData.user_id,
        },
      });
      callback(null, response);
    } else {
      settingData = new goalSettingAnswerObject({
        question_id: goalSettingData.question_id,
        answer: goalSettingData.answer,
        user_id: goalSettingData.user_id,
        custom_answer: goalSettingData.custom_answer,
        status: 1,
        create_time: current_datetime.format(now, "YYYY-MM-DD hh:mm:ss"),
        update_time: current_datetime.format(now, "YYYY-MM-DD hh:mm:ss"),
      });
      let saveResponse = await settingData.save();
      callback(null, saveResponse);
    }
  }

  // Create partner mapping
  async createPartnerMapping(partnerData, callback) {
    const now = new Date();
    let monthlyGoalData = new partnerMappingObject({
      partner_one_id: partnerData.partner_one_id,
      partner_two_id: partnerData.partner_two_id,
      status: 1,
      create_time: current_datetime.format(now, "YYYY-MM-DD hh:mm:ss"),
      update_time: current_datetime.format(now, "YYYY-MM-DD hh:mm:ss"),
    });

    callback(null, monthlyGoalData.save());
  }

  // get partner mapping by id
  async getPartnerById(id, callback) {
    // const response = await partnerMappingObject.findOne({ where: { id: id } });
    var partner_id = 0;
    const partnerResponse = await partnerMappingObject.findOne({
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
    callback(null, partnerResponse);
  }

  // Check for patner stage
  async checkParternstage(id, callback) {
    const partnerResponse = await partnerMappingObject.findOne({
      where: {
        [Op.or]: [
          {
            partner_one_id: {
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
    callback(null, partnerResponse);
  }

  // get partner data by id
  async getPartnerData(id, callback) {
    const partnerResponse = await partnerMappingObject.findOne({
      where: { partner_one_id: id },
    });
    console.log("partnerResponse", partnerResponse);
    callback(null, partnerResponse);
  }

  // Create monthly goal
  async createMonthlyGoal(monthlyGoalData, callback) {
    const now = new Date();
    const random_number = now.getTime() + Math.floor(Math.random() * 1000);
    let GoalData = new monthlyGoalObject({
      partner_mapping_id: monthlyGoalData.partner_mapping_id,
      user_id: monthlyGoalData.user_id,
      goal_identifier: random_number,
      month_start: monthlyGoalData.month_start,
      month_end: monthlyGoalData.month_end,
      connect_number: monthlyGoalData.connect_number,
      initiator_count: monthlyGoalData.initiator_count,
      initiator_count1: monthlyGoalData.initiator_count1,
      intimate_time: monthlyGoalData.intimate_time,
      intimate_request_time: monthlyGoalData.intimate_request_time,
      intimate_account_time: monthlyGoalData.intimate_account_time,
      percentage: monthlyGoalData.percentage,
      complete_count: 0,
      complete_percentage: 0,
      contribution1: 0,
      contribution2: 0,
      status: 1,
      hours: monthlyGoalData.hours,
      create_time: current_datetime.format(now, "YYYY-MM-DD hh:mm:ss"),
      update_time: current_datetime.format(now, "YYYY-MM-DD hh:mm:ss"),
    });
    await GoalData.save()
      .then((res) => {
        callback(null, res);
      })
      .catch((err) => {
        console.log(err);
        callback(err.message, null);
      });
  }

  // check Monthly Goal created or not
  async checkGoalCreated(partner_mapping_id, callback) {
    const now = new Date();
    const today = current_datetime.format(now, "YYYY-MM-DD hh:mm:ss");
    monthlyGoalObject.belongsTo(userObject, { foreignKey: "user_id" });
    const response = await monthlyGoalObject.findAll({
      where: {
        partner_mapping_id: partner_mapping_id,
        status: 1,
        month_end: { [Op.gt]: today },
      },
      include: [
        {
          model: userObject,
          attributes: [
            "id",
            "role_id",
            "first_name",
            "last_name",
            "gender",
            "email",
            "profile_image",
            "face_id",
            "touch_id",
            "notification_mute_status",
            "notification_mute_end",
            "status",
            "update_time",
          ],
        },
      ],
    });
    callback(null, response);
  }
  // Update monthly goal
  async updateMonthlyGoal(monthlyGoalData, callback) {
    const now = new Date();
    await monthlyGoalObject
      .update(
        {
          user_id: monthlyGoalData.user_id,
          connect_number: monthlyGoalData.connect_number,
          initiator_count: monthlyGoalData.initiator_count,
          initiator_count1: monthlyGoalData.initiator_count1,
          intimate_time: monthlyGoalData.intimate_time,
          intimate_request_time: monthlyGoalData.intimate_request_time,
          intimate_account_time: monthlyGoalData.intimate_account_time,
          percentage: monthlyGoalData.percentage,
          complete_count: 0,
          complete_percentage: 0,
          status: 1,
          hours: monthlyGoalData.hours,
          update_time: current_datetime.format(now, "YYYY-MM-DD hh:mm:ss"),
        },
        { where: { id: monthlyGoalData.id } }
      )
      .then(async (res) => {
        let response = await monthlyGoalObject.findOne({
          where: { id: monthlyGoalData.id },
        });
        callback(null, response);
      })
      .catch((err) => {
        callback(err.message, null);
      });
  }

  // Update monthly goal
  async getGoalDetails(id, patner, callback) {
    monthlyGoalObject.belongsTo(userObject, { foreignKey: "user_id" });
    const response = await monthlyGoalObject.findOne({
      where: {
        [Op.or]: [
          {
            user_id: {
              [Op.eq]: id,
            },
          },
          {
            user_id: {
              [Op.eq]: patner,
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
      order: [["create_time", "DESC"]],
    });
    callback(null, response);
  }

  // get user goal history via user_id
  async getAllGoalsHistoryByUserID(user_id, callback) {
    var goal_history = [];
    var partner_data;
    const response = await monthlyGoalObject.findAll({
      where: { user_id: user_id, status: 0 },
    });

    await Promise.all(
      response.map(async (element) => {
        monthlyGoalObject.belongsTo(userObject, { foreignKey: "user_id" });

        partner_data = await monthlyGoalObject.findAll({
          where: { goal_identifier: element.goal_identifier, status: 0 },
          include: [
            {
              model: userObject,
              attributes: [
                "id",
                "first_name",
                "last_name",
                "gender",
                "email",
                "profile_image",
                "face_id",
                "touch_id",
                "notification_mute_status",
                "notification_mute_end",
                "status",
                "update_time",
              ],
            },
          ],
        });

        goal_history.push(partner_data);
      })
    );

    callback(null, goal_history);
  }

  // Set Question Options
  async setQuestionOptions(title, question_id, q_title, q_descripation, callback) {
    const now = new Date();
    let data = await Promise.all(
      title &&
        title.map(async (element) => {
          if (element) {
            let Questiona_option = new questionOptionsObject({
              title: element,
              status: 1,
              question_id: question_id,
              create_time: current_datetime.format(now, "YYYY-MM-DD hh:mm:ss"),
              update_time: current_datetime.format(now, "YYYY-MM-DD hh:mm:ss"),
            });
            goalSettingsObject.update(
              {
                question_title: q_title,
                question_descripation: q_descripation,
              },
              { where: { id: question_id } }
            );
            return await Questiona_option.save();
          }
        })
    );
    callback(null, data);
  }

  // Save singal option
  async SaveQuetionOption(title, quetion_id, callback) {
    console.log("title", title);
    const now = new Date();
    let Questiona_option = new questionOptionsObject({
      title: title,
      status: 1,
      question_id: quetion_id,
      create_time: current_datetime.format(now, "YYYY-MM-DD hh:mm:ss"),
      update_time: current_datetime.format(now, "YYYY-MM-DD hh:mm:ss"),
    });
    callback(null, await Questiona_option.save());
  }

  // Get Option By Question Id
  async GetOptionByQuestionId(quetion_id, callback) {
    const GetOption = await questionOptionsObject.findAll({
      where: { question_id: quetion_id },
    });

    callback(null, GetOption);
  }

  // Get Question option
  async GetQuestionOption(callback) {
    const GetOption = await questionOptionsObject.findAll();
    callback(null, GetOption);
  }

  // Save Questionaries from Admin panel
  async saveQuestionaries(questionData, callback) {
    const now = new Date();
    let Questiona = new goalSettingsObject({
      question_descripation: questionData.question_descripation,
      question_title: questionData.question_title,
      iscustom: questionData.iscustom ? questionData.iscustom : false,
      status: 1,
      create_time: current_datetime.format(now, "YYYY-MM-DD hh:mm:ss"),
      update_time: current_datetime.format(now, "YYYY-MM-DD hh:mm:ss"),
    });
    const data = await Questiona.save();
    callback(null, data);
  }

  // Remove Questionaries
  async removeQuestionaries(question_id, callback) {
    let res = goalSettingsObject.destroy({ where: { id: question_id } });
    callback(null, res);
  }

  // Remove Question Option from Admin panel
  async removeOption(question_id, callback) {
    let res = questionOptionsObject.destroy({
      where: { question_id: question_id },
    });
    callback(null, res);
  }

  // Remove Question Answer
  async removeQuestionariesAnswer(question_id, callback) {
    let res = goalSettingAnswerObject.destroy({
      where: { question_id: question_id },
    });
    callback(null, res);
  }

  // Get Question Option By Id
  async getQuestionOption(paginationData, id, callback) {
    const GetOption = await questionOptionsObject.findAll(
      { offset: paginationData.offset, limit: paginationData.limit },
      { where: { question_id: id } }
    );
    callback(null, GetOption);
  }

  // Add Contribution After connect last night
  async updateCompleteCount(completedata, callback) {
    monthlyGoalObject
      .update(
        {
          complete_count: completedata.complete_count,
          contribution1: completedata.contribution1,
          contribution2: completedata.contribution2,
        },
        { where: { id: completedata.id } }
      )
      .then(async () => {
        let res = await monthlyGoalObject.findOne({
          where: { id: completedata.id },
        });
        callback(null, res);
      })
      .catch((err) => {
        callback(err.message, null);
      });
  }

  // Get Previous Month Goal Data
  async GetPreviousMonthyGoalById(id, patner, callback) {
    const response = await monthlyGoalObject.findAll(
      {
        where: {
          [Op.or]: [
            {
              user_id: {
                [Op.eq]: id,
              },
            },
            {
              user_id: {
                [Op.eq]: patner,
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
        order: [["create_time", "DESC"]],
      },
      { limit: 2 }
    );
    if (response[0].connect_number === response[0].complete_count) {
      callback(null, response[0]);
    } else {
      callback(null, response[1]);
    }
  }

  // Add Uniuqe Id for Chat
  async AddUniqueId(id, callback) {
    let unique = this.makeid(30);
    let response = await partnerMappingObject.findAll({
      where: { uniqe_id: unique },
    });
    if (response.length == 0) {
      const response = await partnerMappingObject.update(
        { uniqe_id: unique },
        {
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
          },
        }
      );
      callback(null, response);
    } else {
      this.AddUniqueId(id, callback);
    }
  }

  // Create Unique Id
  makeid(length) {
    var result = "";
    var characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    var charactersLength = characters.length;
    for (var i = 0; i < length; i++) {
      result += characters.charAt(Math.floor(Math.random() * charactersLength));
    }
    return result;
  }

  async CheckRecipt(recipt, userid, callback) {
    const GetOption = await userObject.findAll({
      where: { receipt: recipt, id: userid },
    });
    console.log("recipt", recipt);
    if (GetOption.length === 0) {
      callback(null, "continue");
    } else {
      callback("stop", null);
    }
  }
}

module.exports = GoalService;
