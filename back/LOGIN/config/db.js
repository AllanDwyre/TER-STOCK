const { Sequelize } = require('sequelize');
require("dotenv").config();

// Configuration de la connexion à la base de données  yes 
const sequelize = new Sequelize(process.env.DB_NAME, process.env.DB_USER, process.env.DB_PASS, {
  host: process.env.DB_HOST,
  dialect: 'mysql',
});

// Exporter l'objet Sequelize configuré
module.exports = sequelize;
