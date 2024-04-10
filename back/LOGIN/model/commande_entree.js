const Sequelize = require('sequelize');
module.exports = function(sequelize, DataTypes) {
  return sequelize.define('COMMANDE_ENTREE', {
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
    tableName: 'COMMANDE_ENTREE',
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
