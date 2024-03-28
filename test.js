// Importer le module MySQL
const mysql = require('mysql2');

// Configuration de la connexion à la base de données
const connection = mysql.createConnection({
  host: 'localhost', // L'hôte de la base de données (par exemple, 'localhost' si la base de données est en local)
  user: 'root', // Le nom d'utilisateur de la base de données
  password: 'hai501', // Le mot de passe de la base de données
  database: 'stock' // Le nom de la base de données à laquelle se connecter
});

// Établir la connexion à la base de données
connection.connect((err) => {
  if (err) {
    console.error('Erreur de connexion à la base de données :', err.stack);
    return;
  }

  console.log('Connecté à la base de données MySQL avec l\'identifiant', connection.threadId);
});

// Exécuter une requête SQL
connection.query('DESCRIBE PRODUIT', (err, rows) => {
  if (err) throw err;

  console.log('Données récupérées de la base de données :', rows);
});

// Fermer la connexion à la base de données après avoir exécuté la requête
connection.end((err) => {
  if (err) {
    console.error('Erreur lors de la fermeture de la connexion à la base de données :', err.stack);
    return;
  }

  console.log('Connexion à la baseee de données fermée.');
});
