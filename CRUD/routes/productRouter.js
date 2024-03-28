// Dans votre fichier app.js ou index.js

const express = require('express');
const router = express.Router();
const productController = require('./controllers/productController');

// Route pour récupérer les produits
router.get('/products', productController.getProducts);

module.exports = router;
