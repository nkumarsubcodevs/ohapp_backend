/** 
  * @desc this file will define the schema for images table
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file images.js
*/

const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const imagesSchema = new Schema(
  {
    urls: Array,
  },
  { versionKey: false },
);

module.exports = mongoose.model('images', imagesSchema);
