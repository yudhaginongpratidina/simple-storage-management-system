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



module.exports = router