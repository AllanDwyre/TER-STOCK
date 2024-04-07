// Exemple de définition du modèle de données
const { DataTypes } = require('sequelize');
const sequelize = require('../config/db');

const Crud = sequelize.define('crud', {
  // Définition des attributs du modèle
  attribute1: {
    type: DataTypes.STRING,
    allowNull: false
  },
  attribute2: {
    type: DataTypes.INTEGER,
    allowNull: true
  }
});

module.exports = Crud;
