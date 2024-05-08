const userModel = require('./authModel');

describe('User Model', () => {
    test('selectLogInUserID should return a user by ID', async () => {
        const user = await userModel.selectLogInUserID(User, '123');
        expect(user).toBeDefined();
        expect(user.USER_ID).toEqual('123');
    });

    // Vous pouvez écrire d'autres tests unitaires similaires pour les autres fonctions de modèle.
});
