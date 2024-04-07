const express = require("express");
const router = express.Router();
const authController = require("../controller/authController.js");
//const controllerTest = require("../controller/controllerTest.js");

router.post('/login/Name', authController.loginUserName);
router.post('/login/Email',authController.signUpEmail);
router.get('/homePage', authController.home);
//router.post('/login/FirstName',authController.loginFirstName);
router.post('/signupDate',authController.signupDate);
router.post('/signupTel', authController.signupTel);
router.post('/otp',authController.verifOTP);

module.exports = router;


//pour le test 
//router.post('/login',controllerTest.loginName);