const Auth = require("../model/auth");
const { User } = require('../model/users');
require("dotenv").config();
const KEY = process.env.DEV_KEY;
var jwt = require('jsonwebtoken');
const { v4: uuidv4 } = require('uuid');
const otpGenerator = require('otp-generator');

module.exports = {
    loginUserName: function (req, res) {
        console.log("page login");
    
        // Créer une promesse pour attendre la saisie de l'utilisateur
        const waitForUserName = new Promise((resolve, reject) => {
            const { userName } = req.body; 
            if (userName) {
                // Si un nom d'utilisateur est fourni, résoudre la promesse avec le nom d'utilisateur
                resolve(userName);
            } else {
                // Si aucun nom d'utilisateur n'est fourni, rejeter la promesse avec une erreur
                reject(new Error("Aucun nom d'utilisateur fourni"));
            }
        });
    
        // Attendre que la promesse soit résolue ou rejetée
        waitForUserName.then((userName) => {
            Auth.selectLogInUserName(User, userName) // Utiliser selectLogInUserName à la place de selectLogInUserID
                .then((user) => {
                    if (user) {
                        // Si l'utilisateur est trouvé, stocker son USER_ID dans la session
                        req.session.username = userName; // Assurez-vous que le nom de la session correspond à votre modèle de données
                        // Rediriger vers '/verifOTP'
                        //res.redirect('/verifOTP');

                        res.status(200).send("Success");
                    } else {
                        // Si l'utilisateur n'est pas trouvé, afficher un message et rediriger vers '/signUpEmail'
                        res.status(201).send("Nom d'utilisateur inconnu, veuillez vous inscrire");
                    }
                })
                .catch((error) => {
                    // Gérer les erreurs, par exemple en renvoyant une réponse d'erreur
                    res.status(400).send("Erreur lors de la recherche de l'utilisateur : " + error.message);
                });
        }).catch((error) => {
            // Gérer les erreurs, par exemple en renvoyant une réponse d'erreur
            res.status(400).send("Erreur lors de la validation du nom d'utilisateur : " + error.message);
        });
    },

    signUpEmail: function (req,res){
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
                //res.send("Aucun email existant, veuillez créer votre compte");
                res.status(202).send("Aucun email existant, veuillez créer votre compte");
                //res.redirect('/signupDate');
            }
        });
    },



    signUpEmail: function (req, res) {

        console.log("Page Email");

        const emailSaisi = new Promise((resolve, reject) => {
            const { email } = req.body;
            if (email) {
                resolve(email);
            } else {
                reject(new Error("Aucun email fourni"));
            }
        });

        emailSaisi.then((email) => {
            Auth.selectLogInEmail(User, email)
                .then(user =>{
                    if(user){
                        req.session.usermail = email;
                        res.status(200).send("Success");
                    }else{
                        res.status(404).send("Email non reconnu");
                    }
                })
                .catch((error) => {
                    console.error(error);
                    res.status(400).send("Erreur lors de la recherche du email : " + error.message);
                })
        }).catch((error) => {
            res.status(400).send("Erreur lors de validation : " + error.message);
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

    signupDate: function(req, res) {
        const { date } = req.body;
    
        // Créer une promesse pour stocker la date dans la session
        const storeDateInSession = new Promise((resolve, reject) => {
            if (date) {
                // Si une date est fournie, stocker la date dans la session
                resolve(date);
            } else {
                // Si aucune date n'est fournie, rejeter la promesse avec une erreur
                reject(new Error("Aucune date fournie"));
            }
        });
    
        // Attendre que la promesse soit résolue ou rejetée
        storeDateInSession.then(() => {
            // Rediriger vers '/signupTel' après avoir envoyé une réponse réussie
            req.session.date = date;
            res.status(202).send("Success");
        }).catch((error) => {
            // Gérer les erreurs, par exemple en renvoyant une réponse d'erreur
            res.status(400).send("Erreur : " + error.message);
        });
    },
    
    

    signupTel: function(req, res) {
        const { user_tel } = req.body;
    
        /* Créer une promesse pour vérifier si le numéro de téléphone est déjà utilisé
        const checkTelAvailability = new Promise((resolve, reject) => {
            Auth.selectSignUpTel(req.connection, user_tel, function(err, row) {
                if (err) {
                    reject(err);
                } else {
                    if (row != undefined && row.length) {
                        // Si le numéro de téléphone est déjà utilisé, rejeter la promesse
                        reject("Téléphone déjà utilisé");
                    } else {
                        // Si le numéro de téléphone est disponible, résoudre la promesse
                        resolve();
                    }
                }
            });
        });
        */
       if(!user_tel){
        return res.status(400).send("Aucun numéro de téléphone fourni");
       }

       Auth.selectSignUpTel(User, user_tel)
            .then(user => {
                if (user) {
                    // Si le numéro de téléphone existe déjà
                    res.status(409).json({ success: false, message: "Le numéro de téléphone existe déjà. Veuillez saisir un autre numéro." });
                } else {
                    // Si le numéro de téléphone n'existe pas, le sauvegarder dans la session
                    req.session.user_tel = user_tel;
                    res.status(200).json({ success: true, message: "Numéro de téléphone disponible." });
                }
            })
            .catch(err => {
                // Gérer les erreurs
                console.error(err);
                res.status(500).json({ success: false, message: "Une erreur s'est produite lors de la vérification du numéro de téléphone." });
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
