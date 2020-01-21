
/** 
  * @desc this service file will define all the functions related to the notes
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file PageService.js
*/

const pageObject = require('../models/page');

class PageService
{
	// get single note detail
	async getSinglePage(pageData, callback) {
		const response = await pageObject.findOne({ where: { id: pageData.page_id,  status:1 } });
		callback(null, response);
	}
}

module.exports = PageService;




