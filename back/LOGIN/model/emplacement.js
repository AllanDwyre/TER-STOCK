const Sequelize = require('sequelize');
module.exports = function(sequelize, DataTypes) {
  return sequelize.define('EMPLACEMENT', {
    EMPLACEMENT_ID: {
      type: DataTypes.DECIMAL(15,0),
      allowNull: false,
      primaryKey: true
    },
    NOM_EMPLACEMENT: {
      type: DataTypes.STRING(255),
      allowNull: true
    },
    DESC_EMPLACEMENT: {
      type: DataTypes.STRING(255),
      allowNull: true
    }
  }, {
    sequelize,
    tableName: 'EMPLACEMENT',
    timestamps: false,
    indexes: [
      {
        name: "PRIMARY",
        unique: true,
        using: "BTREE",
        fields: [
          { name: "EMPLACEMENT_ID" },
        ]
      },
    ]
  });
};
