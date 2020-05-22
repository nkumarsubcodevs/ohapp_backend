
/** 
  * @desc this service file will define all the functions related to the notes
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file InfoMessages.js
*/

const infoObject = require('../models/info_messages');
const current_datetime = require('date-and-time');

const now = new Date();
class InfoMessages
{
	// get single note detail
	async getSingleInfoMessage(title, callback) {
		await infoObject.findOne({ where: { title: title,  status:1 } }).then(res => {
			callback(null, res);
		}).catch(err => {
			console.log(err)
			callback(err.message, null);
		})
	}

	async saveMessages(title, message, callback) {
		const now = new Date();
		let data = new infoObject({
			title: title,
			description: message,
			status: 1,
			create_time: current_datetime.format(now, 'YYYY-MM-DD hh:mm:ss'),
			update_time: current_datetime.format(now, 'YYYY-MM-DD hh:mm:ss')
		})
		await data.save().then(res => {
			callback(null, res)
		}).catch(err => {
			console.log(err)
			callback(err.message, null);
		})
	}

	async getAllMessages(paginationData,callback) {
		await infoObject.findAndCountAll({offset: paginationData.offset, limit: paginationData.limit}).then(res => {
			callback(null, res);
		}).catch(err => {
			console.log(err)
			callback(err.message, null);
		})
	}

	async getMessage(callback) {
		await infoObject.findAll().then(res => {
			callback(null, res);
		}).catch(err => {
			console.log(err)
			callback(err.message, null);
		})
	}

	async getSingleInfoMessageById(id, callback) {
		await infoObject.findOne({ where: { id: id,  status:1 } }).then(res => {
			callback(null, res);
		}).catch(err => {
			callback(err.message, null);
		})
	}

	async UpdateMessages(UpdateData, callback) {
		const now = new Date();
		await infoObject.update({
			title: UpdateData.title,
			description: UpdateData.descripation,
			status: UpdateData.status,
			update_time: current_datetime.format(now, 'YYYY-MM-DD hh:mm:ss')
		},
		{ where: { id: UpdateData.id }})
		const response = await infoObject.findOne({ where: { id: UpdateData.id } });
		callback(null, response);
	}

	async removeMessages(id, callback) {
		await infoObject.destroy({ where: { id: id } }).then(res => {
			callback(null, res);
		}).catch(err => {
			callback(err.message, null);
		})
	}
}


module.exports = InfoMessages;




