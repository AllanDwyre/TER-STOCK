const express = require("express");
const router = express.Router();
const authController = require("../controller/authController.js");

router.post('/login', authController.login);
router.post('/register',authController.signup);
router.post('/otp',authController.verifOTP);
router.get('/homePage', authController.home);

//crud
//blabla


module.exports = router;

