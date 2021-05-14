/** 
  * @desc this file will define the function to run the chat system
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file chat_handler.js
*/

const express     = require('express');
const current_datetime = require('date-and-time');
const formValidator = require('validator');

const msgService = require('../services/MessageService');
const userService = require('../services/UserService');

const customHelper = require('../helpers/custom_helper');
const config   = require('../config/config');
const CHATPORT = config.chat_port_no;

const app  = express();

// Create model object
var msgSerObject  = new msgService();
var userSerObject = new userService();

// Chat System Setup and Import
const http = require('http').Server(app);
const io = require('socket.io')(http);

io.sockets.on('connection', function(socket) {

    // Get Socket Connection Details
    console.log("Total Connected Users: ",io.engine.clientsCount);
   
    Object.keys(io.sockets.sockets).forEach(function(id) {
        console.log("ID: ->",id);
    });
    // Get Socket Connection Details

    socket.on('username', function(userData) {

        var error_flag = 0;

        if(!userData.user_id) 
        {
            error_flag = 1;
            io.to(socket.id).emit('chat_message','User Id is required.'); 
        }
        else if(!formValidator.isInt(userData.user_id))   
        {
            error_flag = 1;
            io.to(socket.id).emit('chat_message','Please enter a valid user id.'); 
        }

        if(!userData.room_id) 
        {
            error_flag = 1;
            io.to(socket.id).emit('chat_message','Room Id is required.'); 
        }
        else if(!formValidator.isInt(userData.room_id))   
        {
            error_flag = 1;
            io.to(socket.id).emit('chat_message','Please enter a valid room id.'); 
        }

        if(error_flag===0)
        {   
            let userInput = {
                'user_id':userData.user_id,
                'room_id': userData.room_id,
            };
            
            userSerObject.getUserById(userData.user_id, function(err, singleUserData)
            {
                if(err)
                {
                    io.to(userData.room_id).emit('is_online', 'no user found with this user id.');
                }
                else
                {
                    // join the socket at given unique identifier for both party
                    socket.join(userData.room_id);
    
                    var username = singleUserData.first_name+" "+singleUserData.last_name;
    
                    io.to(userData.room_id).emit('is_online', '🔵 <i>' + username + ' join the chat.</i>');
                }
            });  
        }
    });

    socket.on('chat_message', function(messageData) {

        var error_flag = 0;

        if(!messageData.goal_id) 
        {
            error_flag = 1;
            io.to(socket.id).emit('chat_message','Goal Id is required.'); 
        }
        else if(!formValidator.isInt(messageData.goal_id))   
        {
            error_flag = 1;
            io.to(socket.id).emit('chat_message','Please enter a valid goal id.'); 
        }

        if(!messageData.sender_id) 
        {
            error_flag = 1;
            io.to(socket.id).emit('chat_message','Sender Id is required.'); 
        }
        else if(!formValidator.isInt(messageData.sender_id))   
        {
            error_flag = 1;
            io.to(socket.id).emit('chat_message','Please enter a valid sender id.'); 
        }

        if(!messageData.receiver_id) 
        {
            error_flag = 1;
            io.to(socket.id).emit('chat_message','Receiver id is required.'); 
        }
        else if(!formValidator.isInt(messageData.receiver_id))   
        {
            error_flag = 1;
            io.to(socket.id).emit('chat_message','Please enter a valid receiver id.'); 
        }

        if(!messageData.message) 
        {
            error_flag = 1;
            io.to(socket.id).emit('chat_message','Message is required.'); 
        }
        else if(messageData.message.length>150)   
        {
            error_flag = 1;
            io.to(socket.id).emit('chat_message','Message maximum length should be 150 characters.'); 
        }

        if(error_flag===0)
        {
            const now = new Date();
            var am_pm_format = now.getHours() >= 12 ? 'pm' : 'am';  
    
            var encoded_msg = customHelper.h_getChatMsgEncode(messageData.message);
            var crnt_dtime = current_datetime.format(now, 'YYYY-MM-DD hh:mm:ss');
            var crnt_time  = current_datetime.format(now, 'hh:mm')+" "+am_pm_format;
            
            let messageInput = {
                'goal_id': messageData.goal_id,
                'sender_id': messageData.sender_id,
                'receiver_id': messageData.receiver_id,
                'message': encoded_msg,
                'create_time': crnt_dtime,
                'update_time': crnt_dtime,
            };

            userSerObject.getUserById(messageData.sender_id, function(err, singleUserData)
            {
                if(err)
                {
                    io.to(messageData.room_id).emit('is_online', 'no user found with this user id.');
                }
                else
                {
                    msgSerObject.saveChatMessage(messageInput, function(err, msgDataSaved)
                    {
                        if(err)
                        {
                            io.to(messageData.room_id).emit('chat_message', 'something went wrong.');
                        }
                        else
                        {
                            var username = singleUserData.first_name+" "+singleUserData.last_name;

                            console.log('chat_message', 'message saved in db for '+username);

                            io.to(messageData.room_id).emit('chat_message', '<strong>' + username + ' ('+crnt_time+')</strong>: ' + messageData.message);
                        }
                    });       
                }
            });    
        }
    });

    socket.on('disconnect', function(username) {
        // socket.leave('1580277029598');
        io.emit('is_online', '🔴 <i>' + socket.username + ' left the chat..</i>');
    });
});

const server = http.listen(CHATPORT, function() {
    console.log('OH chat socket listening on port: ', CHATPORT);
});