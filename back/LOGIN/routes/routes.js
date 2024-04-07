const express = require("express");
const router = express.Router();
const authController = require("../controller/authController.js");

router.post('/login/UserName', authController.loginUserName);
router.post('/signUp/FirstName',authController.signUpFirstName);
router.post('/signUp/Email',authController.signUpEmail);
router.post('/signup/Date',authController.signupDate);
router.post('/signup/Tel', authController.signupTel);
router.post('/otp',authController.verifOTP);
router.get('/homePage', authController.home);

module.exports = router;

