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