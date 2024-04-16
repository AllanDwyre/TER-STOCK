const Sequelize = require('sequelize');
module.exports = function(sequelize, DataTypes) {
  return sequelize.define('PRODUIT', {
    PRODUIT_ID: {
      type: DataTypes.DECIMAL(15,0),
      allowNull: false,
      primaryKey: true
    },
    NOM: {
      type: DataTypes.STRING(255),
      allowNull: true
    },
    DESCR: {
      type: DataTypes.STRING(255),
      allowNull: true
    },
    PRIX_UNIT: {
      type: DataTypes.DECIMAL(5,2),
      allowNull: true
    },
    POIDS: {
      type: DataTypes.STRING(255),
      allowNull: true
    },
    DIMENSIONS: {
      type: DataTypes.STRING(255),
      allowNull: true
    },
    MAGASIN_ENTREPOT: {
      type: DataTypes.STRING(255),
      allowNull: true
    },
    CODE_BARRE_PRODUIT: {
      type: DataTypes.DECIMAL(20,0),
      allowNull: true
    },
    QR_CODE_PRODUIT: {
      type: DataTypes.DECIMAL(20,0),
      allowNull: true
    },
    CATEGORIE_ID: {
      type: DataTypes.DECIMAL(15,0),
      allowNull: true,
      references: {
        model: 'CATEGORIE',
        key: 'CATEGORIE_ID'
      }
    },
    EMPLACEMENT_ID: {
      type: DataTypes.DECIMAL(15,0),
      allowNull: true,
      references: {
        model: 'EMPLACEMENT',
        key: 'EMPLACEMENT_ID'
      }
    }
  }, {
    sequelize,
    tableName: 'PRODUIT',
    timestamps: false,
    indexes: [
      {
        name: "PRIMARY",
        unique: true,
        using: "BTREE",
        fields: [
          { name: "PRODUIT_ID" },
        ]
      },
      {
        name: "FK_CAT",
        using: "BTREE",
        fields: [
          { name: "CATEGORIE_ID" },
        ]
      },
      {
        name: "FK_EMP",
        using: "BTREE",
        fields: [
          { name: "EMPLACEMENT_ID" },
        ]
      },
    ]
  });
};
