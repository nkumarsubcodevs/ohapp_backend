/** 
  * @desc this file will contains the routes for pages api
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file pages.js
*/

const express = require('express');
const faqServices = require('../../services/faqService');
const formValidator = require('validator');
const faqlinkservices = require('../../services/faqlinkservices')


// verifytoken middleware
const verifyToken = require('./verifytoken');

// Create route object
let router = express.Router();

// Create Info_messages model object
var faqObjects = new faqServices();
var faqlinkObject = new faqlinkservices()
// Get single page content
router.get('/getFaq', verifyToken, function (req, res, next) {
    faqObjects.GetFaq(function (err, messagesData) {
        if (err) {
            res.send({
                status: 404,
                message: "Something went wrong"
            })
        } else {
            if (messagesData) {
                faqlinkObject.GetFaq(function (err, messagesDatalink) {
                    if (messagesData) {
                        res.send({
                            status: 200,
                            result: messagesData,
                            link: messagesDatalink
                        })
                    } else {
                        res.send({
                            status: 500,
                            message: "FAQ messages is not avaliable"
                        })
                    }
                })
            }
            else {
                faqlinkObject.GetFaq(function (err, messagesDatalink) {
                    if (messagesData) {
                        res.send({
                            status: 200,
                            link: messagesDatalink
                        })
                    } else {
                        res.send({
                            status: 500,
                            message: "FAQ messages is not avaliable"
                        })
                    }
                }
                )
            }
        }

    })
});




module.exports = router;