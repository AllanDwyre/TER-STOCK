module.exports={
    selectLogInUserID: function(User, user_id){
        return User.findOne({ where: {USER_ID: user_id }})
            .catch(error => {
                console.error('Erreur lors de la recherche de l\'utilisateur par ID :', error);
                throw new Error('Erreur lors de la recherche de l\'utilisateur par ID');
            });

    },
    selectLogInUserName: function(User, username){
        return User.findOne({ where: {USERNAME: username}})
            .catch(error => {
                console.error('Erreur lors de la recherche de l\'utilisateur par nom d\'utilisateur :', error);
                throw new Error('Erreur lors de la recherche de l\'utilisateur par nom d\'utilisateur');
            });
    },
    selectLogInEmail: function(User, user_mail){
        return User.findOne({where: {USER_MAIL: user_mail }})
            .catch(error => {
                console.error('Erreur lors de la recherche de l\'utilisateur par email :', error);
                throw new Error('Erreur lors de la recherche de l\'utilisateur par email');
            });
    },
    selectSignUpTel: function(User, user_tel){
        return User.findOne({where: {USER_TEL: user_tel}})
            .catch(error => {
                console.error('Erreur lors de la recherche de l\'utilisateur par téléphone :', error);
                throw new Error('Erreur lors de la recherche de l\'utilisateur par téléphone');
            });
    },
    insert: function(User, userData){
        return User.create(userData)
            .catch(error => {
                console.error('Erreur lors de l\'insertion de l\'utilisateur :', error);
                throw new Error('Erreur lors de l\'insertion de l\'utilisateur');
            });
    }
};
