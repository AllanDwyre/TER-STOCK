const { Sequelize, DataTypes } = require("sequelize");
require("dotenv").config();
const cron = require('node-cron');

// Configuration de la connexion à la base de données local’
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

 // Ici on teste la connexion à la base de données locale
 async function testConnectionLocale() {
   try {
     await sequelizeLocal.authenticate();
     console.log("Connexion à la base de données Locale établie avec succès.");
   } catch (error) {
     console.error("Impossible de se connecter à la base de données:", error);
   }
 }
 testConnectionLocale();

const sequelizeHeroku = new Sequelize(
  process.env.DB_NAMEH,
  process.env.DB_USERH,
  process.env.DB_PASSH,
  {
    host: process.env.DB_HOSTH,
    dialect: "mysql",
    logging: false,
  }
);

async function testConnectionHeroku() {
  try {
    await sequelizeHeroku.authenticate();
    console.log("Connexion à la base de données Heroku établie avec succès.");
  } catch (error) {
    console.error("Impossible de se connecter à la base de données Heroku:", error);
  }
}
testConnectionHeroku();


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

// Ici on teste la connexion à la base de données cloud
async function testConnectionCloud() {
  try {
    await sequelizeCloud.authenticate();
    console.log("Connexion à la base de données Cloud établie avec succès.");
  } catch (error) {
    console.error("Impossible de se connecter à la base de données Cloud:", error);
  }
}
testConnectionCloud();

const initModels = require("../model/tables/init-models").initModels;
const modelsLocale = initModels(sequelizeLocal, DataTypes);
const modelsCloud = initModels(sequelizeCloud, DataTypes);

/*for(const model in modelsCloud ){
  console.log(model);
}*/

// Fonction de synchronisation des données pour chaque modèle
async function synchronizeTables() {
  try {
    for(const model in modelsCloud ){
      const tableLocale = modelsLocale[model];
      const tableCloud = modelsCloud[model];
      const localModels = await tableLocale.findAll();
      for (const local of localModels){
        const localModel = local.dataValues;
        await tableCloud.upsert(localModel);
      }
    }
    console.log("Toutes les données ont été synchronisées avec succès.");
  } catch (error) {
    console.error('Erreur lors de la synchronisation des données :', error);
  }
}


async function synchronizeTablesInverse() {
  try {
    for(const model in modelsLocale ){
      const tableCloud = modelsCloud[model];
      const tableLocale = modelsLocale[model];
      const cloudModels = await tableCloud.findAll();
      for (const cloud of cloudModels){
        const cloudModel = cloud.dataValues;
        await tableLocale.upsert(cloudModel);
      }
    }
    console.log("Toutes les données ont été synchronisées avec succès.");
  } catch (error) {
    console.error('Erreur lors de la synchronisation des données :', error);
  }
}

//synchronizeTablesInverse();
/*
async function synchronizeAdresse() {
  try {
      // Synchronisation de la table categorie
      //await modelLocal.sync();
      const cloudAdresses = await modelsCloud.users.findAll();

    // Pour chaque donnée locale, vérifiez si elle existe déjà dans le cloud
    for (const cloud of cloudAdresses) {
      const userId = cloud.dataValues.USER_ID;
      const cloudData = cloud.dataValues;

      // Vérifiez si la catégorie locale existe déjà dans le cloud
      const localAdresse = await modelsLocale.users.findOne({
          where: {
              USER_ID: userId
          }
      });
      for (const key in cloudData) {

      // Si la catégorie n'existe pas dans le cloud, insérez-la
      if (!localAdresse) {
        await modelsLocale.users.create(cloudData);
        console.log(`Adresse synchronisée : ${userId}, ${cloudData}`);
      }else if (cloudData[key] !== localAdresse[key]) {
        //cloudAdresse.dataValues !== localData
        await localAdresse.update(cloudData);
        console.log(`Adresse mise à jour : ${userId}, ${cloudData}`);
        //console.log("non");
    }
      else{
        console.log("Aucune insertion ou mise à jour nécessaire ");
      }
    }
  }

    console.log("Toutes les données ont été synchronisées avec succès.");

    // Ajoutez d'autres modèles et synchronisations si nécessaire pour d'autres tables
  } catch (error) {
    console.error('Erreur lors de la synchronisation des données :', error);
  }
}

synchronizeAdresse();
*/

cron.schedule('0 0 1 * *', () => { 
  console.log('Début de la synchronisation mensuelle.');
  synchronizeTables();
});


/*
const currentDate = new Date();
const year = currentDate.getFullYear(); // Année
const month = currentDate.getMonth() + 1; // Mois (janvier est 0, donc on ajoute 1)
const day = currentDate.getDate(); // Jour du mois
const formattedDate = `${year}-${month < 10 ? "0" : ""}${month}-${
  day < 10 ? "0" : ""
}${day}`;
console.log(formattedDate);*/

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
