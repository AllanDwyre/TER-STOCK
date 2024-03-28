const Auth = require("../model/auth");
require("dotenv").config();
const KEY = process.env.DEV_KEY;
var jwt = require('jsonwebtoken');
const { v4: uuidv4 } = require('uuid');

module.exports = {
    loginName: function (req, res) {
        const { firstname } = req.body;
        // Stocker le prénom dans la session
        req.session.firstname = firstname;
        res.redirect('/loginFirstName');
        
    },

    loginFirstName: function (req, res) {
        const { name } = req.body;
        const firstname = req.session.firstname; // Récupérer le prénom depuis la session

        // Concaténer le prénom et le nom de famille pour former le nom complet
        req.session.username = firstname + name;

        // Rediriger vers la page de saisie de l'email
        res.redirect('/loginEmail');

    },


    loginEmail: function (req,res){
        Auth.selectLogInEmail(req.connection, req.body.usermail, function(err,row){
            if (row != undefined && row.length){
                Auth.selectLogInName(req.connection, req.session.username, function(err,row){
                    if(row != undefined && row.length){
                        // Le nom d'utilisateur existe déjà, générer une nouvelle concaténation avec un compteur
                        let counter = 2;
                        let newUsername = req.session.username + counter;

                        // Vérifier si la nouvelle concaténation existe
                        while (row != undefined && row.length) {
                            newUsername = req.session.username + counter;
                            counter++;
                        }

                        // Enregistrer le nouveau nom d'utilisateur dans une variable pour l'utiliser plus tard
                        req.session.newUsername = newUsername;
                    }else{
                        // Le nom d'utilisateur n'existe pas encore, utiliser la concaténation actuelle
                        req.session.newUsername = req.session.username;
                    }
                });

                var payload = {
                    usermail: req.body.usermail,
                    //usermail : reqbody.usermail,
                };
                var token = jwt.sign(payload, KEY, { algorithm: 'HS256', expiresIn: "15d" });
                res.send(token);
                res.redirect('/verifTel');
            }else {
                req.session.usermail = req.body.usermail;
                res.send("Aucun email existant, veuillez créer votre compte");
                res.redirect('/signupDate');
            }
        });
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
        const {date} = req.body;
        req.session.date = date;
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
                req.session.user_tel = req.body.user_tel;
                res.status(201);
                res.send("Success");
                res.redirect('/verifTel');
    
            }
        });
    },

    verifTel: function(req,res){
        //API Verif tel par code SMS
        //if(/*API*/){
            const userId = uuidv4().replace(/[^0-9]/g, '');
            const username = req.session.newUsername;
            const usermail = req.session.usermail;
            const userdate = req.session.date;
            const usertel = req.session.user_tel;

            Auth.insert(req.connection, userId, username, usermail, userdate, usertel, function (err, result){
                    if(err) throw(err);
            });
            res.status(201);
            res.send("Votre compte a été créé avec succès !");
            res.redirect('/home');
        /*}else{
            res.status(403);
            res.send("Code mauvais")  
        }*/
        }

};
