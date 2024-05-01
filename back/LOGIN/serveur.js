var express = require('express');
const bodyParser = require('body-parser');
const session = require('express-session');
var sequelize = require('./config/db.js');
const { DataTypes } = require('sequelize');
const User = require('./model/tables/users')(sequelize, DataTypes);

var app = express();

// Configuration du middleware de session
app.use(session({
  secret: 'votre_secret', // Changez ceci pour une valeur aléatoire pour sécuriser les sessions
  resave: false,
  saveUninitialized: true
}));

// autre test bla
// Ajout des middlewares
//app.use(express.urlencoded({ extended: true }));
// Ajout des middlewares
app.use(bodyParser.json()); // pour le format JSON brut
app.use(bodyParser.raw()); // pour tout autre type de données brutes


// Connexion de Sequelize à l'application Express
app.use(function(req, res, next) {
  req.sequelize = sequelize;
  next();
});

// Import des routes
const authRouter = require("./routes/routes");

// Utilisation des routes
app.use("/", authRouter);

// Route pour afficher un message sur la page localhost
app.get('/', function(req, res) {
  res.send('Bienvenue sur la page d\'accueil !');
});

// Définition du port d'écoute
let port = process.env.PORT || 3000;
app.listen(port, function () {
  return console.log("Serveur Login utilisateur en écoute sur le port " + port);
});
