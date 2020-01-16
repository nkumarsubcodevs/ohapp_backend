/** 
  * @desc this file will contains the routes for images api
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file images.js
*/

const express = require('express');
const image = express();
const Images = require('../../models/images');

//get images
image.get('/', function(req, res) {
  var query = Images.findOne({});
  query
    .then(data => {
      res.send({
        status: 200,
        message: 'success',
        result: data,
      });
    })
    .catch(err => {
      res.send({
        status: 500,
        message: 'something went wrong',
      });
    });
});

//add image.
image.post('/add', function(req, res) {
  var existingUrls = Images.findOne({});
  existingUrls.then(existingUrls => {
    if (existingUrls) {
      existingUrls.urls.map((e, i) => {
        if (e === req.body.url) {
          return res.send({
            status: 405,
            message: 'url already exists ' + req.body.url,
          });
        }
      });
      existingUrls.urls.push(req.body.url);

      existingUrls
        .update(existingUrls)
        .then(url => {
          if (!url) {
            return res.send({
              status: 400,
              message: 'url not found',
            });
          }
          res.send({
            status: 200,
            message: 'success',
            result: url,
          });
        })
        .catch(err => {
          res.send({
            status: 500,
            message: 'something went wrong, try again later',
            type: JSON.stringify(err),
          });
        });
    } else {
      var newUrl = new Images({
        urls: [req.body.url],
      });
      newUrl.save().then(url => {
        if (!url) {
          return res.send({
            status: 400,
            message: 'url not found',
          });
        } else {
          res.send({
            status: 200,
            message: 'success',
            result: url,
          });
        }
      });
    }
  });
});

//remove image.
image.post('/remove', function(req, res) {
  var existingUrls = Images.findOne({});
  existingUrls.then(existingUrls => {
    if (existingUrls) {
      existingUrls.urls.map((e, i) => {
        let isUrlExist = existingUrls.urls.indexOf(e);
        if (isUrlExist > -1) {
          existingUrls.urls.splice(isUrlExist, 1); //remove
        } else {
          return res.send({
            status: 405,
            message: 'url does not exists' + req.body.url,
          });
        }
      });
      existingUrls
        .update(existingUrls)
        .then(url => {
          if (!url) {
            return res.send({
              status: 400,
              message: 'url not found',
            });
          }
          res.send({
            status: 200,
            message: 'success',
            result: url,
          });
        })
        .catch(err => {
          res.send({
            status: 500,
            message: 'something went wrong, try again later',
            type: JSON.stringify(err),
          });
        });
    } else {
      return res.send({
        status: 406,
        message: 'no urls exists in collection',
      });
    }
  });
});

module.exports = image;
