// Dans votre fichier productController.js

const mysql = require('mysql2');

// Créer une connexion à la base de données MySQL
const connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: 'hai501',
    database: 'stock'
});

// Fonction pour récupérer les produits disponibles dans le stock
exports.getProducts = (req, res) => {
    // Requête SQL pour récupérer les produits disponibles
    const sql = `SELECT NOM FROM PRODUIT`;

    // Exécutez la requête SQL pour récupérer les noms des produits
    connection.query(sql, (err, results) => {
        if (err) {
            console.error("Erreur lors de la récupération des produits :", err);
            return res.status(500).send("Erreur lors de la récupération des produits");
        }
        // Renvoyer les noms des produits au format JSON
        res.status(200).json(results);
    });
};


// Fonction pour ajouter un produit au stock
exports.addProduct = (req, res) => {
    const { nom, prixUnitaire, quantite, dateExpiration } = req.body;

    // Requête SQL pour insérer un nouveau produit dans la base de données
    const sql = `INSERT INTO PRODUIT (PRODUIT_ID, NOM, PRIX_UNIT,) VALUES (1332, kiwi, 2)`;
    
    // Exécutez la requête SQL avec les valeurs fournies
    connection.query(sql, [nom, prixUnitaire, dateExpiration], (err, result) => {
        if (err) {
            console.error("Erreur lors de l'ajout du produit :", err);
            return res.status(500).send("Erreur lors de l'ajout du produit");
        }
        console.log("Produit ajouté avec succès !");
        res.status(200).send("Produit ajouté avec succès !");
    });
};
