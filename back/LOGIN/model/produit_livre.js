const Sequelize = require('sequelize');
module.exports = function(sequelize, DataTypes) {
  return sequelize.define('produit_livre', {
    PRODUIT_ID: {
      type: DataTypes.DECIMAL(15,0),
      allowNull: false,
      primaryKey: true,
      references: {
        model: 'produit',
        key: 'PRODUIT_ID'
      }
    },
    LIVRAISON_ID: {
      type: DataTypes.DECIMAL(15,0),
      allowNull: false,
      primaryKey: true,
      references: {
        model: 'livraison',
        key: 'LIVRAISON_ID'
      }
    }
  }, {
    sequelize,
    tableName: 'produit_livre',
    timestamps: false,
    indexes: [
      {
        name: "PRIMARY",
        unique: true,
        using: "BTREE",
        fields: [
          { name: "PRODUIT_ID" },
          { name: "LIVRAISON_ID" },
        ]
      },
      {
        name: "FK_LIVPR",
        using: "BTREE",
        fields: [
          { name: "LIVRAISON_ID" },
        ]
      },
    ]
  });
};
