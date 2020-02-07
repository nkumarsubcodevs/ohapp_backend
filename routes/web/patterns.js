/** 
  * @desc this file will define the routes for web pattern
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file patterns.js
*/

const express        = require('express');
const patternService = require('../../services/PatternService');
let router           =  express.Router();

var patternSerObject = new patternService();

// Root folder indexing
router.get('/', isLoggedIn, function(req, res){
	res.redirect('/');
});

// Create new pattern with get method
router.get('/create_pattern', isLoggedIn, function(req, res){
	res.render('patterns/create_pattern');
});

// Save new pattern
router.post('/create_pattern', isLoggedIn, function(req, res){

  	let pattern_title       = req.body.pattern_title;
	let pattern_description = req.body.pattern_description;
	let user_id             = req.body.user_id;
	let pattern_status      = req.body.pattern_status;
	let grid_rows           = req.body.grid_rows;
	let grid_columns        = req.body.grid_columns;
	
	req.checkBody('pattern_title', 'Pattern title is required').notEmpty();
	req.checkBody('pattern_description', 'Pattern description is required').notEmpty();
	req.checkBody('user_id', 'User id is required').notEmpty();
	req.checkBody('pattern_status', 'Pattern status is required').notEmpty();
	req.checkBody('grid_rows', 'Pattern rows is required').notEmpty();
	req.checkBody('grid_rows', 'Pattern rows should be less than or equal to 25').isInt({ max: 25 });
	req.checkBody('grid_columns', 'Pattern columns is required').notEmpty();
	req.checkBody('grid_columns', 'Pattern columns should be less than or equal to 25').isInt({ max: 25 });

	let errors = req.validationErrors();

	if(errors)
	{
		res.render('patterns/create_pattern',{errors: errors});
	}
	else
	{
		let patternData = {
			'pattern_title': pattern_title,
			'pattern_description': pattern_description,
			'user_id': user_id,
			'pattern_status': pattern_status,
			'grid_rows': grid_rows,
			'grid_columns': grid_columns,
		};

		patternSerObject.createPattern(patternData, function(err, patternDataResponse)
		{
			if (err) 
			{ 
				//return done(err); 
				req.flash('error_message','Error Occured: Unable to create new pattern');
			    res.redirect('/patterns/manage_pattern');
			}
			else 
			{
				patternSerObject.createPatternGrid(patternDataResponse, function(err, patternDataGridResponse)
				{
					if (err) 
					{ 
						//return done(err); 
						req.flash('error_message','Error Occured: Unable to create new pattern grid');
						res.redirect('/patterns/manage_pattern');
					}
					else 
					{
						let patternRowData = {
							'stitches_pattern_id': JSON.parse(JSON.stringify(patternDataGridResponse._id)),
							'row_number': grid_rows,
							'row_instruction': ''
						};

						patternSerObject.createPatternInstruction(patternRowData, function(err, patternRowData)
						{
							if (err) 
							{ 
								//return done(err); 
								req.flash('error_message','Error Occured: Unable to create new row instruction');
								res.redirect('/patterns/manage_pattern');
							}
							else 
							{
								req.flash('success_message','Pattern added successfully');
								res.redirect('/patterns/manage_pattern');
							}
						});
					}
				});
			}
		});
	}
});

// List patterns
router.get('/manage_pattern', isLoggedIn, function(req, res){

	patternSerObject.getPatternList(function(err, patternList)
	{
		if (err) 
		{ 
			//return done(err); 
			req.flash('error_message','Error Occured: Unable to fetch patterns list');
			res.redirect('/patterns/manage_pattern');
		}
		else 
		{
			res.render('patterns/manage_pattern', {patternList:patternList});
		}
	});
});

