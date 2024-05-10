///////////////////////REQUETES//////////
//requetes qui envoie tout les informations de produit au front
const Product = require('../model/tables/produit')(sequelize, DataTypes);
const Orders = require('../model/tables/commande')(sequelize, DataTypes);

// Trouver tous les produits

Product.findAll()
.then(res => {
    console.log(res);
})
.catch(error => {
    console.log("Erreur" + error);
})
console.log(products.every(product => product instanceof Product)); // true
console.log('All products:', JSON.stringify(products, null, 2));

//Trouver tous les commandes 

Orders.findOne()
.then(res => {
    console.log(res);
})
.catch(error => {
    console.log("Error" + error);
})
console.log(orders.every(order => order instanceof Orders));
console.log('All orders:', JSON.stringify(orders, null, 2));



// Route pour récupérer toutes les informations sur les produits
app.get('/produits', async (req, res) => {
    try {
      // Récupérer tous les produits depuis la base de données
      const produits = await Produit.findAll();
  
      // Envoyer les produits au format JSON en réponse
      res.json(produits);
    } catch (error) {
      // En cas d'erreur, renvoyer un code d'erreur avec un message approprié
      console.error('Erreur lors de la récupération des produits:', error);
      res.status(500).json({ message: 'Erreur lors de la récupération des produits.' });
    }
  });
// envoie une liste de json
  module.exports = {
    envoieProduit: async function(req, res) {
        try {
            const produits = await produit.findAll();
            res.json(produits);
        } catch (error) {
            console.error('Erreur lors de la récupération des produits :', error);
            res.status(500).json({ error: 'Erreur lors de la récupération des produits : ' });
        }
    }
};
