const { Op } = require('sequelize');
module.exports={
    selectLogInUserID: function(User, user_id){
        return User.findOne({ where: {USER_ID: user_id }})
            .catch(error => {
                console.error('Erreur lors de la recherche de l\'utilisateur par ID :', error);
                throw new Error('Erreur lors de la recherche de l\'utilisateur par ID');
            });

    },
/*
    Post.findAll({
        where: {
          authorId: {
            [Op.eq]: 2,
          },
        },
      });

      Post.findAll({
        where: {
          [Op.or]: [{ authorId: 12 }, { authorId: 13 }],
        },
      });
*/
    selectLogInUserNameAndEmail: function(User, username, email){
        return  User.findOne({
            where: { 
                [Op.or]: [
                    { USERNAME: username },
                    { USER_MAIL: email }
                ],
            }
        })
    },

    selectSignUpData: function(User, username, email, telephone, password){
        return User.findOne({
            where: { 
                [Op.or]: [
                { USERNAME: username },
                { USER_MAIL: email },
                { USER_TEL: telephone},
                { }

            ]
        }})
        .catch(error => {
            console.error('Erreur lors de la recherche de l\'utilisateur par ces données :', error);
            throw new Error('Erreur lors de la recherche de l\'utilisateur par ces données');
        });
    },
    
    insert: function(User,userData){
        return User.create(userData)
            .catch(error => {
                console.error('Erreur lors de l\'insertion de l\'utilisateur :', error);
                throw new Error('Erreur lors de l\'insertion de l\'utilisateur');
            });
    }
};
