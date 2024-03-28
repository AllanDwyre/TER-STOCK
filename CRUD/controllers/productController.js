const express = require('express');
const mysql = require('mysql2');

const app = express();
const PORT = 3000; // Vous pouvez ajuster le port selon vos besoins

// Créer une connexion à la base de données MySQL
const connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: 'hai501',
    database: 'stock'
});

// Middleware pour parser le corps de la requête en JSON
app.use(express.json());

const path = require('path');
app.get('/addProduct', (req, res) => {
    res.sendFile(path.join(__dirname, 'addProduct.html'));

// Middleware pour gérer les requêtes POST depuis le formulaire HTML

    const { id, nom, descr } = req.body;

    // Requête SQL pour insérer un nouveau produit dans la base de données
    const sql = `INSERT INTO PRODUIT (PRODUIT_ID, NOM, DESCR) VALUES (?, ?, ?)`;

    // Exécutez la requête SQL avec les valeurs fournies
    connection.query(sql, [id, nom, descr], (err, result) => {
        if (err) {
            console.error("Erreur lors de l'ajout du produit :", err);
            return res.status(500).send("Erreur lors de l'ajout du produit");
        }
        console.log("Produit ajouté avec succès !");
        res.status(200).send("Produit ajouté avec succès !");
    });
});



// Démarrer le serveur
app.listen(PORT, () => {
    console.log(`Serveur démarré sur le port ${PORT}`);
});
