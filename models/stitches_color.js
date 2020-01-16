
/** 
  * @desc this file will define the schema for pattern color table
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file stitches_color.js
*/

const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const stitchesPatternSchema = new Schema(
  {
      color_name: String,
      color_code: String,
      color_status: String,
  },
  { versionKey: false },
);

module.exports = mongoose.model('stitches_color', stitchesPatternSchema);
