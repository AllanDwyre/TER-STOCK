const Sequelize = require('sequelize');
module.exports = function(sequelize, DataTypes) {
  return sequelize.define('ventes_realises', {
    EMPLOYE_ID: {
      type: DataTypes.DECIMAL(15,0),
      allowNull: false,
      primaryKey: true,
      references: {
        model: 'employe',
        key: 'EMPLOYE_ID'
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
    FACTURE_DEMANDE: {
      type: DataTypes.BOOLEAN,
      allowNull: true
    }
  }, {
    sequelize,
    tableName: 'ventes_realises',
    timestamps: false,
    indexes: [
      {
        name: "PRIMARY",
        unique: true,
        using: "BTREE",
        fields: [
          { name: "EMPLOYE_ID" },
          { name: "VENTE_ID" },
        ]
      },
      {
        name: "FK_VENTE_EMP",
        using: "BTREE",
        fields: [
          { name: "VENTE_ID" },
        ]
      },
    ]
  });
};
