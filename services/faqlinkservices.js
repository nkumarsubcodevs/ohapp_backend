
/** 
  * @desc this service file will define all the functions related to the notes
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file faqlinkservices.js
*/

const faqlinkobject = require('../models/faqlink')
const current_datetime = require('date-and-time');

const now = new Date();
class faqService {


    async getFaqLInk(paginationData, callback) {
        const response = await faqlinkobject.findAndCountAll({
            offset: paginationData.offset,
            limit: paginationData.limit,
        });
        callback(null, response);
    }


    async GetQuestionOption(callback) {
        const GetOption = await faqlinkobject.findAll();
        callback(null, GetOption);
    }
    async getsfaq(paginationData, callback) {
        const response = await faqlinkobject.findAndCountAll({
            offset: paginationData.offset,
            limit: paginationData.limit,
        });
        callback(null, response);
    }

    // get all faqlink
    async GetFaq(callback) {
        await faqlinkobject.findAll().then(res => {
            callback(null, res);
        }).catch(err => {
            callback(err.message, null);
        })
    }

    // get question
    async GetQuestion(callback) {
        const response = await faqlinkobject.findAll()

        callback(null, response);
    }


    // get faqlinkby id
    async Getfaqbyid(id, callback) {
        const GetOption = await faqlinkobject.findAll({
            where: { id: id },
        });

        callback(null, GetOption);
    }

    // remove faq link
    async removeFAQ(id, callback) {
        let res = faqlinkobject.destroy({
            where: { id: id },
        });
        callback(null, res);
    }

    //update faq link
    async updateFAQ(title, link, id, callback) {
        const now = new Date();
        await faqlinkobject.update({ link: link, title: title, update_time: now }, { where: { id: id } }).then(res => {
            callback(null, res);
        }).catch(err => {
            callback(err.message, null);
        })
    }


}

module.exports = faqService;