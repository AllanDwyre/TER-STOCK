const express = require('express');
const router = express.Router();
const Product = require('../model/tables/produit')(sequelize, Sequelize);

// Route pour ajouter un nouveau produit
router.post('/ajouter-produit', async (req, res) => {
    try {
        // Récupérez les données envoyées par le client
        const { NOM, DESCR, PRIX_UNIT, POIDS, DIMENSIONS, MAGASIN_ENTREPOT, CODE_BARRE_PRODUIT, QR_CODE_PRODUIT, CATEGORIE_ID, EMPLACEMENT_ID } = req.body;

        // Créez un nouveau produit dans la base de données
        const nouveauProduit = await Product.create({
            NOM,
            DESCR,
            PRIX_UNIT,
            POIDS,
            DIMENSIONS,
            MAGASIN_ENTREPOT,
            CODE_BARRE_PRODUIT,
            QR_CODE_PRODUIT,
            CATEGORIE_ID,
            EMPLACEMENT_ID
        });

        res.status(201).json({ message: 'Produit ajouté avec succès', produit: nouveauProduit });
    } catch (error) {
        console.error('Erreur lors de l\'ajout du produit :', error);
        res.status(500).json({ error: 'Erreur interne du serveur' });
    }
});

module.exports = router;
