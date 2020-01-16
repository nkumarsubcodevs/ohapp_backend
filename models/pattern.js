
/** 
  * @desc this file will define the schema for pattern-1 (Static Type)
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file pattern.js
*/

const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const repeatSchema = new Schema({
  from_round: Number,
  to_round: Number,
  repeat_count: Number,
});

const chartSchema = new Schema({
  round: Number,
  pattern: Array,
  instruction: Array,
  small: Number,
  large: Number,
});

const patternSchema = new Schema(
  {
    name: String,
    rounds: Number,
    columns: Number,
    repeat: [repeatSchema],
    chart: [chartSchema],
    created_by: String,
    complete_text: String,
    created_date: Date,
    modified_by: String,
    modified_date: Date,
    status: String,
  },
  { versionKey: false },
);

module.exports = mongoose.model('Pattern', patternSchema);
