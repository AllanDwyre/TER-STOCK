const Auth = require("../model/auth");
require("dotenv").config();
const KEY = process.env.DEV_KEY;
var jwt = require('jsonwebtoken');
const { v4: uuidv4 } = require('uuid');

module.exports = {
    loginUserName: function (req, res) {
        console.log("page login");
    
        // Créer une promesse pour attendre la saisie de l'utilisateur
        const waitForUserName = new Promise((resolve, reject) => {
            const { userName } = req.body; // Utiliser le nom d'utilisateur à la place de userId
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
                        req.session.USER_ID = user.USER_ID; // Assurez-vous que le nom de la session correspond à votre modèle de données
                        // Rediriger vers '/verifOTP'
                        res.redirect('/verifOTP');
                    } else {
                        // Si l'utilisateur n'est pas trouvé, afficher un message et rediriger vers '/signUpEmail'
                        res.status(404).send("Nom d'utilisateur inconnu, veuillez vous inscrire");
                        res.redirect('/signUpEmail');
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

    signupDate: function(req, res) {
        const { date } = req.body;
    
        // Créer une promesse pour stocker la date dans la session
        const storeDateInSession = new Promise((resolve, reject) => {
            if (date) {
                // Si une date est fournie, stocker la date dans la session
                req.session.date = date;
                resolve();
            } else {
                // Si aucune date n'est fournie, rejeter la promesse avec une erreur
                reject(new Error("Aucune date fournie"));
            }
        });
    
        // Attendre que la promesse soit résolue ou rejetée
        storeDateInSession.then(() => {
            // Rediriger vers '/signupTel' après avoir envoyé une réponse réussie
            res.status(202).send("Success");
            res.redirect('/signupTel');
        }).catch((error) => {
            // Gérer les erreurs, par exemple en renvoyant une réponse d'erreur
            res.status(400).send("Erreur : " + error.message);
        });
    },
    
    

    signupTel: function(req, res) {
        const { user_tel } = req.body;
    
        // Créer une promesse pour vérifier si le numéro de téléphone est déjà utilisé
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
    
        // Attendre que la promesse soit résolue ou rejetée
        checkTelAvailability.then(() => {
            // Stocker le numéro de téléphone dans la session
            req.session.user_tel = user_tel;
            // Envoyer une réponse réussie et rediriger vers '/verifTel'
            res.status(201).send("Success");
            res.redirect('/verifTel');
        }).catch((error) => {
            // Gérer les erreurs, par exemple en renvoyant une réponse d'erreur
            res.status(402).send("Erreur : " + error);
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
