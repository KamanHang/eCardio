const con = require('../config/dbConfig')
const query = require('../queries/queries')
const bcrypt = require('bcryptjs');

const baseUrl = "http://192.168.1.130/"




const getUser = (req, resp) => {
    console.log('Getting user data');

    con.query(query.getUserQuery, (error, result) => {
        if (error) throw error;
        resp.status(200).json(result.rows);
    })
}


const loginUser = async (req, resp) => {
    

    const { email, password } = req.body;

    console.log(email)
    console.log(password)


   if (!email || !password){

        console.log("Please fill al the fields")
     
        resp.status(400).send('Please fill all the fields');

   }
   else{
    con.query(query.getUserPassword, [email], async (error, result) => {
        console.log(result.rows[0].password)

        var dbPassword = result.rows[0].password

        console.log(password)



        const passwordCheck = await bcrypt.compare(password, dbPassword);
        console.log(passwordCheck)


        if(passwordCheck == true){
            console.log("login success")
            resp.status(200).send('Login successful');

        }

        else{
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

    const securePassword = async (password) =>{
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
            else if ( !first_name || !last_name|| !phone_number|| !email || !password || !image) {
                resp.send('Please fill all the fields')
                console.log("Please fill all the fields");

            }
            else {

                // console.log("Don't Know WTF is going on")
                const hashedPassword = await securePassword(password);

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
    const { first_name, last_name, email, designation, location, work, description, phone_number, rating  } = req.body;
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
            else if ( !first_name || !last_name || !email || !designation || !location || !work || !description || !phone_number || !rating || !image ) {
                resp.send('Please fill all the fields')
                console.log("Please fill all the fields");

            }
            else {


                con.query(query.doctorInputQuery, [first_name, last_name, email, designation, location, work, description, phone_number, rating, image], function (err, data) {
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
    con.query(query.doctorDataFetch, function (err,data) {


        if(err){
            console.log(err);
            resp.send("Ann error has occured")

        }
        else{
            console.log(data.rows);
            resp.send(data.rows);

        }
    })
}



module.exports = {
    getUser,
    loginUser,
    signUpUser,
    imageUpload,
    registerDoctor,
    fetchDoctorData
};