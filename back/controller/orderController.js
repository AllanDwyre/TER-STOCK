const DataTypes = require('sequelize');
const sequelize = require('../config/db');
//const router = express.Router();
const Produit = require('../model/tables/produit')(sequelize, DataTypes);
const CommFourn = require('../model/tables/commande_fournisseur')(sequelize, DataTypes);
const Fournisseur = require('../model/tables/fournisseur')(sequelize, DataTypes);
const Prod = require("../model/prodModel");
/*countTable(nomTable)*/
const KEY = process.env.DEV_KEY;
var jwt = require("jsonwebtoken");
const initModels = require("../model/tables/init-models").initModels;
const models = initModels(sequelize);
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
                        include: [
                        {
                            model:models.produit,
                            as:"PRODUIT_ID_produits",
                            required:true,
                            attributes:['NOM']
                        },
                        {
                            model: models.commande_client,
                            as:"commande_client",
                            attributes:['CLIENT_ID'],
                            required:false
                        },
                        {
                            model: models.commande_fournisseur,
                            as:"commande_fournisseur",
                            attributes:['FOURNISSEUR_ID'],
                            required:false
                        }
                    ]
                        ,
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
                    models.commande
                    .findAll({
                        include: [
                            {
                                model:models.produit,
                                as:"PRODUIT_ID_produits",
                                required:true,
                                attributes:['NOM']
                            },
                        
                            {
                                model: models.commande_fournisseur,
                                as:"commande_fournisseur",
                                required:true
                            }
                        ],
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
    
                case "exit":
                    models.commande
                    .findAll({
                        include: [
                            {
                                model:models.produit,
                                as:"PRODUIT_ID_produits",
                                required:true,
                                attributes:['NOM']
                            },
                        
                            {
                                model: models.commande_client,
                                as:"commande_client",
                                required:true
                            }
                        ],
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