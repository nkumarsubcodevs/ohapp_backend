
/** 
  * @desc this service file will define all the functions related to the notes
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file QuickyService.js
*/

const QuickyObject = require('../models/quicky');
const current_datetime = require('date-and-time');

const now = new Date();
class QuickyService
{
	// get all pages list
	async saveQuicky(quickyData, callback){
		let saverecord = new QuickyObject({
			user_id: quickyData.user_id,
			partner_mapping_id: quickyData.partner_mapping_id,
			when: quickyData.when,
			where: quickyData.where,
			create_time:current_datetime.format(now, 'YYYY-MM-DD hh:mm:ss'),
			update_time: current_datetime.format(now, 'YYYY-MM-DD hh:mm:ss')
		})
		callback(null,await saverecord.save());
	}

	//get single page record
	async getSingleQuickyRecord(quicky_id,callback) {
		const response = await QuickyObject.findOne({where:{id: quicky_id}});
		callback(null,response);
	}

	//update page details
	async updateQuicky(quickyData, callback){
		 await QuickyObject.update({
			user_id:quickyData.user_id,
			when: quickyData.when,
			where: quickyData.where,
			partner_response: quickyData.partner_response,
			update_time: current_datetime.format(now, 'YYYY-MM-DD hh:mm:ss')},
			 { where:
				{
					id: quickyData.quicky_id
				}
			  }).then(async res => {
				  let RES = await QuickyObject.findOne({where: {id: quickyData.quicky_id}});
				  callback(null, RES)
			  }).catch(err => {
				  console.log(err)
				  callback(err, null)
			  })
	}

	async updateUserIntrest(quickyData, callback){
		await QuickyObject.update({
		   user_id:quickyData.user_id,
		   partner1_intrest: quickyData.partner1_intrest,
		   partner2_intrest: quickyData.partner2_intrest,
		   update_time: current_datetime.format(now, 'YYYY-MM-DD hh:mm:ss')},
			{ where:
			   {
				   id: quickyData.quicky_id
			   }
			 }).then(async res => {
				 let RES = await QuickyObject.findOne({where: {id: quickyData.quicky_id}});
				 callback(null, RES)
			 }).catch(err => {
				 console.log(err)
				 callback(err, null)
			 })
   }
   async updatePartnerDatainQuicky(quickyData, callback){
	await QuickyObject.update({
	   partner1_answer1: quickyData.partner1_answer1,
	   partner1_answer2: quickyData.partner1_answer2,
	   partner2_answer1: quickyData.partner2_answer1,
	   partner2_answer2: quickyData.partner2_answer2,
	   update_time: current_datetime.format(now, 'YYYY-MM-DD hh:mm:ss')},
		{ where:
		   {
			   id: quickyData.quicky_id
		   }
		}).then(async res => {
			let RES = await QuickyObject.findOne({where: {id: quickyData.quicky_id}});
			callback(null, RES)
		}).catch(err => {
			callback(err, null)
		})
	}
	async Addcontribution(quicky_id, callback) {
		await QuickyObject.update({
			contribution: 1,
			update_time: current_datetime.format(now, 'YYYY-MM-DD hh:mm:ss')},
			 { where:
				{
					id: quicky_id
				}
			 }).then(async res => {
				 let RES = await QuickyObject.findOne({where: {id: quicky_id}});
				 callback(null, RES)
			 }).catch(err => {
				 callback(err, null)
			 })
	}
}

module.exports = QuickyService;