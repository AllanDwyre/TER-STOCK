const Sequelize = require('sequelize');
module.exports = function(sequelize, DataTypes) {
  return sequelize.define('commande_fournisseur', {
    COMM_FOURN_ID: {
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true,
      references: {
        model: 'commande',
        key: 'COMMANDE_ID'
      }
    },
    TYPE_COMMANDE: {
      type: DataTypes.ENUM('commande','retour'),
      allowNull: false
    },
    FOURNISSEUR_ID: {
      type: DataTypes.DECIMAL(15,0),
      allowNull: true,
      references: {
        model: 'fournisseur',
        key: 'FOURNISSEUR_ID'
      }
    }
  }, {
    sequelize,
    tableName: 'commande_fournisseur',
    timestamps: false,
    indexes: [
      {
        name: "PRIMARY",
        unique: true,
        using: "BTREE",
        fields: [
          { name: "COMM_FOURN_ID" },
        ]
      },
      {
        name: "FL_CF_FOURNISSEUR",
        using: "BTREE",
        fields: [
          { name: "FOURNISSEUR_ID" },
        ]
      },
    ]
  });
};
