const multer = require("multer");
const path = require("path");

// KONFIGURASI PENYIMPANAN
const storage = multer.diskStorage({
    destination: (req, file, cb) => {

        // DESTINASI PENYIMPANAN
        cb(null, 'public/images'); 
    },
    filename: (req, file, cb) => {

        // NAMA FILE BARU
        const currentDate = new Date();
        const year = currentDate.getFullYear();
        const month = String(currentDate.getMonth() + 1).padStart(2, '0');
        const date = String(currentDate.getDate()).padStart(2, '0');
        const hours = String(currentDate.getHours()).padStart(2, '0');
        const minutes = String(currentDate.getMinutes()).padStart(2, '0');
        const seconds = String(currentDate.getSeconds()).padStart(2, '0');
        const ext = path.extname(file.originalname);
        const uniqueSuffix = `${year}-${month}-${date}-${hours}-${minutes}-${seconds}-image${ext}`;
        cb(null, uniqueSuffix);
    }
});

// Middleware upload file
const uploadImage = multer({
    storage: storage,
    limits: {
        fileSize: 5 * 1024 * 1024
    },
    fileFilter: (req, file, cb) => {
        cb(null, true);
    }
});

module.exports = uploadImage;