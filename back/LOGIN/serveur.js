var express = require('express');
var sequelize = require('./config/db.js');
const { Sequelize } = require('sequelize');
const User = require('./model/users')(sequelize, Sequelize);

var app = express();
// test
// Ajout des middlewares
app.use(express.urlencoded());

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
