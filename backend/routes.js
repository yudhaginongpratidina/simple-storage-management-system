// =======================================================================
// IMPORT LIBRARY
// =======================================================================
const express = require("express");
const router = express.Router();

// =======================================================================
// IMPORT CONTROLLERS
// =======================================================================
const userController = require("./controllers/user-controller");
const CategoryController = require("./controllers/category-controller");
const ProductController = require("./controllers/product-controller");



// =======================================================================
// MEBUAT ENDPOINT (ROUTE)(METHOD)(URL/PARAMETER)(CONTROLLER DAN METHOD)
// =======================================================================
router.get("/users", userController.getUsers)
router.get("/users/:id", userController.getUserById)
router.post("/users", userController.createUser)
router.delete("/users/:id", userController.deleteUserById)

router.post('/login', userController.loginUser)


router.get("/categories", CategoryController.getCategories)
router.get("/categories/:id", CategoryController.getCategoryById)
router.post("/categories", CategoryController.createCategory)
router.patch("/categories/:id", CategoryController.updateCategoryById)
router.delete("/categories/:id", CategoryController.deleteCategoryById)

router.get("/products/:userid", ProductController.getAllProductByUserId)
router.post("/products/:userid", ProductController.addProductByUserId)
router.patch("/products/:userid/:id", ProductController.updateProductByUserId)
router.delete("/products/:id", ProductController.deleteProductById)


module.exports = router