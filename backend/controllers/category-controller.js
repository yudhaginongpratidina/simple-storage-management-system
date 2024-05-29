const prisma = require('../libs/prisma');


class CategoryController {

    // =================================================================
    // MENDAPATKAN SEMUA DATA CATEGORY
    // =================================================================
    static async getCategories(req, res) {
        try {
            const response = await prisma.category.findMany();
            return res.status(200).json({
                message: "Success",
                data: response
            });
        } catch (error) {
            console.log(error)
        }
    }

    // =================================================================
    // MENDAPATKAN DATA CATEGORY BERDASARKAN ID
    // =================================================================
    static async getCategoryById(req, res) {
        try {
            const { id } = req.params;
            const response = await prisma.category.findUnique({
                where: { id }
            });
            return res.status(200).json({
                message: "Success",
                data: response
            });
        } catch (error) {
            console.log(error)
        }
    }

    // =================================================================
    // MELAKUKAN UPDATE DATA KATEGORI BERDASARKAN ID
    // =================================================================
    static async updateCategoryById(req, res) {
        try {
            const { id } = req.params;
            const { name } = req.body;

            const name_check = await prisma.category.findMany({
                where: {
                    name
                }
            });

            if (name_check.length > 0) {
                return res.status(400).json({
                    message: "Category data has been added"
                });
            }

            const response = await prisma.category.update({
                where: { id },
                data: {
                    name
                }
            });

            return res.status(200).json({
                message: "Success",
                data: response
            });
        } catch (error) {
            
        }
    }

    // =================================================================
    // MEMBUAT ATAU MENAMBAH DATA CATEGORY BARU
    // =================================================================
    static async createCategory(req, res) {
        try {
            const { name } = req.body;
    
            const name_check = await prisma.category.findMany({
                where: {
                    name
                }
            });
    
            if (name_check.length > 0) {
                return res.status(400).json({
                    message: "Category data has been added"
                });
            }
    
            const response = await prisma.category.create({
                data: {
                    name
                }
            });
    
            return res.status(201).json({
                message: "Success",
                data: response
            });
        } catch (error) {
            console.error("Error creating category:", error);
        }
    }


    // =================================================================
    // MENGHAPUS DATA CATEGORY BERDASARKAN ID
    // =================================================================
    static async deleteCategoryById(req, res) {
        try {
            const { id } = req.params;

            const category_check = await prisma.category.findUnique({
                where: { id }
            });
    
            if (!category_check) {
                return res.status(404).json({
                    message: "Category not found"
                });
            }

            const response = await prisma.category.delete({
                where: { id }
            });
            return res.status(200).json({
                message: "Success",
                data: response
            });
        } catch (error) {
            console.error("Error creating category:", error);
        }
    }
}



module.exports = CategoryController