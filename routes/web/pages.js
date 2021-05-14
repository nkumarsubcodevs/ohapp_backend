/**
 * @desc this file will define the routes for web pages
 * @author Navneet Kumar navneet.kumar@subcodevs.com
 * @file page.js
 */

const express = require("express");
const PageService = require("../../services/PageService");
const GoalService = require("../../services/GoalService");
const custom_helper = require("../../helpers/custom_helper");
const formValidator = require("validator");

let router = express.Router();
var pageSerObject = new PageService();
var GoalObject = new GoalService();

var sessionChecker = (req, res, next) => {
  if (!req.session.passport) {
    res.redirect("/");
  } else {
    next();
  }
};

// page listing
router.get("/:page", sessionChecker, function (req, res) {
  var perPage = 10;
  var page = req.params.page || 1;

  let paginationData = {
    offset: perPage * page - perPage,
    limit: perPage,
  };

  GoalObject.getQuestion(paginationData, function (err, pageData) {
    if (pageData) {
      if (err) {
        req.flash("error_message", "Error Occured: Unable to fetch page list");
      } else {
        const itemCount = pageData.count;
        res.render("pages/pages", {
          custom_helper: custom_helper,
          pageDataValue: pageData.rows,
          current: page,
          route_page: "/pages",
          pages: Math.ceil(itemCount / perPage),
        });
      }
    }
  });
});

router.get("/edit/:id", sessionChecker, function (req, res) {
  var page_id = req.params.id;
  GoalObject.getSingleQuestionRecord(page_id, function (err, pageData) {
    if (err) {
      req.flash("error_message", "Unable to fetch page detail");
    } else {
      GoalObject.GetOptionByQuestionId(page_id, function (Err, data) {
        if (err) {
          req.flash("error_message", "Unable to fetch page detail");
        } else {
          res.render("pages/updatelistPages", {
            pageValue: pageData,
            option: data,
            custom_helper: custom_helper,
          });
        }
      });
    }
  });
});
router.post("/update", sessionChecker, function (req, res) {
  var page_id = req.body.page_id;
  var title = req.body.title;
  var status = req.body.status;
  var update_time = req.body.update_time;
  var option = req.body.Option;

  title = title[0].toUpperCase() + title.slice(1);
  GoalObject.updateQuestion(title, req.body.descripation, true, page_id);
  GoalObject.removeOption(page_id, function (err, RemoveOption) {
    if (err) {
      res.send({
        status: 404,
        message: "Something Went worn",
      });
    } else {
      if (RemoveOption) {
        GoalObject.setQuestionOptions(
          option,
          page_id,
          function (err, response) {
            if (err) {
              req.flash("error_message", "Something went wrong");
            } else {
              req.flash("success_message", "Updated Successfully");
              res.redirect("/pages/1");
            }
          }
        );
      }
    }
  });
});
router.get("/add/:pages?", sessionChecker, function (req, res) {
  res.render("pages/addlist", {
    option: 7,
    step: 1,
  });
});
router.get("/add/options/:data", sessionChecker, function (req, res) {
  res.render("pages/addlist", {
    option: parseInt(req.params.data) + 1,
    step: 1,
  });
});

router.post("/add/question", sessionChecker, function (req, res) {
  var title = req.body.title;
  var status = req.body.status;
  var descripation = req.body.descripation;
  var options = req.body.Option;
  var optionLength = options.filter((ees) => ees != "");
  let questionData = {
    question_title: title[0].toUpperCase() + title.slice(1),
    question_descripation: descripation,
    iscustom: status,
  };


  let rrr = optionLength.length !== 0;
  if (rrr) {
    GoalObject.saveQuestionaries(questionData, function (err, response) {
      if (err) {
        req.flash("error_message", "Something went wrong");
      } else {
        if (response) {
          GoalObject.setQuestionOptions(
            options,
            response.id,
            function (err, SaveOption) {
              req.flash("success_message", "saved Successfully..");
              res.redirect("/pages/1");
            }
          );
        }
      }
    });
  } else {
    req.flash("error_message", "Please enter minimum one option");
    res.render("pages/addlist", {
      option: 7,
      step: 2,
      title: title,
      descripation: descripation,
      error: "Please enter valid options",
      status: status,
    });
  }
  //   } else {
  //     GoalObject.saveQuestionaries(pageData, function (err, response) {
  //       if (err) {
  //         req.flash("error_message", "Something went wrong");
  //       } else {
  //         if (response) {
  //           // GoalObject.setQuestionOptions(option, response.id, function(err, SaveOption) {
  //           req.flash("success_message", "saved Successfully");
  //           res.redirect("/pages/1");
  //           // })/
  //         }
  //       }
  //     });
  //   }
  // GoalObject.saveQuestionaries(pageData , function(err, response){
  // 	if(err)
  // 	{
  // 		req.flash('error_message','Something went wrong');
  // 	}else{
  // 		if(response) {
  // 			GoalObject.setQuestionOptions(option, response.id, function(err, SaveOption) {
  // 				req.flash('success_message','saved Successfully');
  // 				res.redirect('/pages/1');
  // 			})
  // 		}
  // 	}
  // });
});
router.get("/option/:id?", sessionChecker, function (req, res) {
  var page_id = req.params.id;

  GoalObject.GetQuestion(page_id, function (err, pageData) {
    if (err) {
      req.flash("error_message", "Unable to fetch page detail");
    } else {
      res.render("pages/optionlist", {
        pageValue: pageData,
        custom_helper: custom_helper,
      });
    }
  });
});
router.post("/option", sessionChecker, function (req, res) {
  var title = req.body.title;
  var id = req.body.question_id;
  GoalObject.SaveQuetionOption(title, id, function (err, response) {
    if (err) {
      req.flash("error_message", "Something went wrong");
    } else {
      req.flash("success_message", "Option Added Successfully");
      res.redirect("/pages/1");
    }
  });
});
router.get("/delete/:id", sessionChecker, function (req, res) {
  var id = req.params.id;
  GoalObject.removeQuestionaries(id, function (err, response) {
    if (err) {
      req.flash("error_message", "Something went wrong");
    } else {
      if (response) {
        GoalObject.removeOption(id, function (err, response) {
          if (err) {
            req.flash("error_message", "Something went wrong");
          } else {
            if (response) {
              GoalObject.removeQuestionariesAnswer(
                id,
                function (err, response) {
                  if (err) {
                    req.flash("error_message", "Something went wrong");
                  } else {
                    if (response) {
                      req.flash("error_message", "Option delete Successfully");
                      res.redirect("/pages/1");
                    } else {
                      req.flash("error_message", "Something went wrong");
                    }
                  }
                }
              );
            } else {
              req.flash("error_message", "Something went wrong");
            }
          }
        });
      } else {
        req.flash("error_message", "Something went wrong");
      }
    }
  });
});
router.get("/view/:id/:page", sessionChecker, function (req, res) {
  let id = req.params.id;
  var perPage = 5;
  var page = req.params.page || 1;

  let paginationData = {
    offset: perPage * page - perPage,
    limit: perPage,
  };

  GoalObject.getQuestionOption(paginationData, id, function (err, pageData) {
    if (pageData) {
      if (err) {
        req.flash("error_message", "Error Occured: Unable to fetch page list");
      } else {
        const itemCount = pageData.count;
        res.render("pages/optionview", {
          custom_helper: custom_helper,
          pageDataValue: pageData.rows,
          current: page,
          route_page: "/optionview",
          pages: Math.ceil(itemCount / perPage),
        });
      }
    }
  });
});

module.exports = router;
