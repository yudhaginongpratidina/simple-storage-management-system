class WellcomeController {

    static async index (req, res) {
        res.json({message: `Backend is running on http://${process.env.APP_HOST}:${process.env.APP_PORT}`});
    }

}


module.exports = WellcomeController