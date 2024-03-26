/* Dans votre fichier app.js ou index.js

const express = require('express');
const router = express.Router();
const productController = require('./controllers/productController');

// Route pour récupérer les produits disponibles
router.get('/products', productController.getProducts);

// ROute pour ajouter un produit
router.post('/add-product', productController.addProduct);

module.exports = router;
*/


const express = require('express');
const productsRouter = require('../routes/productRouter');

const app = express();
const PORT = process.env.PORT || 3000;

// Utiliser le routeur pour les produits
app.use('/products', productsRouter);

// Servir les fichiers statiques depuis le dossier 'public'
app.use(express.static('public'));

// Démarrer le serveur
app.listen(PORT, () => {
    console.log(`Serveur en écoute sur le port ${PORT}`);
});