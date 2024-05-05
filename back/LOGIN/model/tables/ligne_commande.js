const Sequelize = require('sequelize');
module.exports = function(sequelize, DataTypes) {
  return sequelize.define('ligne_commande', {
    PRODUIT_ID: {
      type: DataTypes.DECIMAL(15,0),
      allowNull: false,
      primaryKey: true,
      references: {
        model: 'produit',
        key: 'PRODUIT_ID'
      }
    },
    COMMANDE_ID: {
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true,
      references: {
        model: 'commande',
        key: 'COMMANDE_ID'
      }
    },
    QUANTITE: {
      type: DataTypes.INTEGER,
      allowNull: true
    }
  }, {
    sequelize,
    tableName: 'ligne_commande',
    timestamps: false,
    indexes: [
      {
        name: "PRIMARY",
        unique: true,
        using: "BTREE",
        fields: [
          { name: "PRODUIT_ID" },
          { name: "COMMANDE_ID" },
        ]
      },
      {
        name: "FK_LIGN_COMM",
        using: "BTREE",
        fields: [
          { name: "COMMANDE_ID" },
        ]
      },
    ]
  });
};
