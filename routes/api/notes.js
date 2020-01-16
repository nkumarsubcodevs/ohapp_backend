/** 
  * @desc this file will contains the routes for notes api
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file notes.js
*/


const express = require('express');
const noteService = require('../../services/NoteService');
// JWT web token
const jwt         = require('jsonwebtoken');
// Get API secret
const config      = require('../../config/config');
// verifytoken middleware
const verifyToken = require('./verifytoken');

// Include image upload lib
const multer  =   require('multer');

const multerConf = {
	storage : multer.diskStorage({
		destination: (req, files, next) => {
			next(null, 'public/note_images')
		},
		filename: function(req, files, next){
			const ext = files.mimetype.split("/")[1];
			next(null, files.fieldname + '-' + Date.now()+'.'+ext);
		}
	}),
	limits: {
        fileSize: 250000
    },
	fileFilter: function(req, files, next){
		
		if(!files)
		{
			next();
		}
		
		const image = files.mimetype.startsWith('image/');

		if(image)
		{
			next(null, true);
		}
		else
		{
			next({message:"Please upload valid file format(jpg, jpeg, png)"}, false);
		}
	}
};

var uploadObject = multer(multerConf).array('note_photo', 3);

// Create route object
let router =  express.Router();

// Create user model object
var noteSerObject = new noteService();

// Add new note
router.post('/createnote', verifyToken, function(req, res, next) {

  uploadObject(req, res, function(err) {

      if(err) 
      {
          res.send({
              status: 500,
              message: err.message,
          });
      }
      else
      {
          let pattern_id   = req.body.pattern_id;
          let note_message = req.body.note_message;
          let upload_files = req.files;

          if(!pattern_id) 
          {
              return res.send({
                status: 400,
                message: 'Pattern id is required',
              });
          }
          
          if(!note_message) 
          {
              return res.send({
                status: 400,
                message: 'Message is required',
              });
          }
          
          let noteData = {
              'pattern_id': pattern_id,
              'note_message': note_message,
              'status': 1
          };
          
          noteSerObject.createNewNote(noteData, function(err, noteData) 
          {
              if(err)
              {
                  res.send({
                      status: 500,
                      message: 'something went wrong',
                  });
              }
              else
              {
                  let noteImageData = {
                      'note_id': JSON.parse(JSON.stringify(noteData._id)),
                      'upload_files': upload_files,
                      'status': 1
                  };

                  noteSerObject.storeNoteImages(noteImageData, function(err, noteImageData) 
                  {
                      if(err)
                      {
                          res.send({
                              status: 500,
                              message: 'something went wrong',
                          });
                      }
                      else
                      {
                          res.send({
                              status: 200,
                              message: 'Note added successfully',
                          });
                      }
                  });
              }
          });
      }
  });
  
});

// Get note list
router.get('/getnotelist/:pattern_id', verifyToken, function(req, res, next) {

    var pattern_id = req.params.pattern_id;

    if(!pattern_id) 
    {
        return res.send({
          status: 400,
          message: 'Pattern id is required',
        });
    }
    
    let noteData = {
        'pattern_id': pattern_id,
    };

    noteSerObject.getNoteList(noteData, function(err, noteData)
    {
        if(err)
        {
            res.send({
              status: 500,
              message: 'There was a problem in fetching the note.',
            });
        }
        else
        {
            if(noteData)
            {
                res.send({
                  status: 200,
                  result: noteData,
                });
            }
            else
            {
                res.send({
                  status: 404,
                  message: 'No notes found.',
                });
            }	
        }
    });
});

// Get single note
router.get('/getsinglenote/:note_id', verifyToken, function(req, res, next) {

  var note_id = req.params.note_id;

  if(!note_id) 
  {
      return res.send({
        status: 400,
        message: 'Note id is required',
      });
  }
  
  let noteData = {
      'note_id': note_id,
  };

  noteSerObject.getSingleNote(noteData, function(err, noteData)
  {
      if(err)
      {
          res.send({
            status: 500,
            message: 'There was a problem in fetching the note.',
          });
      }
      else
      {
          if(noteData)
          {
              res.send({
                status: 200,
                result: noteData,
              });
          }
          else
          {
              res.send({
                status: 404,
                message: 'No notes found.',
              });
          }	
      }
  });
});

// Update single note
router.post('/updatenote', verifyToken, function(req, res, next) {

    var note_id = req.body.note_id;
    var note_message = req.body.note_message;

    if(!note_id) 
    {
        return res.send({
          status: 400,
          message: 'Note id is required',
        });
    }

    if(!note_message) 
    {
        return res.send({
          status: 400,
          message: 'Note message is required',
        });
    }
    
    let noteData = {
        'note_id': note_id,
        'note_message': note_message,
    };

    noteSerObject.updateNote(noteData, function(err, noteData)
    {
        if(err)
        {
            res.send({
              status: 500,
              message: 'There was a problem in update the note.',
            });
        }
        else
        {
            if(noteData.nModified==1)
            {
                res.send({
                  status: 200,
                  message: 'Note updated successfully',
                });
            }
            else
            {
                res.send({
                  status: 404,
                  message: 'No notes updated.',
                });
            }	
        }
    });
});

// Delete note
router.get('/deletenote/:note_id', verifyToken, function(req, res, next) {

  var note_id = req.params.note_id;

  if(!note_id) 
  {
      return res.send({
        status: 400,
        message: 'Note id is required',
      });
  }
  
  let noteData = {
      'note_id': note_id,
  };

  noteSerObject.deleteNote(noteData, function(err, noteData)
  {
      if(err)
      {
          res.send({
            status: 500,
            message: 'There was a problem in delete the note.',
          });
      }
      else
      {
          if(noteData.deletedCount==1)
          {
              res.send({
                status: 200,
                message: 'Note deleted successfully.',
              });
          }
          else
          {
              res.send({
                status: 404,
                message: 'No notes found.',
              });
          }	
      }
  });
});

// Delete note image
router.get('/deletenoteimg/:note_img_id', verifyToken, function(req, res, next) {

    var note_img_id = req.params.note_img_id;
  
    if(!note_img_id) 
    {
        return res.send({
          status: 400,
          message: 'Note image id is required',
        });
    }
    
    let noteImgData = {
        'note_img_id': note_img_id,
    };
  
    noteSerObject.deleteNoteImg(noteImgData, function(err, noteImgData)
    {
        if(err)
        {
            res.send({
              status: 500,
              message: 'There was a problem in delete the note image.',
            });
        }
        else
        {
            if(noteImgData.deletedCount==1)
            {
                res.send({
                  status: 200,
                  message: 'Note image deleted successfully.',
                });
            }
            else
            {
                res.send({
                  status: 404,
                  message: 'No notes image found.',
                });
            }	
        }
    });
});
  

module.exports = router;