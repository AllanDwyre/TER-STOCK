const DataTypes = require('sequelize');
const sequelize = require('../config/db');
//const router = express.Router();
const Produit = require('../model/tables/produit')(sequelize, DataTypes);
const CommFourn = require('../model/tables/commande_fournisseur')(sequelize, DataTypes);
const Fournisseur = require('../model/tables/fournisseur')(sequelize, DataTypes);
const Prod = require("../model/prodModel");
/*countTable(nomTable)*/

const sharedData = {
    produit_id: ''
  };

module.exports = {

    newOrder : async function (req, res){
        try{

        const { 
            nomProduit,
            quantiteProd
            // il faut correpondre  les champs avec le front
            } = req.body;
            
            await Produit.findOne({
            where: {
                NOM : nomProduit
            },
            attributes : ['PRODUIT_ID']

            })
            .then(res => {
            sharedData.produit_id = res.dataValues.PRODUIT_ID;
            console.log(sharedData.produit_id);
            })
            .catch(error => {
            console.error('Une erreur est survenue :', error);
            }); 

            await CommFourn.create({
                PRODUIT_ID: productId,
                NOM: nom,
                FOURNISSEUR_ID : req.session.fourn_id,
                PRODUCT_CATEGORIE: req.session.categorie_id,
                DIMENSIONS: productDimensions,
                PRIX_UNIT: productPrix,
 
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




}