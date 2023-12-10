const getUserQuery = "SELECT password FROM patient WHERE password = $1";



const getUserPassword = "SELECT password FROM patient WHERE email = $1";

// Patient login register Query 
const loginQuery = "SELECT * FROM patient WHERE email = $1 AND password = $2";
const signUpCheckQuery = 'SELECT * FROM patient WHERE email = $1';
const signUpInsertQuery = "INSERT INTO patient (first_name, last_name, phone_number, email, password, imagepath) VALUES($1,$2,$3,$4,$5,$6)"

const doctorCheckQuery = 'SELECT * FROM doctor WHERE email = $1';
const doctorInputQuery = "INSERT INTO doctor (first_name, last_name, email, designation, location, working_time, description, phone_number, rating, image) VALUES($1,$2,$3,$4,$5,$6,$7,$8,$9,$10)"

// Doctor data fetch query 
const doctorDataFetch = 'SELECT * FROM doctor';


module.exports = {
    getUserQuery,
    loginQuery,
    signUpCheckQuery,
    signUpInsertQuery,
    getUserPassword,
    doctorCheckQuery,
    doctorInputQuery,
    doctorDataFetch
};

