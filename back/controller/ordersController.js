const { Sequelize } = require("sequelize");
const sequelize = require("../config/db");
const KEY = process.env.DEV_KEY;
var jwt = require("jsonwebtoken");
const initModels = require("../model/tables/init-models").initModels;
const models = initModels(sequelize);

/////totale orders////
module.exports = {
    // récupérer le nombre total de commande
    getTotalOrdersCount: async (req, res) => {
      try {
        const totalOrdersCount = await models.commande.count();
        res.status(200).json({ totalOrdersCount });
      } catch (error) {
        res.status(500).json({
          message: "Erreur lors de la récupération du nombre total de commande: " + error.message,
        });
      }
    },
     //////totale commande////
    getTotalOrdersCount: async (req, res) => {
        try {
        const totalOrdersCount = await models.commande.count();
        res.status(200).json({ totalOrdersCount });
        } catch (error) {
        res.status(500).json({
            message: "Erreur lors de la récupération du nombre total de commande: " + error.message,
        });
        }
    },
    ///total commande recu
    getTotalOrdersReceived: async (req, res) => {
      try {
          const getTotalOrdersReceived = await models.commande.count({
              where: {
                Date_Reel_Recu: {
                  [Sequelize.Op.ne]: null 
              }
              }
          });
          res.status(200).json({ getTotalOrdersReceived });
      } catch (error) {
          res.status(500).json({
              message: "Erreur lors de la récupération du nombre total de commandes recu: " + error.message
          });
        }
    },
    ///totale commande retourner
    getReturnOrdersCount: async (req, res) => {
      try {
          const returnOrdersCount = await models.commande_fournisseur.count({
              where: {
                type_commande: 'retour'
              }
          });
          res.status(200).json({ returnOrdersCount });
      } catch (error) {
          res.status(500).json({
              message: "Erreur lors de la récupération du nombre de commandes de type retour : " + error.message
          });
      }
    },
    //// total commande en route
    getOrdersInTransit: async (req, res) => {
      try {
          const ordersInTransit = await models.commande.findAll({
              where: {
                  Date_Reel_Recu: null 
              }
          });
          res.status(200).json({ ordersInTransit });
      } catch (error) {
          res.status(500).json({
              message: "Erreur lors de la récupération des commandes en route : " + error.message
          });
      }
  }
  


   
  

}