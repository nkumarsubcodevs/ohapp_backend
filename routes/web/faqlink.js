/**
 * @desc this file will define the routes for web faq
 * @author Navneet Kumar navneet.kumar@subcodevs.com
 * @file page.js
 */

const express = require("express");
const faqlinkService = require("../../services/faqlinkservices")
const custom_helper = require("../../helpers/custom_helper");
const formValidator = require("validator");

let router = express.Router();

var FaqObject = new faqlinkService();
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
        offset: (perPage * page) - perPage,
        limit: perPage,
    };

    FaqObject.getFaqLInk(paginationData, function (err, pageData) {
        if (pageData) {
            if (err) {
                req.flash("error_message", "Error Occured: Unable to fetch page list");
            } else {
                const itemCount = pageData.count;
                res.render("faqlink/pages", {
                    custom_helper: custom_helper,
                    pageDataValue: pageData.rows,
                    current: page,
                    route_page: "/faqlink",
                    pages: Math.ceil(itemCount / perPage),
                });
            }
        }
    });
});



router.get("/edit/:id", sessionChecker, function (req, res) {
    var page_id = req.params.id;

    FaqObject.Getfaqbyid(page_id, function (err, data) {
        if (err) {
            req.flash("error_message", "Unable to fetch page detail");
        } else {
            res.render("faqlink/updatelistpages", {
                option: data,
                custom_helper: custom_helper,
            });
        }


    });
});
router.post("/update", sessionChecker, function (req, res) {
    var id = req.body.page_id;
    var title = req.body.title[0];
    var link = req.body.title[1];
    FaqObject.updateFAQ(title, link, id, function (err, response) {
        if (err) {
            req.flash("error_message", "Something went wrong");
        } else {
            console.log("success")
            req.flash("success_message", "Updated Successfully");
            res.redirect("/faqlink/1");
        }


    })
});
router.get("/add/:faq?", sessionChecker, function (req, res) {
    res.render("faq/addlist", {
        option: 7,
        step: 1,
    });
});




router.post("/add/faq", sessionChecker, function (req, res) {
    var title = req.body.title;
    var description = req.body.description;

    FaqObject.saveMessages(title, description, function (err, response) {
        if (err) {
            req.flash("error_message", "Something went wrong");
        } else {
            req.flash("success_message", "FAQ Added Successfully");
            res.redirect("/faq/1");
        }
    });


});

router.get("/delete/:id", sessionChecker, function (req, res) {
    var id = req.params.id;

    FaqObject.removeFAQ(id, function (err, response) {
        if (err) {
            req.flash("error_message", "Something went wrong");
        } else {
            if (response) {
                req.flash("success_message", "FAQ delete Successfully");
                res.redirect("/faqlink/1");
            } else {
                req.flash("error_message", "Something went wrong");
            }
        }
    })
});



module.exports = router;
