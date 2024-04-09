const Sequelize = require('sequelize');
module.exports = function(sequelize, DataTypes) {
  return sequelize.define('RECEPTION_COMMANDE', {
    RECEP_FOURN_ID: {
      type: DataTypes.DECIMAL(15,0),
      allowNull: false,
      primaryKey: true,
      references: {
        model: 'COMMANDE_ENTREE',
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
        model: 'EMPLOYE',
        key: 'EMPLOYE_ID'
      }
    },
    FOURNISSEUR_ID: {
      type: DataTypes.DECIMAL(15,0),
      allowNull: true
    }
  }, {
    sequelize,
    tableName: 'RECEPTION_COMMANDE',
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
