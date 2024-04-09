const Sequelize = require('sequelize');
module.exports = function(sequelize, DataTypes) {
  return sequelize.define('retour_fournisseur', {
    RETOUR_FOURNISSEUR_ID: {
      type: DataTypes.DECIMAL(15,0),
      allowNull: false,
      primaryKey: true,
      references: {
        model: 'commande_sortie',
        key: 'COMMANDE_S_ID'
      }
    },
    DATE_RETOUR_F: {
      type: DataTypes.DATEONLY,
      allowNull: true
    }
  }, {
    sequelize,
    tableName: 'retour_fournisseur',
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
