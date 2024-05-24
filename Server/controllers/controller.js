const con = require('../config/dbConfig')
const query = require('../queries/queries')
const bcrypt = require('bcryptjs');
const nodemailer = require("nodemailer");

const getPatientDetails = (req, resp) => {
    const { email } = req.body;

    console.log('Getting user data');

    con.query(query.getPatientDetailsQuery, [email], function (err, data) {


        if (err) {
            console.log(err);
            resp.send("Ann error has occured")

        }
        else if (data.rowCount == 0) {
            console.log(data.rows);
            console.log("User Doesnot exist")
            con.end()
        }
        else {
            console.log(data.rows);
            resp.send(data.rows);

        }
    })
}

const getDocDetails = (req, resp) => {
    const { docID } = req.body;

    console.log(docID);

    con.query(query.getDoctorDetailsQuery, [docID], function (err, data) {


        if (err) {
            console.log(err);
            resp.send("Ann error has occured")

        }
        else if (data.rowCount == 0) {
            console.log(data.rows);
            console.log("Doctor Doesnot exist")
            con.end()
        }
        else {
            console.log(data.rows);
            resp.send(data.rows);

        }
    })
}


const loginUser = async (req, resp) => {


    const { email, password } = req.body;

    console.log(email)
    console.log(password)


    if (!email || !password) {

        console.log("Please fill al the fields")

        resp.status(400).send('Please fill all the fields');

    }
    else {
        con.query(query.getUserPassword, [email], async (error, result) => {
            console.log(result.rows[0].password)

            var dbPassword = result.rows[0].password

            console.log(password)



            const passwordCheck = await bcrypt.compare(password, dbPassword);
            console.log(passwordCheck)


            if (passwordCheck == true) {
                console.log("login success")
                resp.status(200).send('Login successful');

            }

            else {
                resp.status(400).send('Login Failed');

            }



        })

    }


}

const signUpUser = (req, resp) => {
    const { first_name, last_name, phone_number, email, password } = req.body;
    image = req.file.path;

    console.log(first_name)
    console.log(last_name)
    console.log(phone_number)

    console.log(email);
    console.log(password);
    // console.log(req.body);
    // console.log(image);
    // console.log(req.body);
    // console.log(req.file);
    // console.log(imagePath);

    const securePassword = async (password) => {
        const encryptPassword = await bcrypt.hash(password, 10);
        return encryptPassword
    }


    try {
        con.query(query.signUpCheckQuery, [email], async function (err, data) {

            // console.log(data)

            if (err) {
                console.log(err);
                resp.send("An error occured")
                resp.status(404);
            }

            else if (data.rowCount > 0) { //checking if user with same email exits or not in the database
                console.log("User alredy exists");
                // console.log(`${data.rowCount}`);
                resp.send("User alredy exists");
                resp.status(404);

            }
            else if (!first_name || !last_name || !phone_number || !email || !password || !image) {
                resp.send('Please fill all the fields')
                console.log("Please fill all the fields");

            }
            else {

                const hashedPassword = await securePassword(password);

                console.log(hashedPassword)

                con.query(query.signUpInsertQuery, [first_name, last_name, phone_number, email, hashedPassword, image], function (err, data) {
                    if (err) {
                        console.log(err);
                    } else {
                        console.log("User Registered Successfully");
                        resp.send("User Registration Successfully")
                        // console.log(data)
                    }
                });

            }
        })

    } catch (error) {
        console.log("An error occurred:", error);
    }
}



const registerDoctor = (req, resp) => {
    const { first_name, last_name, email, designation, location, work, description, phone_number, rating, password } = req.body;
    image = req.file.path;

    console.log(first_name)
    console.log(last_name)
    console.log(email)
    console.log(designation)
    console.log(location)
    console.log(work)
    console.log(description)
    console.log(phone_number)
    console.log(rating);
    console.log(image);
    console.log(password);





    try {
        con.query(query.doctorCheckQuery, [email], async function (err, data) {

            // console.log(data)

            if (err) {
                console.log(err);
                resp.send("An error occured")
                resp.status(404);
            }

            else if (data.rowCount > 0) { //checking if user with same email exits or not in the database
                console.log("User alredy exists");
                // console.log(`${data.rowCount}`);
                resp.send("User alredy exists");
                resp.status(404);

            }
            else if (!first_name || !last_name || !email || !designation || !location || !work || !description || !phone_number || rating || !image || !password) {
                resp.send('Please fill all the fields')
                console.log("Please fill all the fields");

            }
            else {


                con.query(query.doctorInputQuery, [first_name, last_name, email, designation, location, work, description, phone_number, rating, image, password], function (err, data) {
                    if (err) {
                        console.log(err);
                    } else {
                        console.log("User Registered Successfully");
                        resp.send("User Registration Successfully")
                        // console.log(data)
                    }
                });

            }
        })

    } catch (error) {
        console.log("An error occurred:", error);
    }
}

const imageUpload = (req, resp) => {
    console.log(req.body);
    console.log(req.file);
}


const fetchDoctorData = (req, resp) => {
    con.query(query.doctorDataFetch, function (err, data) {


        if (err) {
            console.log(err);
            resp.send("Ann error has occured")

        }
        else {
            console.log(data.rows);
            resp.send(data.rows);

        }
    })
}

