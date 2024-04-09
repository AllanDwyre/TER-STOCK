const Sequelize = require('sequelize');
module.exports = function(sequelize, DataTypes) {
  return sequelize.define('facture', {
    FACTURE_ID: {
      type: DataTypes.DECIMAL(15,0),
      allowNull: false,
      primaryKey: true
    },
    MONTANT: {
      type: DataTypes.DECIMAL(10,2),
      allowNull: true
    },
    DATE_FACTURE: {
      type: DataTypes.DATEONLY,
      allowNull: true
    },
    NOM_MAGASIN: {
      type: DataTypes.STRING(255),
      allowNull: true
    },
    CLIENT_ID: {
      type: DataTypes.DECIMAL(15,0),
      allowNull: true,
      references: {
        model: 'client',
        key: 'CLIENT_ID'
      }
    }
  }, {
    sequelize,
    tableName: 'facture',
    timestamps: false,
    indexes: [
      {
        name: "PRIMARY",
        unique: true,
        using: "BTREE",
        fields: [
          { name: "FACTURE_ID" },
        ]
      },
      {
        name: "FK_CLI",
        using: "BTREE",
        fields: [
          { name: "CLIENT_ID" },
        ]
      },
    ]
  });
};