// Get single pattern with pattern id
router.get('/update_pattern/:pattern_id', isLoggedIn, function(req, res){
	
	var pattern_id = req.params.pattern_id; 

	if(pattern_id!="")
	{
		patternSerObject.getPatterById(pattern_id, function(err, patternDetail) 
		{
			if(err) 
			{ 
				req.flash('error_message','Error Occured: Unable to fetch pattern detail');
			    res.redirect('/patterns/manage_pattern');
			}
			res.render('patterns/update_pattern', {patternDetail:patternDetail});
		});
	}
	else
	{
		req.flash('error_message','Error Occured: Pattern id is missing.');
		res.redirect('/patterns/manage_pattern');
	}
});

// Update pattern
router.post('/update_pattern', isLoggedIn, function(req, res){

	var pattern_id          = req.body.pattern_id; 
	let pattern_title       = req.body.pattern_title;
	let pattern_description = req.body.pattern_description;
	let user_id             = req.body.user_id;
	let pattern_status      = req.body.pattern_status;
	let grid_rows           = req.body.grid_rows;
	let grid_columns        = req.body.grid_columns;
	
	req.checkBody('pattern_title', 'Pattern title is required').notEmpty();
	req.checkBody('pattern_description', 'Pattern description is required').notEmpty();
	req.checkBody('user_id', 'User id is required').notEmpty();
	req.checkBody('pattern_status', 'Pattern status is required').notEmpty();
	req.checkBody('grid_rows', 'Pattern rows is required').notEmpty();
	req.checkBody('grid_columns', 'Pattern columns is required').notEmpty();

	let errors = req.validationErrors();

	if(errors)
	{
		patternSerObject.getPatterById(pattern_id, function(err, patternDetail) 
		{
			if(err) 
			{ 
				req.flash('error_message','Error Occured: Unable to fetch pattern detail');
			    res.redirect('/patterns/manage_pattern');
			}
			res.render('patterns/update_pattern', {patternDetail:patternDetail, errors: errors});
		});
		
		// res.render('patterns/update_pattern',{errors: errors});
	}
	else
	{
		let patternData = {
			'pattern_id': pattern_id,
			'pattern_title': pattern_title,
			'pattern_description': pattern_description,
			'user_id': user_id,
			'pattern_status': pattern_status,
			'grid_rows': grid_rows,
			'grid_columns': grid_columns,
		};

		patternSerObject.updatePattern(patternData, function(err, patternData)
		{
			if (err) 
			{ 
				req.flash('error_message','Error Occured: Unable to update pattern detail');
			    res.redirect('/patterns/manage_pattern');
			}
			else 
			{
				req.flash('success_message','Pattern updated successfully');
				res.redirect('/patterns/manage_pattern');
			}
		});
	}
});

//  Delete pattern with id
router.get('/delete_pattern/:pattern_id', isLoggedIn, function(req, res){
	
	var pattern_id = req.params.pattern_id; 

	if(pattern_id!="")
	{
		patternSerObject.deletePattern(pattern_id, function(err, patternDetail) 
		{
			if(err) 
			{ 
				req.flash('error_message','Error Occured: Unable to delete pattern detail');
			    res.redirect('/patterns/manage_pattern');
			}
			else
			{
				patternSerObject.deletePatternGrid(pattern_id, function(err, patternDetail) 
				{
					if(err) 
					{ 
						req.flash('error_message','Error Occured: Unable to delete pattern grid');
						res.redirect('/patterns/manage_pattern');
					}
					else
					{
						patternSerObject.deletePatternInstruction(pattern_id, function(err, patternDetail) 
						{
							if(err) 
							{ 
								req.flash('error_message','Error Occured: Unable to delete pattern instruction');
								res.redirect('/patterns/manage_pattern');
							}
							else
							{
								req.flash('success_message','Pattern deleted successfully');
								res.redirect('/patterns/manage_pattern');
							}
						});
					}
				});
			}
		});
	}
	else
	{
		req.flash('error_message','Error Occured: Pattern id is missing.');
		res.redirect('/patterns/manage_pattern');
	}
});

