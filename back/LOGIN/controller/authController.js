const Auth = require("../model/authModel");
const { User } = require('../model/users');
require("dotenv").config();
const KEY = process.env.DEV_KEY;
var jwt = require('jsonwebtoken');
const { v4: uuidv4 } = require('uuid');
const otpGenerator = require('otp-generator');
const nodemailer = require('nodemailer');

const transporter = nodemailer.createTransport({
    host: "smtp.gmail.com",
    port: 465,
    secure: true, // Use `true` for port 465, `false` for all other ports
    auth: {
      user: "hivestock92@gmail.com",
      pass: "isclwxtwlglfyspq",
    },
});

transporter.verify().then(() => {
console.log("Pret pour envoyer un email");
});

function envoyerEmail(otp) {
const mailOptions = {
    from: '"HiveStock" <hivestock92@gmail.com>',
    to: 'salhinina2002@gmail.com',
    subject: 'Hive stock - Code OTP',
    text: `Votre OTP est : ${otp}.\n
    Saissez ce code pour vérifier votre compte`
};

transporter.sendMail(mailOptions, (error, info) => {
    if (error) {
    console.error('Erreur lors de l\'envoi de l\'e-mail:', error);
    } else {
    console.log('E-mail envoyé:', info.response);
    }
});
}

module.exports = {
    loginUserName: function (req, res) {
        console.log("page login");
    
        // Créer une promesse pour attendre la saisie de l'utilisateur
        const waitForUserName = new Promise((resolve, reject) => {
            const { username } = req.body; 
            if (username) {
                // Si un nom d'utilisateur est fourni, résoudre la promesse avec le nom d'utilisateur
                resolve(username);
            } else {
                // Si aucun nom d'utilisateur n'est fourni, rejeter la promesse avec une erreur
                reject(new Error("Aucun nom d'utilisateur fourni"));
            }
        });
    
        // Attendre que la promesse soit résolue ou rejetée
        waitForUserName.then((username) => {
            Auth.selectLogInUserName(User, username) // Utiliser selectLogInUserName à la place de selectLogInUserID
                .then((user) => {
                    if (user) {
                        // Si l'utilisateur est trouvé, stocker son USER_ID dans la session
                        req.session.username = username; // Assurez-vous que le nom de la session correspond à votre modèle de données
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

    signUpFirstName: function (req, res){
        console.log("Page First Name");

        const { name } = req.body.name;
        const { firstname } = req.body.firstname;

        if(!name || !firstname){
            return res.status(400).send("Vous devez fourni un nom et un prénom.");
        }

        req.session.name = name;
        req.session.firstname = firstname;
        res.status(202).send("Success");
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

    signupDate: function(req, res) {

        const { date } = req.body;
        const storeDateInSession = new Promise((resolve, reject) => {
            if (date) {
                resolve(date);
            } else {
                reject(new Error("Aucune date fournie"));
            }
        });
    
        storeDateInSession.then(() => {
            req.session.date = date;
            res.status(202).send("Success");
        }).catch((error) => {
            res.status(400).send("Erreur : " + error.message);
        });
    },
    
    
    signupTel: function(req, res) {

        const { user_tel } = req.body;
       if(!user_tel){
        return res.status(400).send("Aucun numéro de téléphone fourni");
       }

       Auth.selectSignUpTel(User, user_tel)
            .then(user => {
                if (user) {
                    res.status(409).json({ success: false, message: "Le numéro de téléphone existe déjà. Veuillez saisir un autre numéro." });
                } else {
                    req.session.user_tel = user_tel;
                    res.status(200).json({ success: true, message: "Numéro de téléphone disponible." });
                }
            })
            .catch(err => {
                console.error(err);
                res.status(500).json({ success: false, message: "Une erreur s'est produite lors de la vérification du numéro de téléphone." });
            });
    },

    verifOTP: function(req,res){
        
        const otp = otpGenerator.generate(6, { upperCase: false, specialChars: false, alphabets: false });
        envoyerEmail(otp);
        const otp_user = req.body;

        Auth.selectLogInUserName(User, req.session.userName)
            .then(userExistant => {
                if(userExistant){
                    if (otp !== otp_user) {
                        res.status(400).json({ success: false, message: "Le code OTP est incorrect." });
                    }else {
                        var payload = {
                            username: req.session.userName,
                        };
                        var token = jwt.sign(payload, KEY, { algorithm: 'HS256', expiresIn: "15d" });
                        res.send(token);
                        res.status(202).json({success : true, message : "Le code OTP est bon."});
                    }

                }else{
                    const userId = uuidv4().replace(/[^0-9]/g, '')
                    while(Auth.selectLogInUserID(User, User.USER_ID) == userId){
                        userId = uuidv4().replace(/[^0-9]/g, '');
                    }

                    const username = req.session.username;
                    const name = req.session.name;
                    const firstname = req.session.firstname;
                    const usermail = req.session.usermail;
                    const userdate = req.session.date;
                    const usertel = req.session.user_tel;
                    if (otp !== otp_user) {
                        return res.status(400).json({ success: false, message: "Le code OTP est incorrect." });
                    }

                    Auth.insert(User, {
                        USER_ID: userId,
                        USERNAME: username,
                        NAME_USER: name,
                        FIRST_NAME: firstname,
                        USER_MAIL: usermail,
                        USER_TEL: usertel,
                        USER_DATE_NAISS : userdate
                    })
                    .then(() =>{
                        // Supprimer les variables de session une fois que les données sont insérées avec succès
                        delete req.session.name;
                        delete req.session.firstname;
                        delete req.session.usermail;
                        delete req.session.usertel;
                        delete req.session.userdate;
            
                        var payload = {
                            username: req.session.username,
                        };
                        var token = jwt.sign(payload, KEY, { algorithm: 'HS256', expiresIn: "15d" });
                        res.send(token);
                        res.status(201).json({success : true, message : "Le code OTP est bon."});
                        console.log("Les données ont été insérées avec succès dans la base de données.");
                        res.send("Votre compte a été créé avec succès !");
                    })
                    .catch(err => {
                        console.error(err);
                        res.status(500).json({ success: false, message: "Une erreur s'est produite lors de l'insertion des données dans la base de données." });
                    });
                }
            })
    },

    home: function (req, res) {
        var str = req.get('Authorization');
        try {
            jwt.verify(str, KEY, { algorithm: 'HS256' });
            res.send("Bienvenu !");
        } catch {
            res.status(401);
            res.send("Bad Token");
        }
    }

};
