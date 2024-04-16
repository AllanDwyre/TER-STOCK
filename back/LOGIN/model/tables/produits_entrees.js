const Sequelize = require('sequelize');
module.exports = function(sequelize, DataTypes) {
  return sequelize.define('PRODUITS_ENTREES', {
    PRODUIT_ID: {
      type: DataTypes.DECIMAL(15,0),
      allowNull: false,
      primaryKey: true,
      references: {
        model: 'PRODUIT',
        key: 'PRODUIT_ID'
      }
    },
    COMMANDE_E_ID: {
      type: DataTypes.DECIMAL(15,0),
      allowNull: false,
      primaryKey: true,
      references: {
        model: 'COMMANDE_ENTREE',
        key: 'COMMANDE_E_ID'
      }
    }
  }, {
    sequelize,
    tableName: 'PRODUITS_ENTREES',
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
