var DataTypes = require("sequelize").DataTypes;
var _ADRESSE = require("./ADRESSE");
var _CATEGORIE = require("./CATEGORIE");
var _CLIENT = require("./CLIENT");
var _COMMANDE_ENTREE = require("./COMMANDE_ENTREE");
var _COMMANDE_SORTIE = require("./COMMANDE_SORTIE");
var _EMPLACEMENT = require("./EMPLACEMENT");
var _EMPLOYE = require("./EMPLOYE");
var _FACTURE = require("./FACTURE");
var _FOURNISSEUR = require("./FOURNISSEUR");
var _INVENTAIRE_LOT = require("./INVENTAIRE_LOT");
var _INVENTAIRE_PRODUIT = require("./INVENTAIRE_PRODUIT");
var _LIVRAISON = require("./LIVRAISON");
var _LOT_PRODUITS = require("./LOT_PRODUITS");
var _LOT_VENDU = require("./LOT_VENDU");
var _PRODUIT = require("./PRODUIT");
var _PRODUITS_ENTREES = require("./PRODUITS_ENTREES");
var _PRODUITS_SORTIES = require("./PRODUITS_SORTIES");
var _PRODUIT_LIVRE = require("./PRODUIT_LIVRE");
var _PRODUIT_VENDU = require("./PRODUIT_VENDU");
var _RECEPTION_COMMANDE = require("./RECEPTION_COMMANDE");
var _RETOUR_FOURNISSEUR = require("./RETOUR_FOURNISSEUR");
var _RETOUR_PRODUIT = require("./RETOUR_PRODUIT");
var _VENTE = require("./VENTE");
var _VENTES_REALISES = require("./VENTES_REALISES");

