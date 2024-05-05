const Sequelize = require('sequelize');
module.exports = function(sequelize, DataTypes) {
  return sequelize.define('commande_client', {
    COMM_CLIENT_ID: {
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true,
      references: {
        model: 'commande',
        key: 'COMMANDE_ID'
      }
    },
    TYPE_COMMANDE: {
      type: DataTypes.ENUM('commande','retour'),
      allowNull: false
    },
    CLIENT_ID: {
      type: DataTypes.DECIMAL(15,0),
      allowNull: true,
      references: {
        model: 'client',
        key: 'CLIENT_ID'
      }
    }
  }, {
    sequelize,
    tableName: 'commande_client',
    timestamps: false,
    indexes: [
      {
        name: "PRIMARY",
        unique: true,
        using: "BTREE",
        fields: [
          { name: "COMM_CLIENT_ID" },
        ]
      },
      {
        name: "FL_CC_CLIENT",
        using: "BTREE",
        fields: [
          { name: "CLIENT_ID" },
        ]
      },
    ]
  });
};
