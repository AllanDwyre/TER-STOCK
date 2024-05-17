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

}