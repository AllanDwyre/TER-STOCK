const Sequelize = require('sequelize');
module.exports = function(sequelize, DataTypes) {
  return sequelize.define('EMPLOYE', {
    EMPLOYE_ID: {
      type: DataTypes.DECIMAL(15,0),
      allowNull: false,
      primaryKey: true
    },
    NOM_EMP: {
      type: DataTypes.STRING(255),
      allowNull: true
    },
    PRENOM_EMP: {
      type: DataTypes.STRING(255),
      allowNull: true
    },
    POSTE: {
      type: DataTypes.STRING(255),
      allowNull: true
    },
    ADRESSE_ID: {
      type: DataTypes.DECIMAL(15,0),
      allowNull: true,
      references: {
        model: 'ADRESSE',
        key: 'ADRESSE_ID'
      }
    }
  }, {
    sequelize,
    tableName: 'EMPLOYE',
    timestamps: false,
    indexes: [
      {
        name: "PRIMARY",
        unique: true,
        using: "BTREE",
        fields: [
          { name: "EMPLOYE_ID" },
        ]
      },
      {
        name: "FK_ADR_EMP",
        using: "BTREE",
        fields: [
          { name: "ADRESSE_ID" },
        ]
      },
    ]
  });
};
