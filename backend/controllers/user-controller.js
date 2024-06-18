// ===================================================================
// IMPORT LIBRARY
// ===================================================================
const { User } = require('../models');
const argon2 = require('argon2');
const path = require('path');
const fs = require('fs');

class UserController {


    // =================================================================
    // MENDAPATKAN SEMUA DATA USER
    // =================================================================
    static async getUsers(req, res) {
        try {
            const response = await User.findAll();
            return res.status(200).json({
                message: "Success",
                data: response
            });
        } catch (error) {
            console.log(error)
        }
    }





    // =================================================================
    // MENDAPATKAN USER BERDASARKAN ID
    // =================================================================
    static async getUserById(req, res) {
        try {
            const { id } = req.params

            const response = await User.findOne({ where: { id }})

            return res.status(200).json({
                message: "Success",
                data: response
            });
        } catch (error) {
            console.log(error)
        }
    }





    // =================================================================
    // MEMBUAT USER BARU
    // =================================================================
    static async createUser(req, res) {
        try {
            const { username, password } = req.body;
    
            // APAKAH USERNAME SUDAH TERDAFTAR
            // --------------------------------------------------------
            const usernameExist = await User.findOne({
                where: { username }
            });
    
            // JIKA USERNAME SUDAH DIGUNAKAN KIRIM ERROR
            if (usernameExist) {
                return res.json({
                    message: `The username "${username}" has already been registered`
                });
            }
    
            // ENKRIPSI PASSWORD
            // --------------------------------------------------------
            const hash = await argon2.hash(password);
    

            // USERNAME BELUM PERNAH DIDAFTARKAN
            // ----------------------------------------------------------
            const newUser = await User.create({
                username: username,
                password: hash,
                image: null
            });
    
            // RESPONSE BERHASIL
            // -----------------------------------------------------------
            return res.status(201).json({
                message: "Register Success",
                data: newUser
            });
    
        } catch (error) {
            console.error(error);
            return res.status(500).json({ message: "Internal Server Error" });
        }
    }





    // =================================================================
    // MENGUPDATE USER BERDASARKAN ID
    // =================================================================
    static async updateUserById(req, res) {
        try {
            const { id } = req.params
            const { password } = req.body
            const image = req.file
            const imagePath = image ? image.filename : null;

            console.log(image)

            // PENCARIAN DATA USER
            // ---------------------------------------------------------
            const user_exist = await User.findOne({
                where: { id }
            })
            
            // DATA USER TIDAK DITEMUKAN
            // ---------------------------------------------------------
            if (!user_exist) {
                return res.json({
                    message: `the user with ID ${id} not found`
                })
            }
            
            // JIKA IMAGE PATH = NULL => UPDATE PASSWORDNYA SAJA
            // ---------------------------------------------------------
            if (imagePath === null) {
                const hash = await argon2.hash(password);

                const response = await User.update(
                    { password: hash}, 
                    { where: { id }}
                )

                return res.status(200).json({
                    message: "Success",
                    data: response
                });
            } else {                
                // CEK PATH IMAGE LAMA ADA ATAU TIDAK
                // ---------------------------------------------------------
                const image_path_old = user_exist.image;


                // JIKA PATH IMAGE LAMA = NULL => UPDATE PATHNYA DENGAN PATH IMAGE BARU
                // ---------------------------------------------------------------------
                if (image_path_old === null) {
                    const hash = await argon2.hash(password);

                    const response = await User.update({
                        password : hash,
                        image: imagePath
                    }, {
                        where: { id }
                    })

                    return res.status(200).json({
                        message: "Success",
                        data: response
                    })
                }

                // JIKA PATH IMAGE LAMA TIDAK = NULL => UPDATE PATHNYA DENGAN PATH IMAGE BARU
                // TAPI HAPUS DULU FILE LAMANYA
                // ---------------------------------------------------------------------
                if (image_path_old !== null || password !== null || password === '') {
                    const image_path = path.join(__dirname, `../public/images/${image_path_old}`);
                    fs.unlinkSync(image_path)

                    const hash = await argon2.hash(password);

                    const response = await User.update({
                        image: imagePath
                    }, {
                        where: { id }
                    })

                    return res.status(200).json({
                        message: "Success",
                        data: response
                    })
                }
            }

        } catch (error) {
            console.error(error)
            return res.status(500).json({ message: "Internal Server Error" });
        }
    }






    // =================================================================
    // MENGHAPUS USER BERDASARKAN ID
    // =================================================================
    static async deleteUserById(req, res) {
        try {
            const { id } = req.params
    
            const user_exist = await User.findOne({
                where: { id }
            })

            
            if (!user_exist) {
                return res.status(400).json({
                    message: `the user with ID ${id} not found`
                })
            }
    
            // HAPUS FILE IMAGE DARI FOLDER PUBLIC JIKA PATH NYA TIDAK SAMA DENGAN NULL
            // SEBELUM DATA USER DIHAPUS DARI DATABASE
            // ------------------------------------------------------------------------
            const imagePath = user_exist.image;
    
            if (imagePath !== null) {
                const image_path = path.join(__dirname, `../public/images/${imagePath}`);
                fs.unlinkSync(image_path)
            }


            const response = await User.destroy({
                where: { id }
            })

            return res.status(200).json({
                message: "Success",
                data: response
            });
        } catch (error) {
            console.error(error)
            return res.status(500).json({
                message: "Internal Server Error"
            })
        }
    }






    // =================================================================
    // MELAKUKAN LOGIN
    // =================================================================
    static async loginUser(req, res) {
        try {
            const { username, password } = req.body
            
            const users_exist = await User.findAll({
                where: { username }
            })
    
            if (users_exist.length === 0) { 
                return res.json({
                    message: `User '${username}' not found`
                })
            }
    
            const user_exist = users_exist[0];
    
            const match = await argon2.verify(user_exist.password, password)
    
            if (!match) {
                return res.json({
                    message: `Wrong password`
                })
            }
    
            return res.status(200).json({
                message: "Login Success",
                data: user_exist
            });
        } catch (error) {
            console.error(error)
            return res.json({
                message: error
            })
        }
    }
    
}

module.exports = UserController