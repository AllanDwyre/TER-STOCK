const Auth = require("../model/auth");
const { User } = require('../model/users');
require("dotenv").config();
const KEY = process.env.DEV_KEY;
var jwt = require('jsonwebtoken');
const { v4: uuidv4 } = require('uuid');
const otpGenerator = require('otp-generator');

module.exports = {
    loginUserName: function (User, USER_ID) {
        console.log("page login");
    
        // Créer une promesse pour attendre la saisie de l'utilisateur
        const waitForUserId = new Promise((resolve, reject) => {
            const { userId } = req.body; // Changer la variable firstname en userId
            if (userId) {
                // Si un USER_ID est fourni, résoudre la promesse avec le USER_ID
                resolve(userId);
            } else {
                // Si aucun USER_ID n'est fourni, rejeter la promesse avec une erreur
                reject(new Error("Aucun USER_ID fourni"));
            }
        });
    
        // Attendre que la promesse soit résolue ou rejetée
        waitForUserId.then((userId) => {
            // Utiliser la fonction selectLogInUserID du fichier auth.js pour trouver l'utilisateur par USER_ID
            Auth.selectLogInUserID(User, userId)
                .then((user) => {
                    if (user) {
                        // Stocker le USER_ID dans la session
                        req.session.USER_ID = user.USER_ID; // Assurez-vous que le nom de la session correspond à votre modèle de données
                        // Rediriger vers '/loginFirstName'
                        res.redirect('/loginFirstName');
                    } else {
                        // Si aucun utilisateur correspondant n'est trouvé, renvoyer une erreur
                        throw new Error("Utilisateur non trouvé pour USER_ID : " + userId);
                    }
                })
                .catch((error) => {
                    // Gérer les erreurs, par exemple en renvoyant une réponse d'erreur
                    res.status(400).send("Erreur : " + error.message);
                });
        }).catch((error) => {
            // Gérer les erreurs, par exemple en renvoyant une réponse d'erreur
            res.status(400).send("Erreur : " + error.message);
        });
    },




    signupEmail: function (req,res){
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

    signupEmail: function (req, res) {
        Auth.selectLogInEmail(User, req.body.usermail)
            .then(user => {
                if (user) {
                    
                } else {
                    // Le courriel n'existe pas encore
                    // Votre code pour gérer cela
                }
            })
            .catch(err => {
                // Gérer les erreurs
                console.error(err);
                res.status(500).send("Une erreur s'est produite.");
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

    verifOTP: function(req,res){
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
