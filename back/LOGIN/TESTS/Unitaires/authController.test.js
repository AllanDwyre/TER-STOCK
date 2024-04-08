const { loginUserName } = require('../controller/authController');

describe('loginUserName function', () => {
  test('should return status 200 with valid username', () => {
    const req = { body: { userName: 'daniVV' } };
    const res = {
      status: jest.fn().mockReturnThis(),
      send: jest.fn(),
    };

    loginUserName(req, res);

    expect(res.status).toHaveBeenCalledWith(200);
    expect(res.send).toHaveBeenCalledWith('Success');
  });

  test('should return status 201 with unknown username', () => {
    const req = { body: { userName: 'unknownUserName' } };
    const res = {
      status: jest.fn().mockReturnThis(),
      send: jest.fn(),
    };

    loginUserName(req, res);

    expect(res.status).toHaveBeenCalledWith(201);
    expect(res.send).toHaveBeenCalledWith('Nom d\'utilisateur inconnu, veuillez vous inscrire');
  });
});
