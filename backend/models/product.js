'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class Product extends Model {
    static associate(models) {
      Product.belongsTo(models.Category, { 
        foreignKey: 'categoryId', 
        onDelete: 'CASCADE', 
        onUpdate: 'CASCADE' 
      });

      Product.belongsTo(models.User, { 
        foreignKey: 'created_by', 
        onDelete: 'CASCADE', 
        onUpdate: 'CASCADE' 
      });

      Product.belongsTo(models.User, { 
        foreignKey: 'updated_by', 
        onDelete: 'CASCADE', 
        onUpdate: 'CASCADE' 
      });
    }
  }
  Product.init({
    name: DataTypes.STRING,
    qty: DataTypes.INTEGER,
    categoryId: DataTypes.INTEGER,
    url_product_image: DataTypes.STRING,
    created_by: DataTypes.INTEGER,
    updated_by: DataTypes.INTEGER
  }, {
    sequelize,
    modelName: 'Product',
  });
  return Product;
};