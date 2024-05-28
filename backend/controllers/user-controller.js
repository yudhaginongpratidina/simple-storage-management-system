const prisma = require('../libs/prisma');
const argon2 = require('argon2');

class UserController {

    // =================================================================
    // MENDAPATKAN SEMUA DATA USER
    // =================================================================
    static async getUsers(req, res) {
        try {
            const response = await prisma.user.findMany();
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
            // TANGKAP ID DARI PARAMETER URL
            const { id } = req.params

            const response = await prisma.user.findUnique({
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
    // MEMBUAT USER BARU
    // =================================================================
    static async createUser(req, res) {
        try {
            const {username, password} = req.body

            // APAKAH USERNAME SUDAH PERNAH DIGUNAKAN
            const username_exist = await prisma.user.findMany({
                where: { username }
            })

            // JIKA USERNAME SUDAH DIGUNAKAN KIRIM ERROR
            if (username_exist.length > 0) {
                return res.status(400).json({
                    message: `the ${username} has already been registered`
                })
            }

            // ENKRIPSI PASSWORD
            const hash = await argon2.hash(password)

            // JIKA USERNAME BELUM PERNAH DI REGISTRASIKAN, MAKA LANJUTKAN
            // PROSES MEMBUAT USER BARU
            const response = await prisma.user.create({
                data: {
                    username : username,
                    password : hash
                }
            })

            // KIRIM RESPONSE JIKA USER BERHASIL TEREGISTRASI
            return res.status(200).json({
                message: "Success",
                data: response
            });

        } catch (error) {
            console.log(error)
        }
    }


    // =================================================================
    // MENGHAPUS USER BERDASARKAN ID
    // =================================================================
    static async deleteUserById(req, res) {
        try {
            const { id } = req.params
    
            const user_exist = await prisma.user.findUnique({
                where: { id }
            })
    
            if (!user_exist) {
                return res.status(400).json({
                    message: `the user with ID ${id} not found`
                })
            }
    
            const response = await prisma.user.delete({
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
            
            const users_exist = await prisma.user.findMany({
                where: { username }
            })
    
            if (users_exist.length === 0) { 
                return res.status(400).json({
                    message: `User '${username}' not found`
                })
            }
    
            const user_exist = users_exist[0];
    
            const match = await argon2.verify(user_exist.password, password)
    
            if (!match) {
                return res.status(400).json({
                    message: `Wrong password`
                })
            }
    
            return res.status(200).json({
                message: "Success",
                data: user_exist
            });
        } catch (error) {
            console.error(error)
            return res.status(500).json({
                message: "Internal Server Error"
            })
        }
    }
    
    
}

module.exports = UserController