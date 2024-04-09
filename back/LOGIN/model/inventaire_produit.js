const Sequelize = require('sequelize');
module.exports = function(sequelize, DataTypes) {
  return sequelize.define('inventaire_produit', {
    INVENTAIRE_ID: {
      type: DataTypes.DECIMAL(15,0),
      allowNull: false,
      primaryKey: true
    },
    EMPLOYE_ID: {
      type: DataTypes.DECIMAL(15,0),
      allowNull: true,
      references: {
        model: 'employe',
        key: 'EMPLOYE_ID'
      }
    },
    PRODUIT_ID: {
      type: DataTypes.DECIMAL(15,0),
      allowNull: true,
      references: {
        model: 'produit',
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
    tableName: 'inventaire_produit',
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
