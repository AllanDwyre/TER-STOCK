const Auth = require("../model/auth");
require("dotenv").config();
const KEY = process.env.DEV_KEY;
var jwt = require('jsonwebtoken');
const { v4: uuidv4 } = require('uuid');

module.exports = {
    loginName: function (req, res) { // Ajouter `res` comme argument ici
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
                        res.status(404).send("Utilisateur non trouvé pour USER_ID : " + userId);
                    }
                })
                .catch((error) => {
                    // Gérer les erreurs, par exemple en renvoyant une réponse d'erreur
                    res.status(400).send("Erreur lors de la recherche de l'utilisateur : " + error.message);
                });
        }).catch((error) => {
            // Gérer les erreurs, par exemple en renvoyant une réponse d'erreur
            res.status(400).send("Erreur lors de la validation de l'USER_ID : " + error.message);
        });
    },
}
