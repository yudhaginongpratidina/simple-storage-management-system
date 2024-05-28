// =======================================================================
// IMPORT LIBRARY
// =======================================================================
const express = require("express");
const router = express.Router();

// =======================================================================
// IMPORT CONTROLLERS
// =======================================================================
const userController = require("./controllers/user-controller");


// =======================================================================
// MEBUAT ENDPOINT (ROUTE)(METHOD)(URL/PARAMETER)(CONTROLLER DAN METHOD)
// =======================================================================
router.get("/users", userController.getUsers)
router.get("/users/:id", userController.getUserById)
router.post("/users", userController.createUser)
router.delete("/users/:id", userController.deleteUserById)

router.post('/login', userController.loginUser)



module.exports = router