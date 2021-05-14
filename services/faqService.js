
/** 
  * @desc this service file will define all the functions related to the notes
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file faqService.js
*/

const faqObject = require('../models/faq');
const current_datetime = require('date-and-time');

const now = new Date();
class faqService {

    async getQuestion(paginationData, callback) {
        const response = await faqObject.findAndCountAll({
            offset: paginationData.offset,
            limit: paginationData.limit,
        });
        callback(null, response);
    }

    async GetQuestionOption(callback) {
        const GetOption = await faqObject.findAll();
        callback(null, GetOption);
    }
    async getsfaq(paginationData, callback) {
        const response = await faqObject.findAndCountAll({
            offset: paginationData.offset,
            limit: paginationData.limit,
        });
        callback(null, response);
    }

    // get all faq data
    async GetFaq(callback) {
        await faqObject.findAll().then(res => {
            callback(null, res);
        }).catch(err => {
            callback(err.message, null);
        })
    }

    async GetQuestion(callback) {
        const response = await faqObject.findAll()

        callback(null, response);
    }

    // Save Info _messages for Admin Panel
    async saveMessages(title, description, callback) {
        const now = new Date();
        let data = new faqObject({
            title: title,
            description: description,
            create_time: current_datetime.format(now, "YYYY-MM-DD hh:mm:ss"),
            update_time: current_datetime.format(now, "YYYY-MM-DD hh:mm:ss"),

        })

        await data.save()
            .then(res => {
                callback(null, res);
            }).catch(err => {
                callback(err.message, null);
            })
    }


    // get faq using particular id
    async Getfaqbyid(id, callback) {
        const GetOption = await faqObject.findAll({
            where: { id: id },
        });

        callback(null, GetOption);
    }

    // delete faq
    async removeFAQ(id, callback) {
        let res = faqObject.destroy({
            where: { id: id },
        });
        callback(null, res);
    }

    // update faq
    async updateFAQ(title, description, id, callback) {
        const now = new Date();
        await faqObject.update({ description: description, title: title, update_time: now }, { where: { id: id } }).then(res => {
            callback(null, res);
        }).catch(err => {
            callback(err.message, null);
        })
    }

}

module.exports = faqService;