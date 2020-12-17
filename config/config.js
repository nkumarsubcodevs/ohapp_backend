/**
 * @desc this file will hold all basic configuration settings related to the database and email
 * @author Navneet Kumar navneet.kumar@subcodevs.com
 * @file config.js
 */

module.exports = {
  site_url: "http://localhost:5000/",
  site_logo: "http://localhost:5000/images/logosite.png",
  signUp_Template_Image: "http://localhost:5000/images/header.png",

  postgres_host: "localhost",
  postgres_database: "ohhp_app",
  //postgres_database: "oh_app",
  postgres_username: "postgres",
  postgres_password: "postgres",
  postgres_port: "5432",

  from_email: "david@powerofzero.com",
  email_service: "gmail",
  gmail_id: "david@powerofzero.com",
  gmail_password: "bdspk6589g@2020",
  secret: "ohapp_api",
  refreshsecret: "ohapp_refresh_api",
  port_no: "5000",
  chat_port_no: "8089",
  send_grid_api_key: "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",

  firebase_server_key:
    "AAAANwmhdEg:APA91bGIYZ9BUWBX_tz42Sr-zHHC6p7zSz7zrlVn5ZTNaeqcyChIp0QD6YEKOO0BLGZGtnWL2Ij8cEXjy-YY1IqtpHIHFwflRZDnqB5h16hqFKue1H6Ihf208uzmMicc2i77andcQgFl",

  forgot_password_template: "/var/www/html/oh_app/email_templates/forgot_password.html",
  signup_template: "/var/www/html/oh_app/email_templates/signup.html",

  client_email: "ohintimacyserviceacc@api-6455671790729840738-24907.iam.gserviceaccount.com",
  private_key:
    "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQC+NUX4BmO0fnUt\nyxFtPa+GKDR6wrzdlqo/Z0vlVaRsQexwVUew9yu5Rwf4J44CE6OH49Vi3xMMVpsr\nPwXJiQ7V7eGTLUtUQCw3fwB7g04XoMxsgDTgljeyWYU/NsNiUmjPHPvHNqNNC5DZ\ndi62xMl0guqfvrRFbyWUDXsPiYP28rxBqqA1l+LVKOEQqhULCgkL2zew9rPq/o5D\nXRw0pIq1J5VLTk85jcCMwyrOOJ8j+9uNKzIBMozXR6/0VIeMPFUDfceRyWS6iVJC\ns1bLRerHxCGMSuOFD+mY9j8DyMfIjFkaVyIgQE/Z9btKXhVLiAJZL8aK5DbybenO\nmcdLSBNZAgMBAAECggEAAmbcT3jPLsyI/Y8xCDFAkEzDxHtFVMJhO6ptGip/ofe4\n8CTKu+iT5moUwIfi7zitw2dd8eEEvDT/9RoXRqrCvSW2YaKJCLmQ68UToO7XYEBN\n/7gkhf1Hm0QuBOgTxZ/qRf4LWah7A+ixOpm9ycRVRRgd6KH8SnZc+5AqNv5Cyq4g\nGQNgr9FCueC690LVAi0Z+AvCGDQV78HkoEP9Mi8FfkGX7FCNaDGMbUqkKcCRcihZ\n92ZhsT9p1ix6SpApgCGFS2oQrRyUi/mnTozSuu8usG71lJbOjXwIx9eC4qD23sFD\n1Gxmxqj2kCVjhII6ks++Q+F91cSr4EdjH1oApoCxIQKBgQDwEP3Sp7OxYwEu8Nyz\n1GHj0L5427j2u/HB23mvLHPs16flvL4O4Pf/lof1y6Ig/FlvLtkQK2V8MOiDWj5a\nko/IJz6IGFUfEmk0Hb6wIuQHJFIt9hVD+Erl7O38+YyhI8iwIePkOXc+VWkEtADv\nmp6at2GPSn/0Uey38BIFFVUDcQKBgQDK1SGkrPNaaDEt4Y/z7yXxXqXZ1dm68XMq\nnV6qhesk/q4r6W0eScfwX0+PhuqylMXaACQKt8bx37Rs8uoe1x0JTLzwQgRo38rW\nHJ/9JhjYW52A1cTKoQ0iRhbpobjlOeul2YVycMXgAQPKxeVnkclJTwG7jmBBh1nE\npHFUk5tKaQKBgD+s0hZY4wGu9/ZibrfIInrRuGPIK+RN747yzvDWwpzUirUV/fdm\nVoFVhRR+Aa/sHzCtZWeziwSI2HNWsWlGrJpzRlPE2HcYZA0twpFnf8IhMSb9uaBA\nsGUSFgHekx1+p1GIe7DiSS2ga+2SbRkgkucIsvjV0uCUBky3gaAVi2oRAoGAeZM6\ncSxBSSU+pROYZ0wm4AAtRN6LfSQQNbDR90AB69DDsQpfH1J2Bzv5wjvKHXRTCxIe\niFYTZxMBYHRRpF6nxtU6QoAviHTrbV8G/oOBTN3NEFYReKsD5lFAlpUa8DrBZk11\nUV0LHfM9xKLNmECn98rlbPgv9dcdFWLDk0BOSlECgYBFCTggHCuICkpmQsqPdRR5\nX08PvAxHs4kgCdo440pZOkr9FzqYfOp+FDMT05eaowI1aBl2StjtsXuBgfeTZSYP\nar7WutJkhJnZ04Y2Y2mXLkVR7chrLZBtCu8IKvD2W8v40WK/onYA89EL2FyfGgx4\n/iFhg6xi3BIluLICqg3n2Q==\n-----END PRIVATE KEY-----\n",
};
