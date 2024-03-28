const Auth = require("../model/auth");
require("dotenv").config();
const KEY = process.env.DEV_KEY;
var jwt = require('jsonwebtoken');

module.exports = {
    loginName: function (req, res) {
        Auth.selectLogInName(req.connection, req.body.username, function (err, row) {
            res.redirect('/loginFirstName');
        })
    },

    loginFirstName: function (req, res) {
        Auth.selectLogInFirstName(req.connection, req.body.user_first_name, function (err, row) {
            if (row != undefined && row.length){
                res.redirect('/loginEmail');
            }else {
                res.redirect('/signupDate');
            }
        });
    },


    loginEmail: function (req,res){
        Auth.selectLogInEmail(req.connection, req.body.usermail, function(err,row){
            if (row != undefined && row.length){
                var payload = {
                    usermail: reqbody.usermail,
                };
                var token = jwt.sign(payload, KEY, { algorithm: 'HS256', expiresIn: "15d" });
                res.send(token);
                res.redirect('/verifTel');
            }else {
                res.send("Aucun email existant");
                res.redirect('/signupDate');
            }
        })
    },

    home: function (req, res) {
        var str = req.get('Authorization');
        try {
            jwt.verify(str, KEY, { algorithm: 'HS256' });
            res.send("Welcome");
        } catch {
            res.status(401);
            res.send("Bad Token");
        }
    },

    signupDate: function(req,res){
        res.status(202);
        res.send("Success");
        res.redirect('/signupTel');
    },


    signupTel: function(req,res){
        Auth.selectSignUpTel(req.connection, req.body.user_tel, function (err, row) {
            if(row != undefined && row.length){
                res.status(402);
                res.send("Téléphone déjà utilisé");
            }else{
                res.status(201);
                res.send("Success");
                res.redirect('/verifTel');
    
            }
        });
    },

    verifTel: function(req,res){
        //API Verif tel par code SMS
        //if(/*API*/){
            Auth.insert(req.connection, req.body.username, req.body.usermail, req.body.user_date,
                 req.body.user_tel, function (err, result){
                    if(err) throw(err);
            });
            res.status(201);
            res.send("Success");
            res.redirect('/home');
        /*}else{
            res.status(403);
            res.send("Code mauvais")  
        }*/
        }

};