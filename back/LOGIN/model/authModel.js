const { Sequelize } = require('sequelize');
// Import du modèle User
const User = require('../model/tables/users');

module.exports={
    selectLogInUserID: function(user_id){
        return User.findOne({ where: {USER_ID: user_id }})
            .catch(error => {
                console.error('Erreur lors de la recherche de l\'utilisateur par ID :', error);
                throw new Error('Erreur lors de la recherche de l\'utilisateur par ID');
            });

    },

    selectLogInUserNameAndEmail: function(username, email){
        return  User.findOne({ where: { 
            $or: [
                { USERNAME: username },
                { USER_MAIL: email }
            ]
        }})
        .catch(error => {
            console.error('Erreur lors de la recherche de l\'utilisateur par ID :', error);
            throw new Error('Erreur lors de la recherche de l\'utilisateur par ID');
        });
    },

    selectSignUpData: function(username, email, telephone){
        return User.findOne({ where: { 
            $or: [
                { USERNAME: username },
                { USER_MAIL: email },
                { USER_TEL: telephone}
            ]
        }})
        .catch(error => {
            console.error('Erreur lors de la recherche de l\'utilisateur par ces données :', error);
            throw new Error('Erreur lors de la recherche de l\'utilisateur par ces données');
        });
    },
    
    insert: function(userData){
        return User.create(userData)
            .catch(error => {
                console.error('Erreur lors de l\'insertion de l\'utilisateur :', error);
                throw new Error('Erreur lors de l\'insertion de l\'utilisateur');
            });
    }
};
