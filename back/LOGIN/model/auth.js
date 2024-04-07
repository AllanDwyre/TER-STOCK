module.exports={
    selectLogInUserID: function(User, user_id){
        return User.findOne({ where: {USER_ID: user_id }});
    },
    selectLogInUserName: function(User, username){
        return User.findOne({ where: {USERNAME: username}});
    },
    selectLogInEmail: function(User, user_mail){
        return User.findOne({where: {USER_MAIL: user_mail }});
    },
    selectSignUpTel: function(User, user_tel){
        return User.findOne({where: {USER_TEL: user_tel}});
    },
    insert: function(User, userData){
        return User.create(userData);
    }
};

// findOne :  rechercher des utilisateurs dans la base de donnÃ©es en fonction de diffÃ©rents critÃ¨res
// create : insÃ©rer un nouvel utilisateur dans la base de donnÃ©es.