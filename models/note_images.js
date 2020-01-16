/** 
  * @desc this file will define the schema for note images table
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file note_images.js
*/


const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const noteImagesSchema = new Schema(
{
    note_id: String,
    note_image: String,
    status: String,
    created_date: String,
},
{ versionKey: false },
);

module.exports = mongoose.model('note_image', noteImagesSchema);
