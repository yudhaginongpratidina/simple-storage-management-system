const prisma = require('../libs/prisma');

class ProductController {

    // ------------------------------------------------
    // MENAMPILKAN SEMUA PRODUCT BERDASARKAN ID USER
    // ------------------------------------------------
    static async getAllProductByUserId(req, res) {
        try {

            // ambil id user dari params
            const { userid } = req.params;


            // ambil semua product berdasarkan id user
            const products = await prisma.products.findMany({
                where: {

                    created_by: userid
                },
                include: {

                    category: true,
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
    // MENAMBAH PRODUCT
    // ------------------------------------------------------------
    static async addProductByUserId(req, res) {
        try {
            const { userid } = req.params;
            const { name, qty, categoryId, url_product_image } = req.body;


            const name_exist = await prisma.products.findFirst({
                where: {
                    name: name
                }
            });


            if (name_exist) {
                return res.status(400).json({
                    message: 'Product already exist'
                });
            }

            const addNewProductByUdserId = await prisma.products.create({
                data: {
                    name: name,
                    qty: qty,
                    categoryId: categoryId,
                    url_product_image: url_product_image,
                    created_by: userid,
                    updated_by: userid
                }

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


            const name_exist = await prisma.products.findFirst({
                where: {
                    name: name
                }
            });

            if (name_exist) {
                return res.status(400).json({
                    message: 'Product already exist'
                });
            }


            const updateProductByUserId = await prisma.products.update({
                where: {
                    id: id
                },
                data: {
                    name: name,
                    qty: qty,
                    categoryId: categoryId,
                    url_product_image: url_product_image,
                    updated_by: userid
                }
            });


            return res.status(200).json({
                message: 'Success update product',
                data: updateProductByUserId
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

            const product_exist = await prisma.products.findFirst({
                where: {
                    id: id
                }
            });

            if (!product_exist) {
                return res.status(400).json({
                    message: 'Product not found'
                });
            }

            const deleteProductById = await prisma.products.delete({

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