// Display pattern grid
router.get('/manage_pattern_grid/:pattern_id', isLoggedIn, function(req, res){
	
	var pattern_id = req.params.pattern_id; 

	if(pattern_id!="")
	{
		patternSerObject.getPatterById(pattern_id, function(err, patternData) 
		{
			if(err) 
			{ 
				req.flash('error_message','Error Occured: Unable to fetch pattern design');
			    res.redirect('/patterns/manage_pattern');
			}
			else
			{
				patternSerObject.getPatternDesign(pattern_id, function(err, patternDesignData) 
				{
					if(err) 
					{ 
						req.flash('error_message','Error Occured: Unable to fetch pattern grid design');
						res.redirect('/patterns/manage_pattern');
					}
					else
					{
						patternSerObject.getPatternInstructions(pattern_id, function(err, patternDesignInstruction) 
						{
							if(err) 
							{ 
								req.flash('error_message','Error Occured: Unable to fetch pattern grid instructions');
								res.redirect('/patterns/manage_pattern');
							}
							else
							{
								patternSerObject.getGridColor(function(err, patternDesignColor) 
								{
									if(err) 
									{ 
										req.flash('error_message','Error Occured: Unable to fetch pattern grid color');
										res.redirect('/patterns/manage_pattern');
									}
									else
									{
										patternSerObject.getGridType(function(err, patternDesignType) 
										{
											if(err) 
											{ 
												req.flash('error_message','Error Occured: Unable to fetch pattern grid type');
												res.redirect('/patterns/manage_pattern');
											}
											else
											{
												res.render('patterns/manage_pattern_grid', {patternData:patternData, patternDesignData:patternDesignData, patternDesignColor:patternDesignColor, patternDesignType:patternDesignType, patternDesignInstruction:patternDesignInstruction, customHelper: require('../../helpers/custom_helper')});
											}
										});
									
									}
								});
							}
						});
					}
				});
			}
		});
	}
	else
	{
		req.flash('error_message','Error Occured: Pattern id is missing.');
		res.redirect('/patterns/manage_pattern');
	}
});

// Update single pattern grid
router.post('/update_gridbox', isLoggedIn, function(req, res){

	let gridbox     = req.body.gridbox; 
	let stitche_color = req.body.stitche_color;
	let stitche_type  = req.body.stitche_type;

	if(!gridbox) 
	{
		return res.send({
			status: 400,
			message: 'Grid Box is required',
		});
	}

	if(!stitche_color) 
	{
		return res.send({
			status: 400,
			message: 'Color is required',
		});
	}

	if(!stitche_type) 
	{
		return res.send({
			status: 400,
			message: 'Stitche type is required',
		});
	}	


	let patternGridData = {
		'gridbox': gridbox,
		'stitche_color': stitche_color,
		'stitche_type': stitche_type,
	};
	
	patternSerObject.updateGridValue(patternGridData, function(err, patternGridData)
	{
		if (err) 
		{ 
			res.send({
				status: 500,
				message: "something went wrong.",
			});
		}
		else 
		{
			res.send({
				status: 200,
				message: 'Grid has been updated',
				gridvalue: patternGridData
			});
		}
	});
});

// Save single row instruction
router.post('/update_rowinstruction', isLoggedIn, function(req, res){

	let pattern_id = req.body.pattern_id;
	let row_id     = req.body.row_id; 
	let row_instruction  = req.body.row_instruction;

	if(!pattern_id) 
	{
		return res.send({
			status: 400,
			message: 'Pattern id is required',
		});
	}

	if(!row_id) 
	{
		return res.send({
			status: 400,
			message: 'Row id is required',
		});
	}

	if(!row_instruction) 
	{
		return res.send({
			status: 400,
			message: 'Instruction is required',
		});
	}	


	let patternRowData = {
		'pattern_id': pattern_id,
		'row_id': row_id,
		'row_instruction': row_instruction,
	};
	
	patternSerObject.updateRowInstruction(patternRowData, function(err, patternRowData)
	{
		if (err) 
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
				message: 'Instruction saved successfully',
			});
		}
	});
});

function isLoggedIn(req, res, next){
	if(req.isAuthenticated()){
        next();
	}
	else{
       res.redirect("/users/login");
    }
}


module.exports = router;