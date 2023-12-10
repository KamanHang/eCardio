const { Router } = require('express');
const controller = require('../controllers/controller')

const router =  Router();

router.get('/users', controller.getUser);
router.post('/login', controller.loginUser)
router.post('/signup', controller.signUpUser)
router.post('/upload', controller.imageUpload)
router.post('/doctor', controller.registerDoctor)
router.get('/doctordatafetch', controller.fetchDoctorData)





module.exports = router;