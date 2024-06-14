// =======================================================================
// IMPORT LIBRARY
// =======================================================================
const express = require("express");
const router = express.Router();

// =======================================================================
// IMPORT MIDDLEWARE
// =======================================================================
const uploadImage = require("./middleware/upload-image");


// =======================================================================
// IMPORT CONTROLLERS
// =======================================================================
const userController = require("./controllers/user-controller");
const CategoryController = require("./controllers/category-controller");
const ProductController = require("./controllers/product-controller");

// =======================================================================
// ENDPOINT KHUSUS UNTUK AKSES IMAGES
// =======================================================================
router.get("/public/images/:filename", (req, res) => {
    res.sendFile(__dirname + "/public/images/" + req.params.filename);
});

// =======================================================================
// MEBUAT ENDPOINT (ROUTE)(METHOD)(URL/PARAMETER)(CONTROLLER DAN METHOD)
// =======================================================================
router.get("/users", userController.getUsers)
router.get("/users/:id", userController.getUserById)
router.post("/users", uploadImage.single('image'), userController.createUser)
router.patch("/users/:id", uploadImage.single('image'), userController.updateUserById)
router.delete("/users/:id", userController.deleteUserById)

router.post("/register", uploadImage.single('image'), userController.createUser)
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
router.get("/products/detail/:id", ProductController.getProductById)


module.exports = router