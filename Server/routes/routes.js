const { Router } = require('express');
const controller = require('../controllers/controller')

const router =  Router();

router.post('/patientdetails', controller.getPatientDetails);
router.post('/login', controller.loginUser)
router.post('/signup', controller.signUpUser)
router.post('/upload', controller.imageUpload)
router.post('/doctor', controller.registerDoctor)
router.get('/doctordatafetch', controller.fetchDoctorData)
router.post('/doctordetails', controller.getDocDetails)
router.post('/bookAppointment', controller.makeAppointment)
router.get('/getAppointment', controller.getAppointmentData)
router.post('/fetchappointment', controller.getAppointment)
router.post('/savemedicaldata', controller.saveMedicalData)
router.post('/getmedicaldata', controller.getReportData)

















module.exports = router;