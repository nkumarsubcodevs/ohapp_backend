/** 
  * @desc this file will contains the routes for pages api
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file pages.js
*/

const express = require('express');
const InfoMessages = require('../../services/InfoMessages');
const formValidator = require('validator');

// verifytoken middleware
const verifyToken = require('./verifytoken');

// Create route object
let router =  express.Router();

// Create Info_messages model object
var infoMesssageObject = new InfoMessages();

// Get single page content
router.get('/getInfoMessages', verifyToken, function(req, res, next) {
  infoMesssageObject.getMessage(function(err, messagesData) {
    if(err) {
      res.send({
        status: 404,
        message: "Something went wrong"
      })
    } else {
      if(messagesData) {
        res.send({
          status: 200,
          result: messagesData
        })
      } else {
        res.send({
          status: 500,
          message: "Info messages is not avaliable"
        })
      }
    }
  })
});

router.post('/saveMessages', verifyToken, function(req, res) {
  let title = req.body.title;
  let descripation = req.body.description;
  infoMesssageObject.saveMessages(title, descripation, function(err, MessagesData) {
    if(err) {
      res.send({
        status: 404,
        message: "something went wrong"
      })
    } else {
      if(MessagesData) {
        res.send({
          status: 200,
          message: "Saved succcessfully"
        })
      } else {
        res.send({
          status: 500,
          message: "Something went wrong"
        })
      }
    }
  })
})



module.exports = router;