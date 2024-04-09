const Sequelize = require('sequelize');
module.exports = function(sequelize, DataTypes) {
  return sequelize.define('produits_entrees', {
    PRODUIT_ID: {
      type: DataTypes.DECIMAL(15,0),
      allowNull: false,
      primaryKey: true,
      references: {
        model: 'produit',
        key: 'PRODUIT_ID'
      }
    },
    COMMANDE_E_ID: {
      type: DataTypes.DECIMAL(15,0),
      allowNull: false,
      primaryKey: true,
      references: {
        model: 'commande_entree',
        key: 'COMMANDE_E_ID'
      }
    }
  }, {
    sequelize,
    tableName: 'produits_entrees',
    timestamps: false,
    indexes: [
      {
        name: "PRIMARY",
        unique: true,
        using: "BTREE",
        fields: [
          { name: "PRODUIT_ID" },
          { name: "COMMANDE_E_ID" },
        ]
      },
      {
        name: "FK_PR_CE",
        using: "BTREE",
        fields: [
          { name: "COMMANDE_E_ID" },
        ]
      },
    ]
  });
};
