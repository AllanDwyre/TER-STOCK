const { DataTypes, Sequelize } = require("sequelize");
const sequelize = require("../config/db");
const initModels = require("../model/tables/init-models").initModels;
const models = initModels(sequelize);



module.exports = {

    getProduitPlusVendu : async function(req, res){

        try {
            const produitPlusVendu = await models.produit.findAll({
                include: [{
                    model: models.produit_vendu,
                    as: 'produit_vendus', // Spécifiez l'alias correct ici
                    attributes: [
                        [sequelize.fn('SUM', sequelize.col('QUANTITE')), 'totalVentes']
                    ],
                    group: ['produit_vendus.PRODUIT_ID'],
                    order: [[sequelize.literal('totalVentes'), 'DESC']],
                    limit: 1
                }]
            });

            res.json(produitPlusVendu);
        } catch (error) {
            console.error("Error retrieving most sold product:", error);
            res.status(500).json({ error: "Internal server error" });
        }
    }
    
}

