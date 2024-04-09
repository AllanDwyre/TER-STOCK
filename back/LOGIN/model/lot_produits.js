const Sequelize = require('sequelize');
module.exports = function(sequelize, DataTypes) {
  return sequelize.define('lot_produits', {
    LOT_ID: {
      type: DataTypes.DECIMAL(15,0),
      allowNull: false,
      primaryKey: true,
      references: {
        model: 'produit',
        key: 'PRODUIT_ID'
      }
    },
    QUANTITE: {
      type: DataTypes.DECIMAL(3,0),
      allowNull: true
    },
    PRIX_LOT: {
      type: DataTypes.DECIMAL(5,2),
      allowNull: true
    },
    CB_LOT: {
      type: DataTypes.DECIMAL(15,0),
      allowNull: true
    },
    QR_LOT: {
      type: DataTypes.DECIMAL(15,0),
      allowNull: true
    }
  }, {
    sequelize,
    tableName: 'lot_produits',
    timestamps: false,
    indexes: [
      {
        name: "PRIMARY",
        unique: true,
        using: "BTREE",
        fields: [
          { name: "LOT_ID" },
        ]
      },
    ]
  });
};
