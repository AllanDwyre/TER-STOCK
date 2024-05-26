const { Op, literal } = require("sequelize");
const { Sequelize } = require("sequelize");
const sequelize = require("../config/db");
const KEY = process.env.DEV_KEY;
var jwt = require("jsonwebtoken");
const initModels = require("../model/tables/init-models").initModels;
const models = initModels(sequelize);

// Trouver tous les produits

// Fonction pour obtenir le nom du mois
function getMonthName(monthNumber) {
    const monthNames = [
        "Janvier", "Février", "Mars", "Avril", "Mai", "Juin",
        "Juillet", "Août", "Septembre", "Octobre", "Novembre", "Décembre"
    ];
    return monthNames[monthNumber - 1];
}

// Fonction pour obtenir le numéro de la semaine d'une date
function getWeekNumber(d) {
    d = new Date(Date.UTC(d.getFullYear(), d.getMonth(), d.getDate()));
    d.setUTCDate(d.getUTCDate() + 4 - (d.getUTCDay() || 7));
    var yearStart = new Date(Date.UTC(d.getUTCFullYear(), 0, 1));
    var weekNo = Math.ceil((((d - yearStart) / 86400000) + 1) / 7);
    return weekNo;
}

// Fonction pour obtenir la date du premier jour de la semaine à partir de l'année et du numéro de la semaine
function getFirstDayOfWeek(year, week) {
    const simple = new Date(year, 0, 1 + (week - 1) * 7);
    const dow = simple.getDay();
    const ISOweekStart = simple;
    if (dow <= 4)
        ISOweekStart.setDate(simple.getDate() - simple.getDay() + 1);
    else
        ISOweekStart.setDate(simple.getDate() + 8 - simple.getDay());
    return ISOweekStart;
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

            // Requête pour récupérer les commandes aux fournisseurs 
            const purchaseOrders = await models.commande_fournisseur.findAll({
                attributes: ['COMM_FOURN_ID'],
                where: {
                    TYPE_COMMANDE: 'commande'
                }
            
            });

            const commandeIds = purchaseOrders.map(order => order.COMM_FOURN_ID);

            
            // Requête pour la somme de la quantité achetée par mois
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
                const monthName = getMonthName(sale['Mois']);
                if (!mergedData[key]) {
                    mergedData[key] = { Mois:  `${monthName} ${sale['Année']}`, Sales: 0, Purchases: 0 };
                }
                mergedData[key].Sales = sale.sales2;
            });

            purchaseData.forEach(purchase => {
                const key = `${purchase['Année']}-${purchase['Mois']}`;
                const monthName = getMonthName(purchase['Mois']);
                if (!mergedData[key]) {
                    mergedData[key] = { Mois:  `${monthName} ${purchase['Année']}`, Sales: 0, Purchases: 0 };
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

    getSalesAndPurchasesByPeriod: async (req, res) => {
        try {
            const period = req.query.period || 'month'; // 'day', 'week', 'month'
            
            // Calculer la date de début en fonction de la période
            const startDate = new Date();
            if (period === 'day') {
                startDate.setDate(startDate.getDate() - 12);
            } else if (period === 'week') {
                startDate.setDate(startDate.getDate() - 7 * 12);
            } else { // 'month'
                startDate.setMonth(startDate.getMonth() - 12);
            }
    
            let dateColumn, groupByColumns, groupByColumnsComm;
    
            if (period === 'day') {
                dateColumn = 'DATE_VENTE';
                groupByColumns = [
                    sequelize.literal('YEAR(`VENTE`.`DATE_VENTE`)'),
                    sequelize.literal('MONTH(`VENTE`.`DATE_VENTE`)'),
                    sequelize.literal('DAY(`VENTE`.`DATE_VENTE`)')
                ];
                groupByColumnsComm = [
                    sequelize.literal('YEAR(`COMMANDE`.`DATE_COMMANDE`)'),
                    sequelize.literal('MONTH(`COMMANDE`.`DATE_COMMANDE`)'),
                    sequelize.literal('DAY(`COMMANDE`.`DATE_COMMANDE`)')
                ];
            } else if (period === 'week') {
                dateColumn = 'DATE_VENTE';
                groupByColumns = [
                    sequelize.literal('YEAR(`VENTE`.`DATE_VENTE`)'),
                    sequelize.literal('WEEK(`VENTE`.`DATE_VENTE`, 3)') // MySQL specific syntax for ISO week number
                ];
                groupByColumnsComm = [
                    sequelize.literal('YEAR(`COMMANDE`.`DATE_COMMANDE`)'),
                    sequelize.literal('WEEK(`COMMANDE`.`DATE_COMMANDE`, 3)')
                ];
            } else { // 'month'
                dateColumn = 'DATE_VENTE';
                groupByColumns = [
                    sequelize.literal('YEAR(`VENTE`.`DATE_VENTE`)'),
                    sequelize.literal('MONTH(`VENTE`.`DATE_VENTE`)')
                ];
                groupByColumnsComm = [
                    sequelize.literal('YEAR(`COMMANDE`.`DATE_COMMANDE`)'),
                    sequelize.literal('MONTH(`COMMANDE`.`DATE_COMMANDE`)')
                ];
            }
    
            // Requête pour les ventes
            const sales2 = await models.produit_vendu.findAll({
                attributes: [
                    [sequelize.literal('YEAR(`VENTE`.`DATE_VENTE`)'), 'Année'],
                    [sequelize.literal(`MONTH(\`VENTE\`.\`${dateColumn}\`)`), 'Mois'],
                    ...(period === 'day' ? [[sequelize.literal('DAY(`VENTE`.`DATE_VENTE`)'), 'Jour']] : []),
                    ...(period === 'week' ? [[sequelize.literal('WEEK(`VENTE`.`DATE_VENTE`, 3)'), 'Semaine']] : []),
                    [sequelize.fn('SUM', sequelize.col('QUANTITE')), 'sales2']
                ],
                include: [
                    {
                        model: models.vente,
                        as: "VENTE",
                        attributes: [],
                        where: {
                            [dateColumn]: {
                                [Op.between]: [startDate, new Date()]
                            }
                        }
                    }
                ],
                group: groupByColumns,
                order: [
                    [sequelize.literal('YEAR(`VENTE`.`DATE_VENTE`)'), 'DESC'],
                    ...groupByColumns.slice(1).map(col => [col, 'DESC'])
                ]
            });
            const salesData = sales2.map(record => record.get());
    
            // Requête pour récupérer les commandes aux fournisseurs 
            const purchaseOrders = await models.commande_fournisseur.findAll({
                attributes: ['COMM_FOURN_ID'],
                where: {
                    TYPE_COMMANDE: 'commande'
                }
            });
    
            const commandeIds = purchaseOrders.map(order => order.COMM_FOURN_ID);
    
            // Requête pour la somme de la quantité achetée par mois
            const purchases = await models.ligne_commande.findAll({
                attributes: [
                    [sequelize.literal('YEAR(`COMMANDE`.`DATE_COMMANDE`)'), 'Année'],
                    [sequelize.literal('MONTH(`COMMANDE`.`DATE_COMMANDE`)'), 'Mois'],
                    ...(period === 'day' ? [[sequelize.literal('DAY(`COMMANDE`.`DATE_COMMANDE`)'), 'Jour']] : []),
                    ...(period === 'week' ? [[sequelize.literal('WEEK(`COMMANDE`.`DATE_COMMANDE`, 3)'), 'Semaine']] : []),
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
                group: groupByColumnsComm,
                order: [
                    [sequelize.literal('YEAR(`COMMANDE`.`DATE_COMMANDE`)'), 'DESC'],
                    ...groupByColumnsComm.slice(1).map(col => [col, 'DESC'])
                ]
            });
    
            const purchaseData = purchases.map(record => record.get());
    
            // Fusionner les résultats des ventes et des achats par période
            const mergedData = {};
    
            salesData.forEach(sale => {
                let key, displayName;
                if (period === 'day') {
                    key = `${sale['Année']}-${sale['Mois']}-${sale['Jour']}`;
                    displayName = `${sale['Jour']} ${getMonthName(sale['Mois'])} ${sale['Année']}`;
                } else if (period === 'week') {
                    key = `${sale['Année']}-W${sale['Semaine']}`;
                    const firstDayOfWeek = getFirstDayOfWeek(sale['Année'], sale['Semaine']);
                    displayName = `Semaine du ${firstDayOfWeek.toLocaleDateString()} - Semaine ${sale['Semaine']} de l'année ${sale['Année']}`;
                    //displayName = `Semaine ${sale['Semaine']} ${sale['Année']}`;
                } else {
                    key = `${sale['Année']}-${sale['Mois']}`;
                    displayName = `${getMonthName(sale['Mois'])} ${sale['Année']}`;
                }
    
                if (!mergedData[key]) {
                    mergedData[key] = { Période: displayName, Sales: 0, Purchases: 0 };
                }
                mergedData[key].Sales = sale.sales2;
            });
    
            purchaseData.forEach(purchase => {
                let key, displayName;
                if (period === 'day') {
                    key = `${purchase['Année']}-${purchase['Mois']}-${purchase['Jour']}`;
                    displayName = `${purchase['Jour']} ${getMonthName(purchase['Mois'])} ${purchase['Année']}`;
                } else if (period === 'week') {
                    key = `${purchase['Année']}-W${purchase['Semaine']}`;
                    const firstDayOfWeek = getFirstDayOfWeek(purchase['Année'], purchase['Semaine']);
                    displayName = `Semaine du ${firstDayOfWeek.toLocaleDateString()} - Semaine ${purchase['Semaine']} de l'année ${purchase['Année']}`;
                    //displayName = `Semaine ${purchase['Semaine']} ${purchase['Année']}`;
                } else {
                    key = `${purchase['Année']}-${purchase['Mois']}`;
                    displayName = `${getMonthName(purchase['Mois'])} ${purchase['Année']}`;
                }
    
                if (!mergedData[key]) {
                    mergedData[key] = { Période: displayName, Sales: 0, Purchases: 0 };
                }
                mergedData[key].Purchases = purchase.Purchases;
            });
    
            const result = Object.values(mergedData);
            console.log(result);
            res.status(200).json(result);
    
        } catch (error) {
            console.error('Erreur lors de la récupération des ventes et des achats par période :', error);
            res.status(500).json({
                message: 'Erreur lors de la récupération des ventes et des achats par période.'
            });
        }
    },
    /// stock value = la somme des prix de tout les commandes 
    getTotalOrdersPrice : async (req, res) => {
        try {
            const totalOrdersPrice = await models.commande.sum('PRIX_TOTAL');
    
            res.status(200).json({ totalOrdersPrice });
        } catch (error) {
            console.error("Erreur lors de la récupération de la somme des prix des commandes:", error);
            res.status(500).json({
                message: "Erreur lors de la récupération de la somme des prix des commandes: " + error.message
            });
        }
    },
    
}

