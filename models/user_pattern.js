
/** 
  * @desc this file will define the schema for user pattern-1 table (Static Type)
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file user_pattern.js
*/

const Schema = mongoose.Schema;

const userPatternSchema = new Schema(
  {
    round_checked: Array,
    box_opended: Array,
    user_id: String,
    last_modified: String,
    pattern_id: String,
    size: String,
    screen: String,
  },
  { versionKey: false },
);

module.exports = mongoose.model('UserPattern', userPatternSchema);
