const express = require('express');
const router = express.Router();
const Product = require('../model/tables/produit')(sequelize, Sequelize);

module.exports = {
    addProduit: async function(req, res) {
      try {
        const { 
          nom,
          productId,
          supplierName,
          productCategorie,
          productUnityMeasure,
          productBuyingPrice,
          // il faut correpondre  les champs avec le front
        } = req.body;   
  
        // Créez le produit dans la base de données
        const nouveauProduit = await Produit.create({
          NOM: nom,
          PRODUCT_ID: productId,
          SUPPLIER_NAME: supplierName,
          PRODUCT_CATEGORIE: productCategorie,
          PRODUCT_UNITY_MEASURE: productUnityMeasure,
          PRODUCT_BUYING_PRICE: productBuyingPrice,
          // Affectez d'autres champs de produit ici selon les données reçues
        });
  
        res.status(201).json({ success: true, produit: nouveauProduit });
      } catch (error) {
        console.error('Erreur lors de l\'ajout du produit :', error);
        res.status(500).json({ success: false, message: "Une erreur s'est produite lors de l'ajout du produit." });
      }
    }
  };