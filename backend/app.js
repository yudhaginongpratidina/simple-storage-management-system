// =======================================================================
// IMPORT LIBRARY
// =======================================================================
const express = require("express");
const cors = require("cors");
require("dotenv").config();

// =======================================================================
// IMPORT ROUTES
// =======================================================================
const routes = require("./routes");

// =======================================================================
// MIDDLEWARE
// =======================================================================
const app = express();
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(express.static("public"));
app.use(routes);

// =======================================================================
// KONFIGURASI SERVER LISTENER
// =======================================================================

app.listen(3000, () => {
    console.log(`Server running at http://localhost:3000`);
})