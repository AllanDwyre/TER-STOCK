const Prod = require('../model/prodModel');

module.exports = {

// recuperer tout les produits
getAllProducts : async (req, res) => {
    try {
        const products = await db.PRODUIT.findAll();
        res.json(products);
    } catch (error) {
        res.status(500).json({ message: 'Erreur lors de la récupération des produits: ' + error.message });
    }
  },
  // recuperer un seul produit specifique 
  getProductById :async (req, res) => {
    try {
        const productId = req.params.id;
        const product = await db.PRODUIT.findByPk(productId);
        if (!product) {
            return res.status(404).json({ message: 'Produit non trouvé' });
        }
        res.json(product);
    } catch (error) {
        res.status(500).json({ message: 'Erreur lors de la récupération du produit: ' + error.message });
    }
  },
  // Creer un nouveau produit 
  createProduct :async (req, res) => {
    try {
        const productData = req.body;
        const newProduct = await db.PRODUIT.create(productData);
        res.status(201).json(newProduct);
    } catch (error) {
        res.status(500).json({ message: 'Erreur lors de la création du produit: ' + error.message });
    }
  },
  // Update un produit en lui passant en parametre un id 
  updateProduct : async (req, res) => {
    try {
        const productId = req.params.id;
        const newData = req.body;
        const product = await db.PRODUIT.findByPk(productId);
        if (!product) {
            return res.status(404).json({ message: 'Produit non trouvé' });
        }
        await product.update(newData);
        res.json(product);
    } catch (error) {
        res.status(500).json({ message: 'Erreur lors de la mise à jour du produit: ' + error.message });
    }
  },
  // Delete un produit en lui passant en parametre un id 
  deleteProduct : async (req, res) => {
    try {
        const productId = req.params.id;
        const product = await db.PRODUIT.findByPk(productId);
        if (!product) {
            return res.status(404).json({ message: 'Produit non trouvé' });
        }
        await product.destroy();
        res.json({ message: 'Produit supprimé avec succès' });
    } catch (error) {
        res.status(500).json({ message: 'Erreur lors de la suppression du produit: ' + error.message });
    }
  },
}