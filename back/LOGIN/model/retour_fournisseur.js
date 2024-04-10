const Sequelize = require('sequelize');
module.exports = function(sequelize, DataTypes) {
  return sequelize.define('RETOUR_FOURNISSEUR', {
    RETOUR_FOURNISSEUR_ID: {
      type: DataTypes.DECIMAL(15,0),
      allowNull: false,
      primaryKey: true,
      references: {
        model: 'COMMANDE_SORTIE',
        key: 'COMMANDE_S_ID'
      }
    },
    DATE_RETOUR_F: {
      type: DataTypes.DATEONLY,
      allowNull: true
    }
  }, {
    sequelize,
    tableName: 'RETOUR_FOURNISSEUR',
    timestamps: false,
    indexes: [
      {
        name: "PRIMARY",
        unique: true,
        using: "BTREE",
        fields: [
          { name: "RETOUR_FOURNISSEUR_ID" },
        ]
      },
    ]
  });
};