const makeAppointment = (req, resp) => {
    const { appointment_type, appointment_date, appointment_time, patient_id, doctor_id, week_day, patient_name, doctor_name, patientEmail } = req.body;

    try {
        con.query(query.bookAppointment, [appointment_type, appointment_date, appointment_time, patient_id, doctor_id, week_day, patient_name, doctor_name, patientEmail], function (err, data) {
            if (err) {
                console.log(err);
            } else {
                const transporter = nodemailer.createTransport({
                    service: 'gmail',
                    auth: {
                        user: "ecardio.service.app@gmail.com",
                        pass: "ujsv rfzr afrd hrjg",
                    },
                });

                const mailOptions = {
                    from: {
                        name: 'eCardio',
                        address: 'ecardio.service.app@gmail.com'
                    },
                    to: patientEmail,
                    subject: "eCardio Appointment Details",
                    html: `
                        <html>
                        <head>
                            <style>
                                body {
                                    font-family: Arial, sans-serif;
                                    background-color: #f4f4f4;
                                    color: #333;
                                    margin: 0;
                                    padding: 0;
                                }
                                .container {
                                    max-width: 600px;
                                    margin: 20px auto;
                                    padding: 20px;
                                    background-color: #fff;
                                    border-radius: 5px;
                                    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                                }
                                h2 {
                                    color: #007bff;
                                }
                                p {
                                    margin: 10px 0;
                                }
                            </style>
                        </head>
                        <body>
                            <div class="container">
                                <h2>Appointment Details</h2>
                                <p>Greetings ${patient_name},</p>
                                <p>Thank you for booking an appointment through eCardio App.</p>
                                <p><b>Here are your appointment details:</b></p>
                                <p><strong>Appointment Type:</strong> ${appointment_type}</p>
                                <p><strong>Date:</strong> ${appointment_date}</p>
                                <p><strong>Week Day:</strong> ${week_day}</p>
                                <p><strong>Time:</strong> ${appointment_time}</p>
                                <p><strong>Patient Name:</strong> ${patient_name}</p>
                                <p><strong>Doctor Name:</strong> ${doctor_name}</p>
                                <p><strong>Appointment Fee:</strong> Rs. 700</p>
                            </div>
                        </body>
                        </html>
                    `
                };

                transporter.sendMail(mailOptions, function (error, info) {
                    if (error) {
                        console.log(error);
                    } else {
                        console.log("Email sent: " + info.response);
                        resp.send("Appointment Booked Successfully");
                    }
                });
            }
        });

    } catch (error) {
        console.log("An error occurred:", error);
    }
}


const getAppointmentData = (req, resp) => {
    con.query(query.appointmentDataFetch, function (err, data) {


        if (err) {
            console.log(err);
            resp.send("Ann error has occured")

        }
        else {
            console.log(data.rows);
            resp.send(data.rows);

        }
    })
}

const getAppointment = (req, resp) => {
    const { patient_id } = req.body;

    console.log(patient_id);

    con.query(query.getAppointment, [patient_id], function (err, data) {


        if (err) {
            console.log(err);
            resp.send("Ann error has occured")

        }
        else if (data.rowCount == 0) {
            console.log(data.rows);
            console.log("You don't have any appointment")
            con.end()
        }
        else {
            console.log(data.rows);
            resp.send(data.rows);

        }
    })
}


const saveMedicalData = (req, resp) => {
    const { patient_id, Test, Result, RefRange, ReportDate } = req.body;
console.log(patient_id);
console.log(Test);
console.log(Result);
console.log(RefRange);
console.log(ReportDate);


    try {
        if (!patient_id || !Test || !Result || !RefRange || !ReportDate) {
            resp.send('Please fill all the fields')
            console.log("Please fill all the fields");

        }
        else {


            con.query(query.inputMedicalReport, [patient_id, Test, Result, RefRange, ReportDate], function (err, data) {
                if (err) {
                    console.log(err);
                } else {
                    console.log("Data Save Successfully");
                    resp.send("Data Save Successfully")
                    // console.log(data)
                }
            });

        }

    } catch (error) {
        console.log("An error occurred:", error);
    }
}


const getReportData = (req, resp) => {
    const { patient_id } = req.body;

    console.log(patient_id);

    con.query(query.getMedicalReport, [patient_id], function (err, data) {


        if (err) {
            console.log(err);
            resp.send("Ann error has occured")

        }
        else if (data.rowCount == 0) {
            console.log(data.rows);
            console.log("You don't have any medical report")
            // con.end()
        }
        else {
            console.log(data.rows);
            resp.send(data.rows);

        }
    })
}

// const getReportDatabyDate = (req, resp) => {
//     const { patient_id } = req.body;

//     console.log(patient_id);

//     con.query(query.getMedicalReport, [patient_id], function (err, data) {


//         if (err) {
//             console.log(err);
//             resp.send("Ann error has occured")

//         }
//         else if (data.rowCount == 0) {
//             console.log(data.rows);
//             console.log("You don't have any medical report")
//             // con.end()
//         }
//         else {
//             console.log(data.rows);
//             resp.send(data.rows);

//         }
//     })
// }


module.exports = {
    getPatientDetails,
    loginUser,
    signUpUser,
    imageUpload,
    registerDoctor,
    fetchDoctorData,
    getDocDetails,
    makeAppointment,
    getAppointmentData,
    getAppointment,
    saveMedicalData,
    getReportData
};