
/** 
  * @desc this file will define the schema for pattern grid table
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file stitches_pattern_grid.js
*/

const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const stitchesPatternGridSchema = new Schema(
  {
      stitches_pattern_id: String,
      grid_row_index: String,
      grid_column_index: String,
      stitches_color_id: String,
      stitches_type_id: String,
      stitches_instruction: String,
  },
  { versionKey: false },
);

module.exports = mongoose.model('stitches_pattern_grid', stitchesPatternGridSchema);
