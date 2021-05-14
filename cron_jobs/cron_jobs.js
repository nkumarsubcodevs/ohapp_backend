/** 
  * @desc this file will define the function to run the cron job
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file cron_job.js
*/

var CronJob = require('cron').CronJob;
const userService = require('../services/UserService');
const customHelper = require('../helpers/custom_helper');

// Create user model object
var userSerObject = new userService();

var job = new CronJob('* * * * * *', function() {
  
  userSerObject.getCronJobUserList(function(err, userListData) 
  {
      if(err)
      {
          res.send({
            status: 500,
            message: 'something went wrong',
          });
      }

      if(userListData)
      {	
          userListData.forEach(element => {

             var remaining_time = (new Date().getTime()) - new Date(element.create_time).getTime(); 

             if(remaining_time>1797000)
             {
                  let user_detail = {
                    'user_id': element.id,
                  };

                  userSerObject.freeSecurityCodesForCron(user_detail, function(err, userData) 
                  {
                        if(err)
                        {
                            res.send({
                              status: 500,
                              message: 'something went wrong',
                            });
                        }
                  
                        if(userData)
                        {
                            console.log("Record updated for user_id: "+element.id+" and email: "+element.email);
                        }
                        else
                        {
                            res.send({
                              status: 404,
                              message: 'No user found.',
                            });
                        }
                  });  
             }
          });
      }
      else
      {
          res.send({
            status: 404,
            message: 'No user list found.',
          });
      }
  });

}, null, true, 'America/Los_Angeles');

job.start();


var job2 = new CronJob('* * * * * *', function() {
  
 // console.log('sdadas');

}, null, true, 'America/Los_Angeles');

job2.start();

