
/** 
  * @desc this service file will define all the functions related to the notes
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file PageService.js
*/

const pageObject = require('../models/pages');
const current_datetime = require('date-and-time');

const now = new Date();
class PageService
{
	// get single note detail
	async getSinglePage(pageData, callback) {
		const response = await pageObject.findOne({ where: { id: pageData.page_id,  status:1 } });
		callback(null, response);
	}

	// get all pages list
	async getPageList(paginationData, callback){
		const response = await pageObject.findAndCountAll({offset: paginationData.offset, limit: paginationData.limit});
		callback(null,response);
	}

	//get single page record
	async getSinglePageRecord(page_id,callback) {
		const response = await pageObject.findAll({where:{id: page_id}});
		callback(null,response);
	}
	
	//update page details
	async updatepageDetails(pageData, callback){
		const response=await pageObject.update({title:pageData.title,status:pageData.status,update_time: current_datetime.format(now, 'YYYY-MM-DD hh:mm:ss')}, { where: { id: pageData.id }});
		callback(null, response);
	}
	
}
	
		
module.exports = PageService;




