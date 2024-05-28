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
app.use(routes);

// =======================================================================
// KONFIGURASI SERVER LISTENER
// =======================================================================
const HOSTNAME = process.env.APP_HOST || "localhost";
const PORT = process.env.APP_PORT || 4000;

app.listen(PORT, HOSTNAME, () => {
    console.log(`Server running at http://${HOSTNAME}:${PORT}`);
})