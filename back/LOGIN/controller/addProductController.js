const DataTypes = require('sequelize');
const sequelize = require('../config/db');
//const router = express.Router();
const Produit = require('../model/tables/produit')(sequelize, DataTypes);
const Categorie = require('../model/tables/categorie')(sequelize, DataTypes);
const Fournisseur = require('../model/tables/fournisseur')(sequelize, DataTypes);

sharedData = {
  
}

module.exports = {
    addProduit: async function(req, res) {
      try {
        const productId = req.body.productId;
        const nom = req.body.nom;
        const supplierName = req.body.supplierName;
        const productCategorie = req.body.productCategorie;
        const productDimensions = req.body.productDimensions;
        const productPrix = req.body.productPrix; 

        await Categorie.findOne({
          where: {
            NOM_CATEGORIE : productCategorie
          },
          attributes : ['CATEGORIE_ID']

        })
        .then(res => {
          req.session.categorie_id = res.dataValues.CATEGORIE_ID;
          console.log(req.session.categorie_id);
        })
        .catch(error => {
          console.error('Une erreur est survenue :', error);
        });

        await Fournisseur.findOne({
          where: {
            NOM_FOURNISSEUR : supplierName
          },
          attributes : ['FOURNISSEUR_ID']

        })
        .then(res => {
          req.session.fourn_id = res.dataValues.FOURNISSEUR_ID;
          console.log(req.session.fourn_id);
        })
        .catch(error => {
          console.error('Une erreur est survenue :', error);
        });      


  
        /* Créez le produit dans la base de données */
        const nouveauProduit = await Produit.create({
          PRODUIT_ID: productId,
          NOM: nom,
          FOURNISSEUR_ID : req.session.fourn_id,
          PRODUCT_CATEGORIE: req.session.categorie_id,
          DIMENSIONS: productDimensions,
          PRIX_UNIT: productPrix,
          // Affectez d'autres champs de produit ici selon les données reçues
        }).then(res => {
          console.log(res)
        }).catch(error =>{
          console.error('Erreur lors de l\'ajout du produit', error);
        });
  
        res.status(201).send("Success"); //.json({ success: true, produit: nouveauProduit });
      } catch (error) {
        console.error('Erreur lors de l\'ajout du produit :', error);
        res.status(500).json({ success: false, message: "Une erreur s'est produite lors de l'ajout du produit." });
      }
    }
  };