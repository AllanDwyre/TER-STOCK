const Sequelize = require('sequelize');
module.exports = function(sequelize, DataTypes) {
  return sequelize.define('RETOUR_PRODUIT', {
    RETOUR_ID: {
      type: DataTypes.DECIMAL(15,0),
      allowNull: false,
      primaryKey: true,
      references: {
        model: 'COMMANDE_ENTREE',
        key: 'COMMANDE_E_ID'
      }
    },
    DATE_RETOUR: {
      type: DataTypes.DATEONLY,
      allowNull: true
    },
    RAISON_RETOUR: {
      type: DataTypes.STRING(255),
      allowNull: true
    },
    QUANTITE_RETOURNEE: {
      type: DataTypes.DECIMAL(3,0),
      allowNull: true
    },
    PRODUIT_ID: {
      type: DataTypes.DECIMAL(15,0),
      allowNull: true,
      references: {
        model: 'PRODUIT',
        key: 'PRODUIT_ID'
      }
    },
    VENTE_ID: {
      type: DataTypes.DECIMAL(15,0),
      allowNull: true,
      references: {
        model: 'VENTE',
        key: 'VENTE_ID'
      }
    }
  }, {
    sequelize,
    tableName: 'RETOUR_PRODUIT',
    timestamps: false,
    indexes: [
      {
        name: "PRIMARY",
        unique: true,
        using: "BTREE",
        fields: [
          { name: "RETOUR_ID" },
        ]
      },
      {
        name: "FK_PRODR",
        using: "BTREE",
        fields: [
          { name: "PRODUIT_ID" },
        ]
      },
      {
        name: "FK_VENTRP",
        using: "BTREE",
        fields: [
          { name: "VENTE_ID" },
        ]
      },
    ]
  });
};
