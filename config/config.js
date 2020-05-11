/** 
  * @desc this file will hold all basic configuration settings related to the database and email
  * @author Navneet Kumar navneet.kumar@subcodevs.com
  * @file config.js
*/

module.exports = {
  'site_url': 'http://localhost:5000/',
  'site_logo': 'http://localhost:5000/images/logosite.png',

  'postgres_host': 'localhost',
  'postgres_database': 'ohhp_app',
  'postgres_username': 'postgres',
  'postgres_password': 'postgres',
  'postgres_port': '5432',

  'from_email': 'navneet.kumar@subcodevs.com',
  'email_service': 'gmail',
  'gmail_id': 'subcodevsd@gmail.com',
  'gmail_password': 'subcodevs@1234',
  'secret': 'ohapp_api',
  'refreshsecret': 'ohapp_refresh_api',
  'port_no': '5000',
  'chat_port_no': '8089',

  'firebase_server_key': "AAAANoLOdrc:APA91bEyYqIWV8aMAzw3s6hDijw0rW3FZMUxjW_mn1x9rGx2JptwqhwXpWKxrFUI9W3SH3DqdNbZNMlvKtYrHwVXBNk8b6NfdZLE78KI7dYIKogISqf-3btDCaAoL_3JERMkNIMvFrVP",

  'forgot_password_template': '/var/www/html/oh_app/email_templates/forgot_password.html',
  'signup_template': '/var/www/html/oh_app/email_templates/signup.html',
}; 