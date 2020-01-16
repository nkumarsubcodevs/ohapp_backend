
/** 
  * @desc this file will define the schema for pattern instruction
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file stitches_row_instruction.js
*/


const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const stitchesRowInstructionSchema = new Schema(
  {
      stitches_pattern_id: String,
      row_number: String,
      row_instruction: String,
  },
  { versionKey: false },
);

module.exports = mongoose.model('stitches_row_instruction', stitchesRowInstructionSchema);
