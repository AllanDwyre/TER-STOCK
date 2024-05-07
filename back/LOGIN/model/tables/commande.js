const Sequelize = require('sequelize');
module.exports = function(sequelize, DataTypes) {
  return sequelize.define('COMMANDE', {
    COMMANDE_ID: {
      autoIncrement: true,
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true
    },
    DATE_COMMANDE: {
      type: DataTypes.DATE,
      allowNull: true
    },
    EMPLOYE_ID: {
      type: DataTypes.NUMERIC(15),
      allowNull: true,
      references: {
        model: 'employe',
        key: 'EMPLOYE_ID'
      }
    }
  }, {
    sequelize,
    tableName: 'COMMANDE',
    timestamps: false,
    indexes: [
      {
        name: "PRIMARY",
        unique: true,
        using: "BTREE",
        fields: [
          { name: "COMMANDE_ID" },
        ]
      },
      {
        name: "FK_CF_EMPLOYE",
        using: "BTREE",
        fields: [
          { name: "EMPLOYE_ID" },
        ]
      },
    ]
  });
};
