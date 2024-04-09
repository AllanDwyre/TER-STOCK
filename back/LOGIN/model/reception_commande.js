const Sequelize = require('sequelize');
module.exports = function(sequelize, DataTypes) {
  return sequelize.define('reception_commande', {
    RECEP_FOURN_ID: {
      type: DataTypes.DECIMAL(15,0),
      allowNull: false,
      primaryKey: true,
      references: {
        model: 'commande_entree',
        key: 'COMMANDE_E_ID'
      }
    },
    DATE_RECEPTION: {
      type: DataTypes.DATEONLY,
      allowNull: true
    },
    QUANTITE_RECUE: {
      type: DataTypes.INTEGER,
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
    FOURNISSEUR_ID: {
      type: DataTypes.DECIMAL(15,0),
      allowNull: true
    }
  }, {
    sequelize,
    tableName: 'reception_commande',
    timestamps: false,
    indexes: [
      {
        name: "PRIMARY",
        unique: true,
        using: "BTREE",
        fields: [
          { name: "RECEP_FOURN_ID" },
        ]
      },
      {
        name: "FK_",
        using: "BTREE",
        fields: [
          { name: "EMPLOYE_ID" },
        ]
      },
    ]
  });
};
