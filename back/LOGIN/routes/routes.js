const express = require("express");
const router = express.Router();
const authController = require("../controller/authController.js");
const controllerTest = require("../controller/controllerTest.js");

router.post('/login/Name', authController.loginUserName);
//pour le test 
router.post('/login',controllerTest.loginName);

router.post('/login/Name', authController.loginName);
router.post('/login/FirstName',authController.loginFirstName);
router.post('/login/Email',authController.signupEmail);
router.get('/homePage', authController.home);
router.post('/signupDate',authController.signupDate);
router.post('/signupTel', authController.signupTel);
router.post('/otp',authController.verifOTP);

module.exports = router;