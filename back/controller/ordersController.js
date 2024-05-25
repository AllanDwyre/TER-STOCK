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
    getOrdersInTransitFournisseur: async (req, res) => {
      try {
          const ordersInTransitFournisseur = await models.commande_fournisseur.findAll({
              where: {
                  DATE_REEL_RECU: null,
                  TYPE_COMMANDE : "commande"
              }
          });
          res.status(200).json({ ordersInTransitFournisseur });
      } catch (error) {
          res.status(500).json({
              message: "Erreur lors de la récupération des commandes des fournisseurs en route : " + error.message
          });
      }
    },
    
    getOrdersInTransitClient: async (req,res) => {
      try {
        const ordersInTransitClient = await models.commande_client.findAll({
          where: {
            DATE_REEL_RECU: null,
            TYPE_COMMANDE : "commande"
          }
        });
        res.status(200).json({ ordersInTransitClient });
      }catch (error) {
        res.status(500).json({
            message: "Erreur lors de la récupération des commandes des clients en route : " + error.message
        });
      }
    }

}