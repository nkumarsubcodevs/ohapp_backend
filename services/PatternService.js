
/** 
  * @desc this service file will define all the functions related to the pattern
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file PatternService.js
*/


const stitchesColorObject = require('../models/stitches_color');
const stitchesTypeObject = require('../models/stitches_type');
const stitchesPatternObject = require('../models/stitches_pattern');
const stitchesPatternGridObject = require('../models/stitches_pattern_grid');
const stitchesRowInstructionObject = require('../models/stitches_row_instruction');

class PatternService
{
	// Create new pattern
	async createPattern(newpatternData, callback){

		let patternData = new stitchesPatternObject({
			pattern_title: newpatternData.pattern_title,
			pattern_description: newpatternData.pattern_description,
			user_id: newpatternData.user_id,
			pattern_status: newpatternData.pattern_status,
			grid_rows: newpatternData.grid_rows,
			grid_columns: newpatternData.grid_columns,
		});

		patternData.save(callback);
    }

	// get pattern list
	async getPatternList(callback){
		stitchesPatternObject.find(callback);
	}

	// get single pattern list
	async getPatterById(id, callback) {
		stitchesPatternObject.findById(id, callback);
	}

	// get pattern isntruction
	async getPatterInstruction(id, callback) {
		let condition  = {stitches_pattern_id: id};
		stitchesRowInstructionObject.find(condition, callback);
	}

	// update pattern detail
	async updatePattern(patternData, callback){
		let condition  = {_id: patternData.pattern_id};
		let updateData = { $set: {pattern_title:patternData.pattern_title, pattern_description:patternData.pattern_description, user_id:patternData.user_id, pattern_status:patternData.pattern_status, grid_rows:patternData.grid_rows, grid_columns:patternData.grid_columns} };
		stitchesPatternObject.updateOne(condition, updateData, callback);
	}

	// Create pattern grid	
	async createPatternGrid(patternGridData, callback) {

		let gridData      = JSON.stringify(patternGridData);
		var gridDataparse = JSON.parse(gridData);

		for(var i=0; i<gridDataparse.grid_rows; i++)
		{
			for(var j=0; j<gridDataparse.grid_columns; j++)
		    {
				let gridData = new stitchesPatternGridObject({
					stitches_pattern_id: gridDataparse._id,
					grid_row_index: i,
					grid_column_index: j,
					stitches_color_id: '5dbae8e95b3ac44b6eddc7c0',
					stitches_type_id: '5db15fca845fdf3fb37f1f73',
					stitches_instruction: '',
				});

				gridData.save();
			}
		}
		
		stitchesPatternObject.findById(gridDataparse._id, callback);
	}

	// delete pattern detail
	async deletePattern(pattern_id, callback){
		let pattern_condition  = {_id:pattern_id};
		stitchesPatternObject.deleteOne(pattern_condition, callback);
	}

	// delete pattern grid 
	async deletePatternGrid(pattern_id, callback){
		let pattern_idd       = JSON.stringify(pattern_id);
		var pattern_idd_parse = JSON.parse(pattern_idd);

		let grid_condition  = {stitches_pattern_id:pattern_idd_parse};
		stitchesPatternGridObject.deleteMany(grid_condition, callback);
	}

	// delete pattern instruction 
	async deletePatternInstruction(pattern_id, callback){
		let pattern_idd       = JSON.stringify(pattern_id);
		var pattern_idd_parse = JSON.parse(pattern_idd);

		let row_condition  = {stitches_pattern_id:pattern_idd_parse};
		stitchesRowInstructionObject.deleteMany(row_condition, callback);
	}

	// get pattern design list
	async getPatternDesign(pattern_id, callback){
		let pattern_condition  = {stitches_pattern_id:pattern_id};
		stitchesPatternGridObject.find(pattern_condition, callback);
	}

	// get pattern design instruction
	async getPatternInstructions(pattern_id, callback){
		let row_condition  = {stitches_pattern_id:pattern_id};
		stitchesRowInstructionObject.find(row_condition, callback);
	}

	// get pattern grid color
	async getGridColor(callback){
		let color_condition  = {color_status:1};
		stitchesColorObject.find(color_condition, callback);
	}

	// get pattern grid type
	async getGridType(callback){
		let type_condition  = {stitches_status:1};
		stitchesTypeObject.find(type_condition, callback);
	}

	// Update single grid value
	async updateGridValue(patternGridData, callback){

		if(typeof(patternGridData.gridbox)=="string" && patternGridData.gridbox.length==24)
		{
			var condition={_id:patternGridData.gridbox};
			var updateData={$set:{stitches_color_id:patternGridData.stitche_color,stitches_type_id:patternGridData.stitche_type}};
			var result = await stitchesPatternGridObject.updateOne(condition, updateData);

			stitchesPatternGridObject.findById(patternGridData.gridbox, callback);
		}
		else
		{
			for(var i=0; i<=patternGridData.gridbox.length; i++)
			{
				var condition={_id:patternGridData.gridbox[i]};
				var updateData={$set:{stitches_color_id:patternGridData.stitche_color,stitches_type_id:patternGridData.stitche_type}};
				var result = await stitchesPatternGridObject.updateOne(condition, updateData);
			}	

			stitchesPatternGridObject.findById(patternGridData.gridbox[0], callback);
		}	
	}

	// Update row instruction
	async updateRowInstruction(patternRowData, callback){
		let condition  = {stitches_pattern_id: patternRowData.pattern_id, row_number: patternRowData.row_id};
		let updateData = { $set: {row_instruction:patternRowData.row_instruction} };
		stitchesRowInstructionObject.updateOne(condition, updateData, callback);
	}

	// Create row instruction
	async createPatternInstruction(patternRowData, callback) {

		var stitches_pattern_id = patternRowData.stitches_pattern_id;

		for(var i=0; i<patternRowData.row_number; i++)
		{
		
			let rowData = new stitchesRowInstructionObject({
				stitches_pattern_id: stitches_pattern_id,
				row_number: i,
				row_instruction: '',
			});

			rowData.save();
		}

		stitchesPatternObject.findById(stitches_pattern_id, callback);
	}
}

module.exports = PatternService;




