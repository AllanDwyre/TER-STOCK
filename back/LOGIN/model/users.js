const Sequelize = require('sequelize');
module.exports = function(sequelize, DataTypes) {
  return sequelize.define('users', {
    USER_ID: {
      type: DataTypes.DECIMAL(15,0),
      allowNull: false,
      primaryKey: true
    },
    USERNAME: {
      type: DataTypes.STRING(255),
      allowNull: false
    },
    NAME_USER: {
      type : DataTypes.STRING(255),
      allowNull: false
    },
    FIRST_NAME: {
      type: DataTypes.STRING(255),
      allowNull: false
    },
    USER_MAIL: {
      type: DataTypes.STRING(255),
      allowNull: false
    },
    USER_TEL: {
      type: DataTypes.DECIMAL(10,0),
      allowNull: false
    },
    USER_DATE_NAISS: {
      type: DataTypes.DATEONLY,
      allowNull: true
    }
  }, {
    sequelize,
    tableName: 'users',
    timestamps: false,
    indexes: [
      {
        name: "PRIMARY",
        unique: true,
        using: "BTREE",
        fields: [
          { name: "USER_ID" },
        ]
      },
    ]
  });
};
