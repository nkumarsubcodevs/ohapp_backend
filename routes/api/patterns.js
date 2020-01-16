/** 
  * @desc this file will contains the routes for patterns api
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file patterns.js
*/


var express = require('express');
const patternService = require('../../services/PatternService');

const stitchesPatternGridObject = require('../../models/stitches_pattern_grid');

// JWT web token
const jwt         = require('jsonwebtoken');

// Get API secret
const config      = require('../../config/config');

// verifytoken middleware
const verifyToken = require('./verifytoken');

// Create route object
let router =  express.Router();

// Create user model object
var patternSerObject = new patternService();

// Get user detail
router.get('/getpattern/:pattern_id', verifyToken, function(req, res, next) {

    var pattern_id = req.params.pattern_id; 

    stitchesPatternGridObject.aggregate([
    // define some conditions here 
    {
        $match:{
            $and:[{"stitches_pattern_id" : pattern_id}]
        }
    },
    // set and convert grid fields
    { 
        $project :{
            "stitches_pattern_id":{"$toObjectId":"$stitches_pattern_id"},
            "grid_row_index":{"$toString":"$grid_row_index"},
            "grid_column_index":{"$toString":"$grid_column_index"},
            "stitches_color_id":{"$toObjectId":"$stitches_color_id"},
            "stitches_type_id":{"$toObjectId":"$stitches_type_id"},
            "stitches_instruction":{"$toString":"$stitches_instruction"},
        }
    },
    // Join with color table
    {
        $lookup: {
            from: "stitches_colors",
            localField: "stitches_color_id",
            foreignField: "_id",
            as: "grid_color"
        }
    },
    {
        $lookup: {
            from: "stitches_types",
            localField: "stitches_type_id",
            foreignField: "_id",
            as: "grid_type"
        }
    },
    ]).then(data => {

        patternSerObject.getPatterById(pattern_id, function(err, patternDetail) 
        {
            patternSerObject.getPatterInstruction(pattern_id, function(err, patternRowInstruction) 
            {
                res.send({
                    status: 200,
                    pattern: JSON.parse(JSON.stringify(patternDetail)),
                    rowinstruction: JSON.parse(JSON.stringify(patternRowInstruction)),
                    patterngrid: JSON.parse(JSON.stringify(data)),
                });
            });
        });
    });
});

module.exports = router;
