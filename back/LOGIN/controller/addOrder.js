const DataTypes = require('sequelize');
const sequelize = require('../config/db');
//const router = express.Router();
const Produit = require('../model/tables/produit')(sequelize, DataTypes);
const Categorie = require('../model/tables/categorie')(sequelize, DataTypes);
const Fournisseur = require('../model/tables/fournisseur')(sequelize, DataTypes);


module.exports = {

    newOrder : function (req, res){

        const { 
            nomProduit,
            produitID,
            supplierName,
            productCategorie,
            quantiteProd,
            unitProd,
            produitPrix,
            dateOrder
            // il faut correpondre  les champs avec le front
          } = req.body;  

        

    }




}