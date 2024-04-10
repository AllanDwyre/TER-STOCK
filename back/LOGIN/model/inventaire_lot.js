const Sequelize = require('sequelize');
module.exports = function(sequelize, DataTypes) {
  return sequelize.define('INVENTAIRE_LOT', {
    INVENTAIRE_LOT_ID: {
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
    LOT_ID: {
      type: DataTypes.DECIMAL(15,0),
      allowNull: true,
      references: {
        model: 'LOT_PRODUITS',
        key: 'LOT_ID'
      }
    },
    QUANTITE_ENTREE_PAR_LOT: {
      type: DataTypes.INTEGER,
      allowNull: true
    },
    QUANTITE_SORTIE_PAR_LOT: {
      type: DataTypes.INTEGER,
      allowNull: true
    },
    DATE_INV_LOT: {
      type: DataTypes.DATE,
      allowNull: true
    }
  }, {
    sequelize,
    tableName: 'INVENTAIRE_LOT',
    timestamps: false,
    indexes: [
      {
        name: "PRIMARY",
        unique: true,
        using: "BTREE",
        fields: [
          { name: "INVENTAIRE_LOT_ID" },
        ]
      },
      {
        name: "FK_EMP_INV_LOT",
        using: "BTREE",
        fields: [
          { name: "EMPLOYE_ID" },
        ]
      },
      {
        name: "FK_LOT_INV",
        using: "BTREE",
        fields: [
          { name: "LOT_ID" },
        ]
      },
    ]
  });
};
