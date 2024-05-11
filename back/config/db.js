const { Sequelize, DataTypes } = require("sequelize");
require("dotenv").config();

// Configuration de la connexion à la base de données  yes
const sequelizeLocal = new Sequelize(
  process.env.DB_NAME,
  process.env.DB_USER,
  process.env.DB_PASS,
  {
    host: process.env.DB_HOST,
    dialect: "mysql",
    logging: false,
  }
);

// Tester la connexion
async function testConnection() {
  try {
    await sequelizeLocal.authenticate();
    console.log("Connexion à la base de données Locale établie avec succès.");
  } catch (error) {
    console.error("Impossible de se connecter à la base de données:", error);
  }
}
testConnection();

// Connexion à la base de données cloud
const sequelizeCloud = new Sequelize(
  process.env.DB_NAMEC,
  process.env.DB_USERC,
  process.env.DB_PASSC,
  {
    host: process.env.DB_HOSTC,
    dialect: "mysql",
    logging: false,
  }
);

// Tester la connexion
async function testConnectionCloud() {
  try {
    await sequelizeCloud.authenticate();
    console.log("Connexion à la base de données Cloud établie avec succès.");
  } catch (error) {
    console.error("Impossible de se connecter à la base de données:", error);
  }
}
testConnectionCloud();

const modelLocal = require("../model/tables/categorie")(
  sequelizeLocal,
  DataTypes
);
const modelCloud = require("../model/tables/categorie")(
  sequelizeCloud,
  DataTypes
);

const currentDate = new Date();
const year = currentDate.getFullYear(); // Année
const month = currentDate.getMonth() + 1; // Mois (janvier est 0, donc on ajoute 1)
const day = currentDate.getDate(); // Jour du mois
const formattedDate = `${year}-${month < 10 ? "0" : ""}${month}-${
  day < 10 ? "0" : ""
}${day}`;
console.log(formattedDate);

/*const User = require('../model/tables/users.js')(sequelize, DataTypes);


User.findAll().then( res => {
  console.log(res);
})*/
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
module.exports = sequelizeCloud;
