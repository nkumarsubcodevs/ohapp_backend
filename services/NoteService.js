
/** 
  * @desc this service file will define all the functions related to the notes
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file NoteService.js
*/


const noteObject = require('../models/note');
const noteImgObject = require('../models/note_images');

class NoteService
{
	// Create new pattern
	async createNewNote(noteData, callback){

		var today = new Date();
		var dd = today.getDate();
		var mm = today.getMonth()+1; 
		var yyyy = today.getFullYear();

		var today_date = dd+'-'+mm+'-'+yyyy;

		let noteSaveData = new noteObject({
			pattern_id: noteData.pattern_id,
			note_message: noteData.note_message,
			status: noteData.status,
			created_date: today_date,
			modified_date: today_date,
		});

		noteSaveData.save(callback);
	}

	// Store note image
	async storeNoteImages(noteImageData, callback){

		var today = new Date();
		var dd = today.getDate();
		var mm = today.getMonth()+1; 
		var yyyy = today.getFullYear();

		var today_date = dd+'-'+mm+'-'+yyyy;

		for(var j=0; j<noteImageData.upload_files.length; j++)
		{
			let noteImgSaveData = new noteImgObject({
				note_id: noteImageData.note_id,
				note_image: noteImageData.upload_files[j].filename,
				status: noteImageData.status,
				created_date: today_date,
			});

			noteImgSaveData.save();
		}

		let condition  = {note_id: noteImageData.note_id};
		noteImgObject.find(condition, callback);
	}
	
	// get note list
	async getNoteList(noteData, callback) {
		// let condition  = {pattern_id: noteData.pattern_id, status:1};
		// noteObject.find(condition, callback);

		noteObject.aggregate([
			// define some conditions here 
			{
				$match:{
					$and:[{"pattern_id" : noteData.pattern_id}, { "status": "1"}]
				},
			},
			// set and convert fields
			{ 
				$project :{
					"_id":{"$toString":"$_id"},
					"pattern_id":{"$toObjectId":"$pattern_id"},
					"note_message":{"$toString":"$note_message"},
					"created_date":{"$toString":"$created_date"},
					"modified_date":{"$toString":"$modified_date"},
				}
			},
			// Join with table
			{
				$lookup: {
					from: "note_images",
					localField: "_id",
					foreignField: "note_id",
					as: "nimages"
				}
			}
			]).then(data => {
				callback(null, data);
			});

	}

	// get single note detail
	async getSingleNote(noteData, callback) {
		let condition  = {_id: noteData.note_id, status:1};
		noteObject.find(condition, callback);
	}

	// update note detail
	async updateNote(noteData, callback){

		var today = new Date();
		var dd = today.getDate();
		var mm = today.getMonth()+1; 
		var yyyy = today.getFullYear();

		var today_date = dd+'-'+mm+'-'+yyyy;

		let condition  = {_id: noteData.note_id};
		let updateData = { $set: {note_message:noteData.note_message, modified_date: today_date} };
		noteObject.updateOne(condition, updateData, callback);
	}

	// delete note detail
	async deleteNote(noteData, callback){
		let note_condition  = {_id:noteData.note_id};
		noteObject.deleteOne(note_condition, callback);
	}

	// delete note image
	async deleteNoteImg(noteImgData, callback){
		let note_condition  = {_id:noteImgData.note_img_id};
		noteImgObject.deleteOne(note_condition, callback);
	}
}

module.exports = NoteService;




