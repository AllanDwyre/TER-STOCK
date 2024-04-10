const Sequelize = require('sequelize');
module.exports = function(sequelize, DataTypes) {
  return sequelize.define('PRODUITS_SORTIES', {
    PRODUIT_ID: {
      type: DataTypes.DECIMAL(15,0),
      allowNull: false,
      primaryKey: true,
      references: {
        model: 'PRODUIT',
        key: 'PRODUIT_ID'
      }
    },
    COMMANDE_S_ID: {
      type: DataTypes.DECIMAL(15,0),
      allowNull: false,
      primaryKey: true,
      references: {
        model: 'COMMANDE_SORTIE',
        key: 'COMMANDE_S_ID'
      }
    }
  }, {
    sequelize,
    tableName: 'PRODUITS_SORTIES',
    timestamps: false,
    indexes: [
      {
        name: "PRIMARY",
        unique: true,
        using: "BTREE",
        fields: [
          { name: "PRODUIT_ID" },
          { name: "COMMANDE_S_ID" },
        ]
      },
      {
        name: "FK_PR_CS",
        using: "BTREE",
        fields: [
          { name: "COMMANDE_S_ID" },
        ]
      },
    ]
  });
};
