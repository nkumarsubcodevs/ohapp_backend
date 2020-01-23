/** 
  * @desc this file will contains the routes for pages api
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file pages.js
*/

const express = require('express');
const pageService = require('../../services/PageService');
const formValidator = require('validator');

// verifytoken middleware
const verifyToken = require('./verifytoken');

// Create route object
let router =  express.Router();

// Create user model object
var pageSerObject = new pageService();

// Get single page content
router.get('/getpagecontent/:page_id', verifyToken, function(req, res, next) {

  var page_id = req.params.page_id;

  if(!page_id) 
  {
      return res.send({
        status: 400,
        message: 'Page id is required',
      });
  }

  if(!formValidator.isInt(page_id))   
	{
		return res.send({
			status: 400,
			message: 'Please enter a valid page id.',
		});
	}
  
  let pageData = {
      'page_id': page_id,
  };

  pageSerObject.getSinglePage(pageData, function(err, pageData)
  {
      if(err)
      {
          res.send({
            status: 500,
            message: 'There was a problem in fetching the page.',
          });
      }
      else
      {
          if(pageData)
          {
              res.send({
                status: 200,
                result: pageData,
              });
          }
          else
          {
              res.send({
                status: 404,
                message: 'No page found.',
              });
          }	
      }
  });
});

module.exports = router;