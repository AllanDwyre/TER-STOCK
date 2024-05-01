module.exports = function(sequelize, DataTypes) {
  return sequelize.define('CATEGORIE', {
    CATEGORIE_ID: {
      type: DataTypes.DECIMAL(15,0),
      allowNull: false,
      primaryKey: true
    },
    NOM_CATEGORIE: {
      type: DataTypes.STRING(255),
      allowNull: true
    }
  }, {
    sequelize,
    tableName: 'CATEGORIE',
    timestamps: false,
    indexes: [
      {
        name: "PRIMARY",
        unique: true,
        using: "BTREE",
        fields: [
          { name: "CATEGORIE_ID" },
        ]
      },
    ]
  });
};
*/