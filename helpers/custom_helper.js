/** 
  * @desc this file will hold all the common function for view/templating files
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file custom_helper.js
*/

var customHelper = {

	// get current date in timestamp
	h_getTodayDateInTimeStamp() {

		var current_date = new Date();
		var dd = String(current_date.getDate()).padStart(2, '0');
		var mm = String(current_date.getMonth() + 1).padStart(2, '0');
		var yyyy = current_date.getFullYear();
		current_date = yyyy + '-' + mm + '-' + dd;

		var current_date    = new Date(current_date).getTime();

		return current_date;
	}, 

	// get single grid color for pattern
	 h_getSingleColor(color_id, patternDesignColor) {

		for(var single_color = 0; single_color < patternDesignColor.length; single_color ++) 
		{
			if(color_id==patternDesignColor[single_color]._id) 
		    {
			    return JSON.parse(JSON.stringify(patternDesignColor[single_color]));
			}
		}			
	}, 

	// get single grid type for pattern
    h_getSingleStitchesType: function(type_id, patternDesignType) {
		for(var single_type = 0; single_type < patternDesignType.length; single_type ++) 
		{
			if(type_id==patternDesignType[single_type]._id) 
		    {
			    return JSON.parse(JSON.stringify(patternDesignType[single_type]));
			}
		}	
	}    
};

module.exports = customHelper;