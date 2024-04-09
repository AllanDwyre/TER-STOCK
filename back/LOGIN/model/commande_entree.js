const Sequelize = require('sequelize');
module.exports = function(sequelize, DataTypes) {
  return sequelize.define('commande_entree', {
    COMMANDE_E_ID: {
      type: DataTypes.DECIMAL(15,0),
      allowNull: false,
      primaryKey: true
    },
    LOT_ID: {
      type: DataTypes.DECIMAL(15,0),
      allowNull: true
    }
  }, {
    sequelize,
    tableName: 'commande_entree',
    timestamps: false,
    indexes: [
      {
        name: "PRIMARY",
        unique: true,
        using: "BTREE",
        fields: [
          { name: "COMMANDE_E_ID" },
        ]
      },
    ]
  });
};