function initModels(sequelize) {
  var ADRESSE = _ADRESSE(sequelize, DataTypes);
  var CATEGORIE = _CATEGORIE(sequelize, DataTypes);
  var CLIENT = _CLIENT(sequelize, DataTypes);
  var COMMANDE_ENTREE = _COMMANDE_ENTREE(sequelize, DataTypes);
  var COMMANDE_SORTIE = _COMMANDE_SORTIE(sequelize, DataTypes);
  var EMPLACEMENT = _EMPLACEMENT(sequelize, DataTypes);
  var EMPLOYE = _EMPLOYE(sequelize, DataTypes);
  var FACTURE = _FACTURE(sequelize, DataTypes);
  var FOURNISSEUR = _FOURNISSEUR(sequelize, DataTypes);
  var INVENTAIRE_LOT = _INVENTAIRE_LOT(sequelize, DataTypes);
  var INVENTAIRE_PRODUIT = _INVENTAIRE_PRODUIT(sequelize, DataTypes);
  var LIVRAISON = _LIVRAISON(sequelize, DataTypes);
  var LOT_PRODUITS = _LOT_PRODUITS(sequelize, DataTypes);
  var LOT_VENDU = _LOT_VENDU(sequelize, DataTypes);
  var PRODUIT = _PRODUIT(sequelize, DataTypes);
  var PRODUITS_ENTREES = _PRODUITS_ENTREES(sequelize, DataTypes);
  var PRODUITS_SORTIES = _PRODUITS_SORTIES(sequelize, DataTypes);
  var PRODUIT_LIVRE = _PRODUIT_LIVRE(sequelize, DataTypes);
  var PRODUIT_VENDU = _PRODUIT_VENDU(sequelize, DataTypes);
  var RECEPTION_COMMANDE = _RECEPTION_COMMANDE(sequelize, DataTypes);
  var RETOUR_FOURNISSEUR = _RETOUR_FOURNISSEUR(sequelize, DataTypes);
  var RETOUR_PRODUIT = _RETOUR_PRODUIT(sequelize, DataTypes);
  var VENTE = _VENTE(sequelize, DataTypes);
  var VENTES_REALISES = _VENTES_REALISES(sequelize, DataTypes);

  COMMANDE_ENTREE.belongsToMany(PRODUIT, { as: 'PRODUIT_ID_PRODUITs', through: PRODUITS_ENTREES, foreignKey: "COMMANDE_E_ID", otherKey: "PRODUIT_ID" });
  COMMANDE_SORTIE.belongsToMany(PRODUIT, { as: 'PRODUIT_ID_PRODUIT_PRODUITS_SORTies', through: PRODUITS_SORTIES, foreignKey: "COMMANDE_S_ID", otherKey: "PRODUIT_ID" });
  EMPLOYE.belongsToMany(VENTE, { as: 'VENTE_ID_VENTE_VENTES_REALISEs', through: VENTES_REALISES, foreignKey: "EMPLOYE_ID", otherKey: "VENTE_ID" });
  LIVRAISON.belongsToMany(PRODUIT, { as: 'PRODUIT_ID_PRODUIT_PRODUIT_LIVREs', through: PRODUIT_LIVRE, foreignKey: "LIVRAISON_ID", otherKey: "PRODUIT_ID" });
  LOT_PRODUITS.belongsToMany(VENTE, { as: 'VENTE_ID_VENTEs', through: LOT_VENDU, foreignKey: "LOT_ID", otherKey: "VENTE_ID" });
  PRODUIT.belongsToMany(COMMANDE_ENTREE, { as: 'COMMANDE_E_ID_COMMANDE_ENTREEs', through: PRODUITS_ENTREES, foreignKey: "PRODUIT_ID", otherKey: "COMMANDE_E_ID" });
  PRODUIT.belongsToMany(COMMANDE_SORTIE, { as: 'COMMANDE_S_ID_COMMANDE_SORTIEs', through: PRODUITS_SORTIES, foreignKey: "PRODUIT_ID", otherKey: "COMMANDE_S_ID" });
  PRODUIT.belongsToMany(LIVRAISON, { as: 'LIVRAISON_ID_LIVRAISONs', through: PRODUIT_LIVRE, foreignKey: "PRODUIT_ID", otherKey: "LIVRAISON_ID" });
  PRODUIT.belongsToMany(VENTE, { as: 'VENTE_ID_VENTE_PRODUIT_VENDUs', through: PRODUIT_VENDU, foreignKey: "PRODUIT_ID", otherKey: "VENTE_ID" });
  VENTE.belongsToMany(EMPLOYE, { as: 'EMPLOYE_ID_EMPLOYEs', through: VENTES_REALISES, foreignKey: "VENTE_ID", otherKey: "EMPLOYE_ID" });
  VENTE.belongsToMany(LOT_PRODUITS, { as: 'LOT_ID_LOT_PRODUITs', through: LOT_VENDU, foreignKey: "VENTE_ID", otherKey: "LOT_ID" });
  VENTE.belongsToMany(PRODUIT, { as: 'PRODUIT_ID_PRODUIT_PRODUIT_VENDUs', through: PRODUIT_VENDU, foreignKey: "VENTE_ID", otherKey: "PRODUIT_ID" });
  CLIENT.belongsTo(ADRESSE, { as: "ADRESSE", foreignKey: "ADRESSE_ID"});
  ADRESSE.hasMany(CLIENT, { as: "CLIENTs", foreignKey: "ADRESSE_ID"});
  EMPLOYE.belongsTo(ADRESSE, { as: "ADRESSE", foreignKey: "ADRESSE_ID"});
  ADRESSE.hasMany(EMPLOYE, { as: "EMPLOYEs", foreignKey: "ADRESSE_ID"});
  FOURNISSEUR.belongsTo(ADRESSE, { as: "ADRESSE", foreignKey: "ADRESSE_ID"});
  ADRESSE.hasMany(FOURNISSEUR, { as: "FOURNISSEURs", foreignKey: "ADRESSE_ID"});
  PRODUIT.belongsTo(CATEGORIE, { as: "CATEGORIE", foreignKey: "CATEGORIE_ID"});
  CATEGORIE.hasMany(PRODUIT, { as: "PRODUITs", foreignKey: "CATEGORIE_ID"});
  FACTURE.belongsTo(CLIENT, { as: "CLIENT", foreignKey: "CLIENT_ID"});
  CLIENT.hasMany(FACTURE, { as: "FACTUREs", foreignKey: "CLIENT_ID"});
  PRODUITS_ENTREES.belongsTo(COMMANDE_ENTREE, { as: "COMMANDE_E", foreignKey: "COMMANDE_E_ID"});
  COMMANDE_ENTREE.hasMany(PRODUITS_ENTREES, { as: "PRODUITS_ENTREEs", foreignKey: "COMMANDE_E_ID"});
  RECEPTION_COMMANDE.belongsTo(COMMANDE_ENTREE, { as: "RECEP_FOURN", foreignKey: "RECEP_FOURN_ID"});
  COMMANDE_ENTREE.hasOne(RECEPTION_COMMANDE, { as: "RECEPTION_COMMANDE", foreignKey: "RECEP_FOURN_ID"});
  RETOUR_PRODUIT.belongsTo(COMMANDE_ENTREE, { as: "RETOUR", foreignKey: "RETOUR_ID"});
  COMMANDE_ENTREE.hasOne(RETOUR_PRODUIT, { as: "RETOUR_PRODUIT", foreignKey: "RETOUR_ID"});
  LIVRAISON.belongsTo(COMMANDE_SORTIE, { as: "LIVRAISON", foreignKey: "LIVRAISON_ID"});
  COMMANDE_SORTIE.hasOne(LIVRAISON, { as: "LIVRAISON", foreignKey: "LIVRAISON_ID"});
  PRODUITS_SORTIES.belongsTo(COMMANDE_SORTIE, { as: "COMMANDE_", foreignKey: "COMMANDE_S_ID"});
  COMMANDE_SORTIE.hasMany(PRODUITS_SORTIES, { as: "PRODUITS_SORTies", foreignKey: "COMMANDE_S_ID"});
  RETOUR_FOURNISSEUR.belongsTo(COMMANDE_SORTIE, { as: "RETOUR_FOURNISSEUR", foreignKey: "RETOUR_FOURNISSEUR_ID"});
  COMMANDE_SORTIE.hasOne(RETOUR_FOURNISSEUR, { as: "RETOUR_FOURNISSEUR", foreignKey: "RETOUR_FOURNISSEUR_ID"});
  VENTE.belongsTo(COMMANDE_SORTIE, { as: "VENTE", foreignKey: "VENTE_ID"});
  COMMANDE_SORTIE.hasOne(VENTE, { as: "VENTE", foreignKey: "VENTE_ID"});
  PRODUIT.belongsTo(EMPLACEMENT, { as: "EMPLACEMENT", foreignKey: "EMPLACEMENT_ID"});
  EMPLACEMENT.hasMany(PRODUIT, { as: "PRODUITs", foreignKey: "EMPLACEMENT_ID"});
  INVENTAIRE_LOT.belongsTo(EMPLOYE, { as: "EMPLOYE", foreignKey: "EMPLOYE_ID"});
  EMPLOYE.hasMany(INVENTAIRE_LOT, { as: "INVENTAIRE_LOTs", foreignKey: "EMPLOYE_ID"});
  INVENTAIRE_PRODUIT.belongsTo(EMPLOYE, { as: "EMPLOYE", foreignKey: "EMPLOYE_ID"});
  EMPLOYE.hasMany(INVENTAIRE_PRODUIT, { as: "INVENTAIRE_PRODUITs", foreignKey: "EMPLOYE_ID"});
  LIVRAISON.belongsTo(EMPLOYE, { as: "EMPLOYE", foreignKey: "EMPLOYE_ID"});
  EMPLOYE.hasMany(LIVRAISON, { as: "LIVRAISONs", foreignKey: "EMPLOYE_ID"});
  RECEPTION_COMMANDE.belongsTo(EMPLOYE, { as: "EMPLOYE", foreignKey: "EMPLOYE_ID"});
  EMPLOYE.hasMany(RECEPTION_COMMANDE, { as: "RECEPTION_COMMANDEs", foreignKey: "EMPLOYE_ID"});
  VENTE.belongsTo(EMPLOYE, { as: "EMPLOYE", foreignKey: "EMPLOYE_ID"});
  EMPLOYE.hasMany(VENTE, { as: "VENTEs", foreignKey: "EMPLOYE_ID"});
  VENTES_REALISES.belongsTo(EMPLOYE, { as: "EMPLOYE", foreignKey: "EMPLOYE_ID"});
  EMPLOYE.hasMany(VENTES_REALISES, { as: "VENTES_REALISEs", foreignKey: "EMPLOYE_ID"});
  VENTE.belongsTo(FACTURE, { as: "FACTURE", foreignKey: "FACTURE_ID"});
  FACTURE.hasMany(VENTE, { as: "VENTEs", foreignKey: "FACTURE_ID"});
  PRODUIT_LIVRE.belongsTo(LIVRAISON, { as: "LIVRAISON", foreignKey: "LIVRAISON_ID"});
  LIVRAISON.hasMany(PRODUIT_LIVRE, { as: "PRODUIT_LIVREs", foreignKey: "LIVRAISON_ID"});
  INVENTAIRE_LOT.belongsTo(LOT_PRODUITS, { as: "LOT", foreignKey: "LOT_ID"});
  LOT_PRODUITS.hasMany(INVENTAIRE_LOT, { as: "INVENTAIRE_LOTs", foreignKey: "LOT_ID"});
  LOT_VENDU.belongsTo(LOT_PRODUITS, { as: "LOT", foreignKey: "LOT_ID"});
  LOT_PRODUITS.hasMany(LOT_VENDU, { as: "LOT_VENDUs", foreignKey: "LOT_ID"});
  INVENTAIRE_PRODUIT.belongsTo(PRODUIT, { as: "PRODUIT", foreignKey: "PRODUIT_ID"});
  PRODUIT.hasMany(INVENTAIRE_PRODUIT, { as: "INVENTAIRE_PRODUITs", foreignKey: "PRODUIT_ID"});
  LOT_PRODUITS.belongsTo(PRODUIT, { as: "LOT", foreignKey: "LOT_ID"});
  PRODUIT.hasOne(LOT_PRODUITS, { as: "LOT_PRODUIT", foreignKey: "LOT_ID"});
  PRODUITS_ENTREES.belongsTo(PRODUIT, { as: "PRODUIT", foreignKey: "PRODUIT_ID"});
  PRODUIT.hasMany(PRODUITS_ENTREES, { as: "PRODUITS_ENTREEs", foreignKey: "PRODUIT_ID"});
  PRODUITS_SORTIES.belongsTo(PRODUIT, { as: "PRODUIT", foreignKey: "PRODUIT_ID"});
  PRODUIT.hasMany(PRODUITS_SORTIES, { as: "PRODUITS_SORTies", foreignKey: "PRODUIT_ID"});
  PRODUIT_LIVRE.belongsTo(PRODUIT, { as: "PRODUIT", foreignKey: "PRODUIT_ID"});
  PRODUIT.hasMany(PRODUIT_LIVRE, { as: "PRODUIT_LIVREs", foreignKey: "PRODUIT_ID"});
  PRODUIT_VENDU.belongsTo(PRODUIT, { as: "PRODUIT", foreignKey: "PRODUIT_ID"});
  PRODUIT.hasMany(PRODUIT_VENDU, { as: "PRODUIT_VENDUs", foreignKey: "PRODUIT_ID"});
  RETOUR_PRODUIT.belongsTo(PRODUIT, { as: "PRODUIT", foreignKey: "PRODUIT_ID"});
  PRODUIT.hasMany(RETOUR_PRODUIT, { as: "RETOUR_PRODUITs", foreignKey: "PRODUIT_ID"});
  LOT_VENDU.belongsTo(VENTE, { as: "VENTE", foreignKey: "VENTE_ID"});
  VENTE.hasMany(LOT_VENDU, { as: "LOT_VENDUs", foreignKey: "VENTE_ID"});
  PRODUIT_VENDU.belongsTo(VENTE, { as: "VENTE", foreignKey: "VENTE_ID"});
  VENTE.hasMany(PRODUIT_VENDU, { as: "PRODUIT_VENDUs", foreignKey: "VENTE_ID"});
  RETOUR_PRODUIT.belongsTo(VENTE, { as: "VENTE", foreignKey: "VENTE_ID"});
  VENTE.hasMany(RETOUR_PRODUIT, { as: "RETOUR_PRODUITs", foreignKey: "VENTE_ID"});
  VENTES_REALISES.belongsTo(VENTE, { as: "VENTE", foreignKey: "VENTE_ID"});
  VENTE.hasMany(VENTES_REALISES, { as: "VENTES_REALISEs", foreignKey: "VENTE_ID"});

  return {
    ADRESSE,
    CATEGORIE,
    CLIENT,
    COMMANDE_ENTREE,
    COMMANDE_SORTIE,
    EMPLACEMENT,
    EMPLOYE,
    FACTURE,
    FOURNISSEUR,
    INVENTAIRE_LOT,
    INVENTAIRE_PRODUIT,
    LIVRAISON,
    LOT_PRODUITS,
    LOT_VENDU,
    PRODUIT,
    PRODUITS_ENTREES,
    PRODUITS_SORTIES,
    PRODUIT_LIVRE,
    PRODUIT_VENDU,
    RECEPTION_COMMANDE,
    RETOUR_FOURNISSEUR,
    RETOUR_PRODUIT,
    VENTE,
    VENTES_REALISES,
  };
}
module.exports = initModels;
module.exports.initModels = initModels;
module.exports.default = initModels;
