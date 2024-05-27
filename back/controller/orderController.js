const DataTypes = require('sequelize');
const sequelize = require('../config/db');
//const router = express.Router();
const CommFourn = require('../model/tables/commande_fournisseur')(sequelize, DataTypes);
const initModels = require("../model/tables/init-models").initModels;
const models = initModels(sequelize);

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
    },
    getOrderPagination: async (req, res) => {
        try {
            const start = parseInt(req.query.start);
            const limit = parseInt(req.query.limit);
            const type = req.query.type;
    
            if (isNaN(start) || isNaN(limit)) {
                throw new Error(
                "start and limit must be enter as a positive number !"
                );
            }

            const allowedTypes = ['all', 'exit', 'entry'];

            // Check if the parameter matches one of the allowed values
            if (!allowedTypes.includes(type)) {
                return res.status(400).json({ message: 'Invalid type parameter. Valid types : all - exit - entry' });
            }
            console.log(`Order pagination => start : ${start}, limit : ${limit}`);
            switch(type){
                case "all":
                    models.commande
                    .findAll({
                        order: [["COMMANDE_ID", "ASC"]],
                        offset: start,
                        limit: limit,
                    })
                    .then((result) => {
                        const formattedResult = result.map((commande) => {
                        return commande.dataValues;
                        });
                        console.table(formattedResult);
                        console.table(
                        formattedResult.map((commande) => {
                            return commande.dataValues;
                        })
                        );
                        res.status(200).json(result);
                    })
                    .catch((error) => {
                        console.error("Error fetching orders:", error);
                    });
                    break;
    
                case "entry":
                    models.commande_fournisseur
                    .findAll({
                        order: [["COMM_FOURN_ID", "ASC"]],
                        offset: start,
                        limit: limit,
                    })
                    .then((result) => {
                        const formattedResult = result.map((commande_fournisseur) => {
                        return commande_fournisseur.dataValues;
                        });
                        console.table(formattedResult);
                        console.table(
                        formattedResult.map((commande_fournisseur) => {
                            return commande_fournisseur.dataValues;
                        })
                        );
                        res.status(200).json(result);
                    })
                    .catch((error) => {
                        console.error("Error fetching entry orders:", error);
                    });
                    break;
    
                case "exit":
                    models.commande_client
                    .findAll({
                    order: [["COMM_CLIENT_ID", "ASC"]],
                    offset: start,
                    limit: limit,
                    })
                    .then((result) => {
                    const formattedResult = result.map((commande_client) => {
                        return commande_client.dataValues;
                    });
                    console.table(formattedResult);
                    console.table(
                        formattedResult.map((commande_client) => {
                        return commande_client.dataValues;
                        })
                    );
                    res.status(200).json(result);
                    })
                    .catch((error) => {
                    console.error("Error fetching exit orders:", error);
                    });
            }
        } 
        catch (error) {
            res.status(500).json({
            message:
            "Erreur lors de la récupération des commandes: " + error.message,
            });
        }
      }
    }