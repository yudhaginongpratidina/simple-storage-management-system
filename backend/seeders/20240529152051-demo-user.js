'use strict';

const argon2 = require('argon2');

/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up (queryInterface, Sequelize) {
    await queryInterface.bulkInsert('Users', [
      {
        username: 'user1',
        password: await argon2.hash('user1'),
        image: null,
        createdAt: new Date(),
        updatedAt: new Date()
      },
      {
        username: 'user2',
        password: await argon2.hash('user2'),
        image: null,
        createdAt: new Date(),
        updatedAt: new Date()
      }
    ]);
  },

  async down (queryInterface, Sequelize) {
    await queryInterface.bulkDelete('Users', null, {});
  }
};
