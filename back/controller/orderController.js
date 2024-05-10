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

    showOrders : async function(req, res){
        try{

            // Récupérer le nombre total de commandes
            const totalOrders = await CommFourn.count();

            // Récupérer la liste des commandes
            const orders = await CommFourn.findAll();

            // Envoyer les données au client
            res.status(200).json({ 
                success: true, 
                totalOrders: totalOrders,
                orders: orders
            });

        }catch (error) {
            console.error('Erreur lors de l\'affichage des commandes :', error);
            res.status(500).json({ success: false, message: "Une erreur s'est produite lors de l'affichage des commandes." });
          }
    }


}