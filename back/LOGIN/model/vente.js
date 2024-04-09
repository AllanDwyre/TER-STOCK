const Sequelize = require('sequelize');
module.exports = function(sequelize, DataTypes) {
  return sequelize.define('vente', {
    VENTE_ID: {
      type: DataTypes.DECIMAL(15,0),
      allowNull: false,
      primaryKey: true,
      references: {
        model: 'commande_sortie',
        key: 'COMMANDE_S_ID'
      }
    },
    DATE_VENTE: {
      type: DataTypes.DATEONLY,
      allowNull: true
    },
    MONTANT_TOTAL: {
      type: DataTypes.DECIMAL(8,2),
      allowNull: true
    },
    MODE_PAIEMENT: {
      type: DataTypes.STRING(255),
      allowNull: true
    },
    EMPLOYE_ID: {
      type: DataTypes.DECIMAL(15,0),
      allowNull: true,
      references: {
        model: 'employe',
        key: 'EMPLOYE_ID'
      }
    },
    FACTURE_ID: {
      type: DataTypes.DECIMAL(15,0),
      allowNull: true,
      references: {
        model: 'facture',
        key: 'FACTURE_ID'
      }
    }
  }, {
    sequelize,
    tableName: 'vente',
    timestamps: false,
    indexes: [
      {
        name: "PRIMARY",
        unique: true,
        using: "BTREE",
        fields: [
          { name: "VENTE_ID" },
        ]
      },
      {
        name: "FK_EMPV",
        using: "BTREE",
        fields: [
          { name: "EMPLOYE_ID" },
        ]
      },
      {
        name: "FK_FAC",
        using: "BTREE",
        fields: [
          { name: "FACTURE_ID" },
        ]
      },
    ]
  });
};
