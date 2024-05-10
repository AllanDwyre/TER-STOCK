const DataTypes = require('sequelize');
const sequelize = require('../config/db');
const Auth = require("../model/authModel");
const User = require('../model/tables/users')(sequelize, DataTypes);
const Employe = require('../model/tables/employe')(sequelize,DataTypes);
require('dotenv').config({ path: '../.env' });
const KEY = process.env.DEV_KEY;
var jwt = require('jsonwebtoken');
//const { v4: uuidv4 } = require('uuid');

const sharedData ={
    userId : ''
}

module.exports = {
    login: function (req, res) {
        console.log("page login");
        
        console.log(typeof(User));
        console.log(typeof(req.body.password));
        console.log(req.body.username);
        Auth.selectLogInUserNameAndPassword(User, req.body.username, req.body.password) // Utiliser selectLogInUserName à la place de selectLogInUserID
        .then((user) => {
            if (user) {
                    console.log("Trouvé !");
                    console.log(user);

                    console.log(req.body.username);
                    console.log(req.body.password);
        
                    var payload = {
                        username: req.body.username,
                        password: req.body.password
                    };
                    var token = jwt.sign(payload, KEY, { algorithm: 'HS256', expiresIn: "15d" });

                    res.send(token);


                    //res.status(200).send("Success");
                } else {
                    console.log(typeof(req.body.password));
                    console.log(req.body.password);
                    res.status(401).send("Nom d'utilisateur inconnu, veuillez vous inscrire");
                }
            })
            .catch((error) => {
                // Gérer les erreurs, par exemple en renvoyant une réponse d'erreur
                console.log(typeof(req.body.password));
                console.log(req.body.password);
                res.status(400).send("Controller , Erreur lors de la recherche de l'utilisateur : " + error.message);
            });
    },

    signup: function (req, res){
        console.log("Page SignUp");

        Auth.selectSignUpData(User, req.body.username, req.body.email, req.body.user_tel)
            .then((user) =>{
                if(user){
                    // Si l'utilisateur est trouvé, dire qu'il existe déjà
                    res.status(401).send("Une des ces données existe déjà, veuillez vous connecter ou changez les informations")
                } else{
                    /*var userId = uuidv4().replace(/[^0-9]/g, '').slice(0, 10);
                    Auth.selectLogInUserID(User, userId)
                    .then((existinguser)=>{
                        if(existinguser){
                            userId = uuidv4().replace(/[^0-9]/g, '').slice(0,10);
                        }   
                    })*/

                    Auth.insert(User, req.body.username, req.body.nameuser, req.body.firstname, 
                        req.body.email, req.body.password, req.body.user_tel, req.body.user_date)
                    .then((resultat) =>{
                        console.log(resultat);
                        Employe.create({
                            EMPLOYE_ID : resultat.dataValues.USER_ID
                        }).then( resultat => {
                            console.log("Les données ont été insérées dans Employe.");
                            console.log(resultat);
                        })
                        .catch(err => {
                            console.error(err);
                            res.status(500).json({success:false, message: "Erreur lors de creation employé"});
                        });
                        var payload = {
                            username: req.body.username,
                            password: req.body.password
                        };
                        var token = jwt.sign(payload, KEY, { algorithm: 'HS256', expiresIn: "15d" });
                        res.send(token);
                        console.log("Les données ont été insérées avec succès dans la base de données.");
                    })
                    .catch(err => {
                        console.error(err);
                        res.status(500).json({ success: false, message: "Une erreur s'est produite lors de l'insertion des données dans la base de données." });
                    });

                }
            })
            .catch(error => {
                res.status(400).send("Controller signup, Erreur lors de la recherche de l'utilisateur : " + error.message);
            });
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

    getUser: function(req,res){
        // Vérifiez d'abord si l'en-tête Authorization est présent dans la requête
        const authHeader = req.headers['authorization'];
        console.log(authHeader);
        if (!authHeader) {
            return res.status(401).send('Token d\'authentification manquant');
        }

        // Récupérez le token d'authentification de l'en-tête Authorization

        // Vérifiez et décodez le token
        jwt.verify(authHeader, KEY, { algorithm: 'HS256' }, (err, decoded) => {
            if (err) {
                return res.status(401).send('Token d\'authentification invalide');
            }
            // Maintenant que le token est vérifié, vous pouvez envoyer les informations utilisateur
            // Vous pouvez récupérer les informations supplémentaires de l'utilisateur depuis la base de données si nécessaire
            User.findOne({
                where:{
                    USERNAME: decoded.username
                }
            }).then(result => {
                console.log(result);
                const userInfo = {
                    userid: result.dataValues.USER_ID,
                    username: decoded.username,
                    name : result.dataValues.NAME_USER,
                    firstname : result.dataValues.FIRST_NAME,
                    usermail: result.dataValues.USER_MAIL,
                    userpass : decoded.password,
                    usertel: result.dataValues.USER_TEL,
                    userdate: result.dataValues.USER_DATE_NAISS
                    // Ajoutez d'autres champs d'informations utilisateur si nécessaire
                };
                res.status(200).json(userInfo);
            })
            // Envoyez les informations utilisateur au front-end
        });
    }

};
