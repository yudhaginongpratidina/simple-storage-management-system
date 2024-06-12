const { Category } = require('../models');


class CategoryController {

    // =================================================================
    // MENDAPATKAN SEMUA DATA CATEGORY
    // =================================================================
    static async getCategories(req, res) {
        try {
            const response = await Category.findAll();
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
            const response = await Category.findOne({
                where: { id }
            })
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
    
            // Periksa apakah nama kategori sudah ada selain kategori dengan id yang sama
            const nameExist = await Category.findOne({
                where: {
                    name : name,
                }
            });
    
            // Jika nama kategori sudah ada, kirim respons error
            if (nameExist) {
                return res.json({
                    message: "Category with this name already exists"
                });
            }
    
            // Perbarui kategori dengan id yang sesuai
            const response = await Category.update(
                { name: name },
                { where: { id: id } }
            );
    
            // Kirim respons sukses
            return res.status(200).json({
                message: "Category updated successfully",
                data: response
            });
        } catch (error) {
            console.error("Error updating category:", error);
        }
    }
    

    // =================================================================
    // MEMBUAT ATAU MENAMBAH DATA CATEGORY BARU
    // =================================================================
    static async createCategory(req, res) {
        try {
            const { name } = req.body;
    
            const name_check = await Category.findAll({
                where: {
                    name
                }
            });
    
            if (name_check.length > 0) {
                return res.json({
                    message: "Category data has been added"
                });
            }
    
            const response = await Category.create({
                name : name
            });
    
            return res.status(201).json({
                message: "Category created successfully",
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

            const category_check = await Category.findOne({
                where: { id }
            });
    
            if (!category_check) {
                return res.status(404).json({
                    message: "Category not found"
                });
            }

            const response = await Category.destroy({
                where: { id }
            })

            return res.status(200).json({
                message: "Category deleted successfully",
                data: response
            });
        } catch (error) {
            console.error("Error creating category:", error);
        }
    }
}



module.exports = CategoryController