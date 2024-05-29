const request = require('supertest');
const app = require('../serveur.js');

describe('POST /signupTel', () => {
  test('should return status 200 and success message with valid phone number', async () => {
    const response = await request(app)
      .post('/signupTel')
      .send({ user_tel: '1234567890' });

    expect(response.status).toBe(200);
    expect(response.body).toEqual({ success: true, message: 'Numéro de téléphone disponible.' });
  });

  test('should return status 409 with existing phone number', async () => {
    const response = await request(app)
      .post('/signupTel')
      .send({ user_tel: 'existingPhoneNumber' });

    expect(response.status).toBe(409);
    expect(response.body).toEqual({ success: false, message: 'Le numéro de téléphone existe déjà. Veuillez saisir un autre numéro.' });
  });
});
