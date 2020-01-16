
/** 
  * @desc this file will define the schema for pattern stitches type table
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file stitches_type.js
*/

const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const stitchesPatternSchema = new Schema(
  {
      stitches_name: String,
      stitches_image_path: String,
      stitches_size: String,
      stitches_status: String,
  },
  { versionKey: false },
);

module.exports = mongoose.model('stitches_type', stitchesPatternSchema);
