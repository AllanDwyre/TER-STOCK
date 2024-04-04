module.exports={
    selectLogInUserID: function(User, USER_ID){
        return User.findOne({ where: {USER_ID: USER_ID }});
    },
    selectLogInFirstName: function(User, USERNAME){
        return User.findOne({ where: {USERNAME: USERNAME}});
    },
    selectLogInEmail: function(User, USER_MAIL){
        return User.findOne({where: {USER_MAIL: USER_MAIL }});
    },
    selectSignUpTel: function(User, USER_TEL){
        return User.findOne({where: {USER_TEL: USER_TEL}});
    },
    insert: function(User, userData){
        return User.create(userData);
    }
};

// findOne :  rechercher des utilisateurs dans la base de donnÃ©es en fonction de diffÃ©rents critÃ¨res
// create : insÃ©rer un nouvel utilisateur dans la base de donnÃ©es.