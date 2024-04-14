const Sequelize = require('sequelize');
module.exports = function(sequelize, DataTypes) {
  return sequelize.define('INVENTAIRE_PRODUIT', {
    INVENTAIRE_ID: {
      type: DataTypes.DECIMAL(15,0),
      allowNull: false,
      primaryKey: true
    },
    EMPLOYE_ID: {
      type: DataTypes.DECIMAL(15,0),
      allowNull: true,
      references: {
        model: 'EMPLOYE',
        key: 'EMPLOYE_ID'
      }
    },
    PRODUIT_ID: {
      type: DataTypes.DECIMAL(15,0),
      allowNull: true,
      references: {
        model: 'PRODUIT',
        key: 'PRODUIT_ID'
      }
    },
    QUANTITE_ENTREE_PAR_PROD: {
      type: DataTypes.INTEGER,
      allowNull: true
    },
    QUANTITE_SORTIE_PAR_PROD: {
      type: DataTypes.INTEGER,
      allowNull: true
    },
    DATE_INV: {
      type: DataTypes.DATE,
      allowNull: true
    }
  }, {
    sequelize,
    tableName: 'INVENTAIRE_PRODUIT',
    timestamps: false,
    indexes: [
      {
        name: "PRIMARY",
        unique: true,
        using: "BTREE",
        fields: [
          { name: "INVENTAIRE_ID" },
        ]
      },
      {
        name: "FK_EMP_INV",
        using: "BTREE",
        fields: [
          { name: "EMPLOYE_ID" },
        ]
      },
      {
        name: "FK_PROD_INV",
        using: "BTREE",
        fields: [
          { name: "PRODUIT_ID" },
        ]
      },
    ]
  });
};