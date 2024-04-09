const Sequelize = require('sequelize');
module.exports = function(sequelize, DataTypes) {
  return sequelize.define('fournisseur', {
    FOURNISSEUR_ID: {
      type: DataTypes.DECIMAL(15,0),
      allowNull: false,
      primaryKey: true
    },
    NOM_FOURNISSEUR: {
      type: DataTypes.STRING(255),
      allowNull: true
    },
    TELEPHONE: {
      type: DataTypes.STRING(255),
      allowNull: true
    },
    ADRESSE_ID: {
      type: DataTypes.DECIMAL(15,0),
      allowNull: true,
      references: {
        model: 'adresse',
        key: 'ADRESSE_ID'
      }
    }
  }, {
    sequelize,
    tableName: 'fournisseur',
    timestamps: false,
    indexes: [
      {
        name: "PRIMARY",
        unique: true,
        using: "BTREE",
        fields: [
          { name: "FOURNISSEUR_ID" },
        ]
      },
      {
        name: "FK_ADR_FOURN",
        using: "BTREE",
        fields: [
          { name: "ADRESSE_ID" },
        ]
      },
    ]
  });
};
