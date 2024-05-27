// ===========================================================================================
// MODULES
// ===========================================================================================
const dotenv = require("dotenv");
const express = require("express");
const cors = require("cors");


dotenv.config();
const app = express();

// ===========================================================================================
// MIDDLEWARE
// ===========================================================================================
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));


// ===========================================================================================
// ROUTES IMPORT & INITIALIZING ROUTES
// ===========================================================================================
const route_api = require("./routes/api-route");

app.use("/api", route_api);
app.get("/", (req, res) => res.redirect("/api"));
app.get("*", (req, res) => res.status(404).json({message: "Not Found"}));


// ===========================================================================================
// SERVER CONFIGURATION
// ===========================================================================================
const APP_NAME = process.env.APP_NAME;
const APP_HOST = process.env.APP_HOST;
const APP_PORT = process.env.APP_PORT;


app.listen(APP_PORT, () => {
    console.log(`${APP_NAME} is running on http://${APP_HOST}:${APP_PORT}`);
})