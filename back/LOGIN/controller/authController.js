const Auth = require("../model/authModel");
const { User } = require('../model/users');
require("dotenv").config();
const KEY = process.env.DEV_KEY;
var jwt = require('jsonwebtoken');
const { v4: uuidv4 } = require('uuid');
const otpGenerator = require('otp-generator');
const nodemailer = require('nodemailer');
const authModel = require("../model/authModel");

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

function envoyerEmail(otp) { //remplacer par function envoyerEmail(otp, destinataire)
const mailOptions = {
    from: '"HiveStock" <hivestock92@gmail.com>',
    to: 'salhinina2002@gmail.com', //remplacer par destinataire
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
    login: function (req, res) {
        console.log("page login");
    
        Auth.selectLogInUserNameAndEmail(User, req.body.username, req.body.email) // Utiliser selectLogInUserName à la place de selectLogInUserID
            .then((user) => {
                if (user) {
                    // Si l'utilisateur est trouvé, stocker son USERNAME et USER_MAIL dans la session
                    req.session.username = User.USERNAME;
                    req.session.email = User.USER_MAIL;

                    res.status(200).send("Success");
                } else {
                    res.status(201).send("Nom d'utilisateur inconnu, veuillez vous inscrire");
                }
            })
            .catch((error) => {
                // Gérer les erreurs, par exemple en renvoyant une réponse d'erreur
                res.status(400).send("Erreur lors de la recherche de l'utilisateur : " + error.message);
            });
    },

    signup: function (req, res){
        console.log("Page First Name");

        //const { name } = req.body.name;
       // const { firstname } = req.body.firstname;
        const { username } = req.body.username;
        const { email } = req.body.email;
        const { date } = req.body.date;
        const { user_tel } = req.body.user_tel;

        Auth.selectSignUpData(User, req.body.username, req.body.email, req.body.user_tel)
            .then((user) =>{
                if(user){
                    // Si l'utilisateur est trouvé, dire qu'il existe déjà
                    res.status(400).send("Une des ces données existe déjà, veuillez vous connecter ou changez les informations")
                } else{
                    //req.session.name = name;
                    //req.session.firstname = firstname;
                    req.session.username = username;
                    req.session.usermail = email;
                    req.session.date = date;
                    req.session.user_tel = user_tel;

                    res.status(202).send("Success, veuillez maintenant vérifier votre email");
                }

            })

        /*
        if(!name || !firstname){
            return res.status(400).send("Vous devez fournir un nom et un prénom.");
        }
        */
    },
    
    verifOTP: function(req,res){
        
        const otp = otpGenerator.generate(6, { upperCase: false, specialChars: false, alphabets: false });
        envoyerEmail(otp);
        //envoyerEmail(otp, req.session.usermail);
        const otp_user = req.body;

        Auth.selectLogInUserName(User, req.session.username)
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
                    while(authModel.selectLogInUserID(User, User.USER_ID) == userId){
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
                        //delete req.session.usermail;
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
    },


    pagePrincipale: function(req,res){
        const 
    }

    afficheProd: function(req,res){

    }

};
