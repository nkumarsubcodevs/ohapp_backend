
/** 
  * @desc this file will define the schema for pattern table
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file stitches_pattern.js
*/


const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const stitchesPatternSchema = new Schema(
  {
      pattern_title: String,
      pattern_description: String,
      user_id: String,
      pattern_status: String,
      grid_rows: String,
      grid_columns: String,
  },
  { versionKey: false },
);

module.exports = mongoose.model('stitches_pattern', stitchesPatternSchema);
