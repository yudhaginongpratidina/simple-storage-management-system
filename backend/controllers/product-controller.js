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
    static async addProductByUserId(req, res) {
        try {
            const { userid } = req.params;
            const { name, qty, categoryId, url_product_image } = req.body;


            const name_exist = await Product.findAll({
                where: {
                    name: name
                }
            });


            if (name_exist > 0) {
                return res.status(400).json({
                    message: 'Product already exist'
                });
            }

            const addNewProductByUdserId = await Product.create({
                name: name,
                qty: qty,
                categoryId: categoryId,
                url_product_image: url_product_image,
                created_by: userid
            });

            return res.status(200).json({
                message: 'Success add product',
                data: addNewProductByUdserId
            });

        } catch (error) {
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

            const nameExist = await Product.findOne({
                where: {
                    name: name
                }
            });

            if (nameExist) {
                return res.status(400).json({
                    message: 'Product already exists'
                });
            }

            const updatedProduct = await Product.update({
                name: name,
                qty: qty,
                categoryId: categoryId,
                url_product_image: url_product_image,
                updated_by: userid
            }, {
                where: {
                    id: id
                }
            });

            return res.status(200).json({
                message: 'Product updated successfully',
                data: updatedProduct
            });

        } catch (error) {
            console.log(error);
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