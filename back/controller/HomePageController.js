const { Op, literal } = require("sequelize");
const sequelize = require("../config/db");
const KEY = process.env.DEV_KEY;
var jwt = require("jsonwebtoken");
const initModels = require("../model/tables/init-models").initModels;
const models = initModels(sequelize);

// Trouver tous les produits

const sharedData= {
    sal:'',
    commF:[]
}

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
     // récupérer le nombre total de commande
    getTotalOrders: async (req, res) => {
        try {
          const totalOrdersCount = await models.commande.count();
          res.status(200).json({ totalOrdersCount });
        } catch (error) {
          res.status(500).json({
            message: "Erreur lors de la récupération du nombre total de commande: " + error.message,
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

    //le dessin 
    getSalesAndPurchasesByMonth: async (req, res) => {
        try {

            // Calculer la date de début des 12 derniers mois
            const startDate = new Date();
            startDate.setMonth(startDate.getMonth() - 12);

            const sales2 = await models.produit_vendu.findAll({
                attributes: [
                    [sequelize.literal('YEAR(`VENTE`.`DATE_VENTE`)'), 'Année'],
                    [sequelize.literal('MONTH(`VENTE`.`DATE_VENTE`)'), 'Mois'],
                    //[sequelize.literal('MONTH(date_commande)'), 'Month'],
                    [sequelize.fn('SUM', sequelize.col('QUANTITE')), 'sales2']
                ],
                include: [
                    {
                        model: models.vente,
                        as: "VENTE",
                        attributes: [],
                        where: {
                            DATE_VENTE: {
                                [Op.between]: [startDate, new Date()]
                            }
                        }
                    }
                ],
                group: [
                    sequelize.literal('YEAR(`VENTE`.`DATE_VENTE`)'),
                    sequelize.literal('MONTH(`VENTE`.`DATE_VENTE`)')
                ],
                order: [
                    [sequelize.literal('YEAR(`VENTE`.`DATE_VENTE`)'), 'DESC'],
                    [sequelize.literal('MONTH(`VENTE`.`DATE_VENTE`)'), 'DESC']
                ]
            });
            console.log(sales2.map(record => record.get()));
            const salesData = sales2.map(record => record.get());

            
            sharedData.sal = sales2;

            // Requête pour la somme de la quantité achetée par mois
            const purchaseOrders = await models.commande_fournisseur.findAll({
                attributes: ['COMM_FOURN_ID'],
                where: {
                    TYPE_COMMANDE: 'commande'
                }
            
            }).then(result => {
                for(const com in result){
                    //console.log(result[com])
                    sharedData.commF.push(result[com].dataValues);
                    //console.log(sharedData.commF)
                }
              
                //console.log(sharedData.commF)
                
            });
            //console.log(sharedData.commF)

            const commandeIds = sharedData.commF.map(item => item.COMM_FOURN_ID);
            
            const purchases = await models.ligne_commande.findAll({
                attributes: [
                    [sequelize.literal('YEAR(`COMMANDE`.`DATE_COMMANDE`)'), 'Année'],
                    [sequelize.literal('MONTH(`COMMANDE`.`DATE_COMMANDE`)'), 'Mois'],
                    [sequelize.fn('SUM', sequelize.col('QUANTITE')), 'Purchases']
                ],
                where: {
                    commande_id: {
                        [Op.in]: commandeIds
                    }
                },
                include: [
                    {
                        model: models.commande,
                        as: "COMMANDE",
                        attributes: [],
                        where: {
                            DATE_COMMANDE: {
                                [Op.between]: [startDate, new Date()]
                            }
                        }
                    }
                ],
                group: [
                    sequelize.literal('YEAR(`COMMANDE`.`DATE_COMMANDE`)'),
                    sequelize.literal('MONTH(`COMMANDE`.`DATE_COMMANDE`)')
                ],
                order: [
                    [sequelize.literal('YEAR(`COMMANDE`.`DATE_COMMANDE`)'), 'DESC'],
                    [sequelize.literal('MONTH(`COMMANDE`.`DATE_COMMANDE`)'), 'DESC']
                ]
            });

            //console.log(purchases.get('Purchases'));
            console.log(purchases.map(record => record.get()));
            const purchaseData = purchases.map(record => record.get());

            // Fusionner les résultats des ventes et des achats par mois
            const mergedData = {};

            salesData.forEach(sale => {
                const key = `${sale['Année']}-${sale['Mois']}`;
                if (!mergedData[key]) {
                    mergedData[key] = { Mois: `${sale['Année']}-${sale['Mois']}`, Sales: 0, Purchases: 0 };
                }
                mergedData[key].Sales = sale.sales2;
            });

            purchaseData.forEach(purchase => {
                const key = `${purchase['Année']}-${purchase['Mois']}`;
                if (!mergedData[key]) {
                    mergedData[key] = { Mois: `${purchase['Année']}-${purchase['Mois']}`, Sales: 0, Purchases: 0 };
                }
                mergedData[key].Purchases = purchase.Purchases;
            });

            const result = Object.values(mergedData);
            console.log(result);
            res.status(200).json(result);

        } catch (error) {
            console.error('Erreur lors de la récupération des ventes et des achats par mois :', error);
            res.status(500).json({
                message: 'Erreur lors de la récupération des ventes et des achats par mois.'
            });
        }
    },
}

