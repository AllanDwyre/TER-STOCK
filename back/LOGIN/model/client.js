const Sequelize = require('sequelize');
module.exports = function(sequelize, DataTypes) {
  return sequelize.define('client', {
    CLIENT_ID: {
      type: DataTypes.DECIMAL(15,0),
      allowNull: false,
      primaryKey: true
    },
    NOM_CLI: {
      type: DataTypes.STRING(255),
      allowNull: true
    },
    PRENOM_CLI: {
      type: DataTypes.STRING(255),
      allowNull: true
    },
    FIDELITE: {
      type: DataTypes.BOOLEAN,
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
    tableName: 'client',
    timestamps: false,
    indexes: [
      {
        name: "PRIMARY",
        unique: true,
        using: "BTREE",
        fields: [
          { name: "CLIENT_ID" },
        ]
      },
      {
        name: "FK_ADR_CLI",
        using: "BTREE",
        fields: [
          { name: "ADRESSE_ID" },
        ]
      },
    ]
  });
};
