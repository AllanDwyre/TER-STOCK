const Sequelize = require('sequelize');
module.exports = function(sequelize, DataTypes) {
  return sequelize.define('COMMANDE_SORTIE', {
    COMMANDE_S_ID: {
      type: DataTypes.DECIMAL(15,0),
      allowNull: false,
      primaryKey: true
    }
  }, {
    sequelize,
    tableName: 'COMMANDE_SORTIE',
    timestamps: false,
    indexes: [
      {
        name: "PRIMARY",
        unique: true,
        using: "BTREE",
        fields: [
          { name: "COMMANDE_S_ID" },
        ]
      },
    ]
  });
};
