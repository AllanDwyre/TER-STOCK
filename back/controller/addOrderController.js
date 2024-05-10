const DataTypes = require('sequelize');
const sequelize = require('../config/db');
//const router = express.Router();
const Produit = require('../model/tables/produit')(sequelize, DataTypes);
const CommFourn = require('../model/tables/commande_fournisseur')(sequelize, DataTypes);
const Commande = require('../model/tables/commande')(sequelize, DataTypes);
const Fournisseur = require('../model/tables/fournisseur')(sequelize, DataTypes);
const Prod = require("../model/prodModel");
/*countTable(nomTable)*/
const currentDate = new Date();
const formattedDate = `${currentDate.getFullYear()}-${currentDate.getMonth() + 1 < 10 ? '0' : ''}${currentDate.getMonth() + 1}-${currentDate.getDate() < 10 ? '0' : ''}${currentDate.getDate()}`;

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
            attributes : ['PRODUIT_ID', 'PRIX_UNIT']
            })
            .then(res => {
            sharedData.produit_id = res.dataValues.PRODUIT_ID;
            res.json({ 
                success: true, 
                prixProduit: res.dataValues.PRIX_UNIT
            });
            console.log(sharedData.produit_id);
            })
            .catch(error => {
            console.error('Une erreur est survenue :', error);
            }); 


            await Commande

            await CommFourn.create({
                COMM: productId,
                TYPE_COMMANDE : 'commande',
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