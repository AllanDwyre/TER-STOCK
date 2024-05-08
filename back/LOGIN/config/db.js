const { Sequelize , DataTypes} = require('sequelize');
require("dotenv").config({path: '../.env'});
var express = require('express');

// Configuration de la connexion à la base de données  yes 
const sequelize = new Sequelize(process.env.DB_NAME, process.env.DB_USER, process.env.DB_PASS, {
  host: process.env.DB_HOST,
  dialect: 'mysql',
});

// Tester la connexion
async function testConnection() {
  try {
    await sequelize.authenticate();
    console.log('Connexion à la base de données établie avec succès.');
  } catch (error) {
    console.error('Impossible de se connecter à la base de données:', error);
  }} 

  /*
  finally {
    // Fermer la connexion après le test
    await sequelize.close();
  }
}*/
const Product = require('../model/tables/produit')(sequelize, DataTypes);
// Appeler la fonction de test de connexion
testConnection();

const app = express();
// Route pour récupérer toutes les informations sur les produits
app.get('/envoieproduits', async (req, res) => {
  try {
    // Récupérer tous les produits depuis la base de données
    const produits = await Product.findAll();

    // Envoyer les produits au format JSON en réponse
    res.json(produits);
  } catch (error) {
    // En cas d'erreur, renvoyer un code d'erreur avec un message approprié
    console.error('Erreur lors de la récupération des produits:', error);
    res.status(500).json({ message: 'Erreur lors de la récupération des produits.' });
  }
});



//const User = require('../model/tables/users.js')(sequelize, DataTypes);

/* Insérer une nouvelle ligne dans la table users
User.create({
  USER_ID: 1,
  USERNAME: 'utilisateur1',
  NAME_USER: 'NomUtilisateur1',
  FIRST_NAME: 'PrénomUtilisateur1',
  USER_MAIL: 'utilisateur1@example.com',
  USER_TEL: 1234567890,
  USER_DATE_NAISS: '1990-01-01' // ou null si non spécifié
}).then(user => {
  console.log("Utilisateur créé avec succès :", user);
}).catch(err => {
  console.error("Erreur lors de la création de l'utilisateur :", err);
});*/

// Exporter l'objet Sequelize configuré
module.exports = sequelize;