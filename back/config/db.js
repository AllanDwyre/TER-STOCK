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

// Synchronisation des données pour chaque modèle
async function synchronizeAdresse() {
  try {
    for(const model in modelsCloud ){
      const tableL = modelsLocale[model];
      const tableC = modelsCloud[model];
      const localAdresses = await tableL.findAll();
      for (const local of localAdresses){
        const localAdresse = local.dataValues;
        await tableC.upsert(localAdresse).then( res => {
          console.log(res);
        });
      }

      // const localAdresses = await modelsLocale.adresse.findAll();
      /*for (const local of localAdresses) {
        const localAdresse = local.dataValues;
        await modelsCloud.adresse.upsert(localAdresse).then( res => {
          console.log(res);
        });

      } */
    }
    console.log("Toutes les données ont été synchronisées avec succès.");

    // Ajoutez d'autres modèles et synchronisations si nécessaire pour d'autres tables
  } catch (error) {
    console.error('Erreur lors de la synchronisation des données :', error);
  }
}
synchronizeAdresse();


/* Synchronisation des données pour chaque modèle
async function synchronizeAdresse() {
    try {
        // Synchronisation de la table categorie
        //await modelLocal.sync();
        const localAdresses = await modelsLocale.adresse.findAll();

      // Pour chaque donnée locale, vérifiez si elle existe déjà dans le cloud
      for (const local of localAdresses) {
        const localID = local.dataValues.ADRESSE_ID;
        const localData = local.dataValues;

        // Vérifiez si la catégorie locale existe déjà dans le cloud
        const cloudAdresse = await modelsCloud.adresse.findOne({
            where: {
                ADRESSE_ID: localID
            }
        });
        for (const key in localData) {
          
        // Si la catégorie n'existe pas dans le cloud, insérez-la
        if (!cloudAdresse) {
          await modelsCloud.adresse.create(localData);
          console.log(`Adresse synchronisée : ${localID}, ${localData}`);
        }else if (localData[key] !== cloudAdresse[key]) {
          //cloudAdresse.dataValues !== localData
          await cloudAdresse.update(localData);
          console.log(`Adresse mise à jour : ${localID}, ${localData}`);
          //console.log("non");
      }
        /*else{
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

  // Synchronisation des données pour chaque modèle
async function synchronizeCategorie() {
  try {
      // Synchronisation de la table categorie
      const localCategories = await modelLocal.findAll();

    // Pour chaque donnée locale, vérifiez si elle existe déjà dans le cloud
    for (const localCategory of localCategories) {
      const localCategorieID = localCategory.dataValues.CATEGORIE_ID;
      const localCategorieNom = localCategory.dataValues.NOM_CATEGORIE;

      // Vérifiez si la catégorie locale existe déjà dans le cloud
      const cloudCategory = await modelCloud.findOne({
          where: {
              CATEGORIE_ID: localCategorieID
          }
      });
      // Si la catégorie n'existe pas dans le cloud, insérez-la
      if (!cloudCategory) {
        await modelCloud.create({
            CATEGORIE_ID: localCategorieID,
            NOM_CATEGORIE: localCategorieNom
        });
        console.log(`Catégorie synchronisée : ${localCategorieID}, ${localCategorieNom}`);
      }
      else{
        console.log("Catégorie déjà dans le cloud");
      }
    }

    console.log("Toutes les données synchronisées avec succès.");

    // Ajoutez d'autres modèles et synchronisations si nécessaire pour d'autres tables
  } catch (error) {
    console.error('Erreur lors de la synchronisation des données :', error);
  }
}

// Synchronisation des données pour chaque modèle
async function synchronizeEmploye() {
  try {
      // Synchronisation de la table categorie
      //await modelLocal.sync();
      const localCategories = await modelLocal.findAll();

    // Pour chaque donnée locale, vérifiez si elle existe déjà dans le cloud
    for (const localCategory of localCategories) {
      const localCategorieID = localCategory.dataValues.CATEGORIE_ID;
      const localCategorieNom = localCategory.dataValues.NOM_CATEGORIE;

      // Vérifiez si la catégorie locale existe déjà dans le cloud
      const cloudCategory = await modelCloud.findOne({
          where: {
              CATEGORIE_ID: localCategorieID
          }
      });
      // Si la catégorie n'existe pas dans le cloud, insérez-la
      if (!cloudCategory) {
        await modelCloud.create({
            CATEGORIE_ID: localCategorieID,
            NOM_CATEGORIE: localCategorieNom
        });
        console.log(`Catégorie synchronisée : ${localCategorieID}, ${localCategorieNom}`);
      }
      else{
        console.log("Catégorie déjà dans le cloud");
      }
    }

    console.log("Toutes les données synchronisées avec succès.");

    // Ajoutez d'autres modèles et synchronisations si nécessaire pour d'autres tables
  } catch (error) {
    console.error('Erreur lors de la synchronisation des données :', error);
  }
}


// Exporter l'objet Sequelize configuré
module.exports = sequelizeCloud;
