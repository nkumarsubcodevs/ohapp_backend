/** 
  * @desc this file will define the schema for note table
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file note.js
*/

const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const noteSchema = new Schema(
{
    pattern_id: String,
    note_message: String,
    status: String,
    created_date: String,
    modified_date: String,
},
{ versionKey: false },
);

module.exports = mongoose.model('note', noteSchema);
