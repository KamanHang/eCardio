const getPatientDetailsQuery = "SELECT * FROM patient WHERE email = $1";
const getDoctorDetailsQuery = "SELECT * FROM doctor WHERE doctor_id = $1";
const getAppointment = "SELECT * FROM appointments WHERE patient_id = $1";





const getUserPassword = "SELECT password FROM patient WHERE email = $1";

// Patient login register Query 
const loginQuery = "SELECT * FROM patient WHERE email = $1 AND password = $2";
const signUpCheckQuery = 'SELECT * FROM patient WHERE email = $1';
const signUpInsertQuery = "INSERT INTO patient (first_name, last_name, phone_number, email, password, imagepath) VALUES($1,$2,$3,$4,$5,$6)"

const doctorCheckQuery = 'SELECT * FROM doctor WHERE email = $1';
const doctorInputQuery = "INSERT INTO doctor (first_name, last_name, email, designation, location, working_time, description, phone_number, rating, image, password) VALUES($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11)"

// Doctor data fetch query 
const doctorDataFetch = 'SELECT * FROM doctor';
const appointmentDataFetch = 'SELECT * FROM appointments';



const bookAppointment = "INSERT INTO appointments (appointment_type, appointment_date, appointment_time, patient_id, doctor_id, week_day, patient_name, doctor_name, patient_email) VALUES($1,$2,$3,$4,$5,$6,$7,$8,$9)";

//Insert Medical report
const inputMedicalReport = "INSERT INTO MedicalReports (patient_id, Test, Result, RefRange, ReportDate) VALUES($1,$2,$3,$4,$5)"
// const getMedicalReport = "SELECT Test, Result, ReportDate FROM MedicalReports WHERE patient_id = $1";
const getMedicalReport = "SELECT * FROM medicalreports WHERE patient_id = $1";





module.exports = {
    getPatientDetailsQuery,
    loginQuery,
    signUpCheckQuery,
    signUpInsertQuery,
    getUserPassword,
    doctorCheckQuery,
    doctorInputQuery,
    doctorDataFetch,
    getDoctorDetailsQuery,
    bookAppointment,
    appointmentDataFetch,
    getAppointment,
    inputMedicalReport,
    getMedicalReport
};

