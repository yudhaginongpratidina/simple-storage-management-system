'use strict';


/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up (queryInterface, Sequelize) {
    await queryInterface.bulkInsert('Products', [
      {
        name: 'Asus ROG Strix',
        qty: 10,
        categoryId: 6, 
        url_product_image : null,
        created_by: 1,
        updated_by: 1,
        createdAt: new Date(),
        updatedAt: new Date()
      },
      {
        name: 'Realme GT',
        qty: 100,
        categoryId: 1, 
        url_product_image : null,
        created_by: 1,
        updated_by: 1,
        createdAt: new Date(),
        updatedAt: new Date()
      },
      {
        name: 'Polo Shirt',
        qty: 25,
        categoryId: 3, 
        url_product_image : null,
        created_by: 2,
        updated_by: 2,
        createdAt: new Date(),
        updatedAt: new Date()
      },
    ]);
  },

  async down (queryInterface, Sequelize) {
    await queryInterface.bulkDelete('Products', null, {});
  }
};
