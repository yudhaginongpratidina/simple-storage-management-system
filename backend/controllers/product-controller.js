const { Product, Category } = require('../models');
const path = require('path');
const fs = require('fs');

class ProductController {

    // ------------------------------------------------
    // MENAMPILKAN SEMUA PRODUCT BERDASARKAN ID USER
    // ------------------------------------------------
    static async getAllProductByUserId(req, res) {
        try {
            const { userid } = req.params;

            const products = await Product.findAll({
                where: {
                    created_by: userid
                },
                include: {
                    model: Category
                }
            });

            return res.status(200).json({
                message: 'Products found',
                data: products
            });

        } catch (error) {
            console.log(error);
        }
    }

    // ------------------------------------------------------------
    // MENAMPILKAN DETAIL PRODUCT BERDASARKAN ID
    // ------------------------------------------------------------
    static async getProductById(req, res) {
        try {
            const { id } = req.params;
            const product = await Product.findOne({
                where: {
                    id: id
                },
                include: {
                    model: Category
                }
            });
            return res.status(200).json({
                message: 'Product found',
                data: product
            });
        } catch (error) {
            console.log(error);
        }
    }
         
    // ------------------------------------------------------------
    // MENAMBAH PRODUCT BERDASARKAN ID USER
    // ------------------------------------------------------------
    static async addProductByUserId(req, res) {
        try {
            const { userid } = req.params;
            const { name, qty, categoryId } = req.body;
            const image = req.file;
            const imagePath = image ? image.filename : null;
    
            // Periksa apakah produk sudah ada
            const existingProduct = await Product.findAll({
                where: {
                    name: name
                }
            });
    
            // Jika produk sudah ada, kirim respons 400
            if (existingProduct.length > 0) {
                return res.status(400).json({
                    message: 'Product already exists'
                });
            }
    
            // Jika produk belum ada, tambahkan produk baru
            const newProduct = await Product.create({
                name: name,
                qty: (qty),
                categoryId: categoryId,
                url_product_image: imagePath,
                created_by: userid,
                updated_by: userid
            });
    
            // Kirim respons 200 dengan data produk yang baru ditambahkan
            return res.status(200).json({
                message: 'Product added successfully',
                data: newProduct
            });
    
        } catch (error) {
            // Tangani kesalahan dengan memberikan respons yang sesuai
            console.log(error);
        }
    }
    


    
    // ------------------------------------------------------------
    // UPDATE PRODUCT
    // ------------------------------------------------------------
    static async updateProductByUserId(req, res) {
        try {
            const { userid, id } = req.params;
            const { name, qty, categoryId } = req.body;
            const image = req.file;
            const imagePath = image ? image.filename : null;
    
            const productExist = await Product.findOne({
                where: {
                    id: id
                }
            });
    
            if (!productExist) {
                return res.status(404).json({
                    message: 'Product not found'
                });
            }

            const name_exist = await Product.findOne({
                where: {
                    name: name
                }
            });
    
            if (name_exist && name_exist.id !== id) {
                return res.status(400).json({
                    message: 'Product name already exists'
                });
            }
    
            const productToUpdate = await Product.findOne({
                where: {
                    id: id
                }
            });
    
            // Simpan URL gambar lama
            const oldImagePath = productToUpdate.url_product_image;
    
            // Perbarui produk
            await productToUpdate.update({
                name: name,
                qty: qty,
                categoryId: categoryId,
                url_product_image: imagePath,
                updatedAt: new Date(),
                updated_by: userid
            });
    
            // Hapus gambar lama jika ada
            if (oldImagePath && imagePath && oldImagePath !== imagePath) {
                const oldImagePathToDelete = path.join(__dirname, `../public/images/${oldImagePath}`);
                fs.unlinkSync(oldImagePathToDelete);
            }
    
            return res.status(200).json({
                message: 'Product updated successfully',
                data: productToUpdate
            });
        } catch (error) {
            console.log(error);
            return res.status(500).json({
                message: 'Internal server error'
            });
        }
    }



    // ------------------------------------------------------------
    // HAPUS PRODUCT
    // ------------------------------------------------------------
    static async deleteProductById(req, res) {

        try {
            const { id } = req.params;

            const product_exist = await Product.findOne({
                where: {
                    id: id
                }
            });

            if (!product_exist) {
                return res.status(400).json({
                    message: 'Product not found'
                });
            }

            const imagePath = product_exist.url_product_image;

            if (imagePath !== null) {
                const image_path = path.join(__dirname, `../public/images/${imagePath}`);
                fs.unlinkSync(image_path);
            }

            const deleteProductById = await Product.destroy({
                where: {
                    id: id
                }
            });

            return res.status(200).json({
                message: 'Success delete product',
                data: deleteProductById
            });
        } catch (error) {
            console.log(error);
        }
    }

}


module.exports = ProductController;