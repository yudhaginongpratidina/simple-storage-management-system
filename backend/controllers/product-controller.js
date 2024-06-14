const { Product, Category } = require('../models');

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
            const { name, qty, categoryId, url_product_image } = req.body;
    
            // Periksa apakah produk sudah ada
            const existingProduct = await Product.findAll({
                where: {
                    name: name,
                    created_by: userid
                }
            });
    
            // Jika produk sudah ada, kirim respons 400
            if (existingProduct.length > 0) {
                return res.json({
                    message: 'Product already exists'
                });
            }
    
            // Jika produk belum ada, tambahkan produk baru
            const newProduct = await Product.create({
                name: name,
                qty: (qty),
                categoryId: categoryId,
                url_product_image: url_product_image,
                created_by: userid,
                updated_by: userid
            });
    
            // Kirim respons 200 dengan data produk yang baru ditambahkan
            return res.status(201).json({
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
            const { name, qty, categoryId, url_product_image } = req.body;
    
            const productExist = await Product.findOne({
                where: {
                    id: id
                }
            });
    
            if (!productExist) {
                return res.json({
                    message: 'Product not found'
                });
            }

            const name_exist = await Product.findOne({
                where: {
                    name: name
                }
            });
    
            if (name_exist && name_exist.id !== id) {
                return res.json({
                    message: 'Product name already exists'
                });
            }
    
            const productToUpdate = await Product.findOne({
                where: {
                    id: id
                }
            });
    
            // Perbarui produk
            await productToUpdate.update({
                name: name,
                qty: qty,
                categoryId: categoryId,
                url_product_image: url_product_image,
                updatedAt: new Date(),
                updated_by: userid
            });
    
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
                return res.json({
                    message: 'Product not found'
                });
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