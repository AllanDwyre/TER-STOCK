const { Op, literal } = require("sequelize");
const sequelize = require("../config/db");
const KEY = process.env.DEV_KEY;
var jwt = require("jsonwebtoken");
const initModels = require("../model/tables/init-models").initModels;
const models = initModels(sequelize);

// Trouver tous les produits

module.exports={
    // récupérer le nombre total de produits
    getTotalProductsCount: async (req, res) => {
        try {
          const totalProductsCount = await models.produit.count();
          res.status(200).json({ totalProductsCount });
        } catch (error) {
          res.status(500).json({
            message: "Erreur lors de la récupération du nombre total de produits: " + error.message,
          });
        }
      },
      /// le total prix de notre stock
      getTotalStockPrice: async (req, res) => {
        try {
          const totalStockPrice = await models.produit.sum(literal('PRIX_UNIT * QUANTITE'), {
            where: {
              QUANTITE: {
                [Op.gt]: 0 
              }
            }
          });
    
          res.status(200).json({ totalStockPrice });
        } catch (error) {
          console.error("Erreur lors du calcul du prix total du stock:", error);
          res.status(500).json({
            message: "Erreur lors du calcul du prix total du stock.",
          });
        }
      },
      ///nombre de fournisseur
      getNumberSupplier: async (req, res) =>{
        try {
            const totalSupplier = await models.fournisseur.count();
            res.status(200).json({ totalSupplier });
          } catch (error) {
            res.status(500).json({
              message: "Erreur lors de la récupération du nombre total de fournisseur: " + error.message,
            });
          }

      },
      /// le seuil de nos produits
      getReplenishmentLevel :async (req, res) =>{
        try{
            const product = await models.produit.findOne();
            const level = product.SEUIL;
            res.status(200).json({ level });
        }catch (error) {
            res.status(500).json({
              message: "Erreur lors de la récupération du seuil: " + error.message,
            });
        }
    },

}

// Product.findAll()
// .then(res => {
//     console.log(res);
// })
// .catch(error => {
//     console.log("Erreur" + error);
// })
// console.log(products.every(product => product instanceof Product)); // true
// console.log('All products:', JSON.stringify(products, null, 2));

// //Trouver tous les commandes 

// Orders.findOne()
// .then(res => {
//     console.log(res);
// })
// .catch(error => {
//     console.log("Error" + error);
// })
// console.log(orders.every(order => order instanceof Orders));
// console.log('All orders:', JSON.stringify(orders, null, 2));