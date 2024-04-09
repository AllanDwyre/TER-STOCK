const Sequelize = require('sequelize');
module.exports = function(sequelize, DataTypes) {
  return sequelize.define('livraison', {
    LIVRAISON_ID: {
      type: DataTypes.DECIMAL(15,0),
      allowNull: false,
      primaryKey: true,
      references: {
        model: 'commande_sortie',
        key: 'COMMANDE_S_ID'
      }
    },
    DATE_LIVRAISON: {
      type: DataTypes.DATEONLY,
      allowNull: true
    },
    EMPLOYE_ID: {
      type: DataTypes.DECIMAL(15,0),
      allowNull: true,
      references: {
        model: 'employe',
        key: 'EMPLOYE_ID'
      }
    }
  }, {
    sequelize,
    tableName: 'livraison',
    timestamps: false,
    indexes: [
      {
        name: "PRIMARY",
        unique: true,
        using: "BTREE",
        fields: [
          { name: "LIVRAISON_ID" },
        ]
      },
      {
        name: "FK_EMPL",
        using: "BTREE",
        fields: [
          { name: "EMPLOYE_ID" },
        ]
      },
    ]
  });
};
