// ===========================================================================================
// MODULES
// ===========================================================================================
const express = require("express");
const router = express.Router();


// ===========================================================================================
// IMPORT CONTROLLERS
// ===========================================================================================
const WellcomeController = require("../controllers/wellcome-controller");



// ===========================================================================================
// DIFINE ROUTE
// ===========================================================================================
router.get("/", WellcomeController.index)


// -------------------------------------------------------------------------------------------
// AUTHENTICATION ROUTE
// -------------------------------------------------------------------------------------------
router.post("/register", (req, res) => res.json({message: "Route register"}))
router.post("/login", (req, res) => res.json({message: "Route login"}))



// -------------------------------------------------------------------------------------------
// USER ROUTE
// -------------------------------------------------------------------------------------------
router.get("/user/:id", (req, res) => res.json({message: "Route get user by id"}))
router.patch("/user/:id", (req, res) => res.json({message: "Route update user by id"}))
router.delete("/user/:id", (req, res) => res.json({message: "Route delete user by id"}))


// -------------------------------------------------------------------------------------------
// CATEGORY ROUTE
// -------------------------------------------------------------------------------------------
router.get("/category", (req, res) => res.json({message: "Route get all category"}))
router.post("/category", (req, res) => res.json({message: "Route create category"}))
router.get("/category/:id", (req, res) => res.json({message: "Route get category by id"}))
router.patch("/category/:id", (req, res) => res.json({message: "Route update category by id"}))
router.delete("/category/:id", (req, res) => res.json({message: "Route delete category by id"}))


// -------------------------------------------------------------------------------------------
// PRODUCT ROUTE
// -------------------------------------------------------------------------------------------
router.get("/product", (req, res) => res.json({message: "Route get all product"}))
router.post("/product", (req, res) => res.json({message: "Route create product"}))
router.get("/product/:id", (req, res) => res.json({message: "Route get product by id"}))
router.patch("/product/:id", (req, res) => res.json({message: "Route update product by id"}))
router.delete("/product/:id", (req, res) => res.json({message: "Route delete product by id"}))



// ===========================================================================================
// EXPORT
// ===========================================================================================
module.exports = router