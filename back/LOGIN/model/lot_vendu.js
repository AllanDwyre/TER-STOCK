const Sequelize = require('sequelize');
module.exports = function(sequelize, DataTypes) {
  return sequelize.define('lot_vendu', {
    LOT_ID: {
      type: DataTypes.DECIMAL(15,0),
      allowNull: false,
      primaryKey: true,
      references: {
        model: 'lot_produits',
        key: 'LOT_ID'
      }
    },
    VENTE_ID: {
      type: DataTypes.DECIMAL(15,0),
      allowNull: false,
      primaryKey: true,
      references: {
        model: 'vente',
        key: 'VENTE_ID'
      }
    },
    QTE_LOT: {
      type: DataTypes.DECIMAL(10,0),
      allowNull: true
    },
    PRIX_LOT: {
      type: DataTypes.STRING(255),
      allowNull: true
    }
  }, {
    sequelize,
    tableName: 'lot_vendu',
    timestamps: false,
    indexes: [
      {
        name: "PRIMARY",
        unique: true,
        using: "BTREE",
        fields: [
          { name: "LOT_ID" },
          { name: "VENTE_ID" },
        ]
      },
      {
        name: "FK_VENT_LOT",
        using: "BTREE",
        fields: [
          { name: "VENTE_ID" },
        ]
      },
    ]
  });
};
