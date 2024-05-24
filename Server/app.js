const express = require('express');
// const bodyParser = require('body-parser');
const routes = require('./routes/routes')
const httpServer = require('http');
const app = express();
const cors = require('cors');
const server = httpServer.createServer(app);
app.use(express.json());
app.use(cors());

app.use(express.urlencoded({extended: false}));
// app.use(bodyParser.json({ limit: '10mb' }));


const path = require("path");

app.use(express.static('images'));
app.use('/images', express.static('images'));
const port = 3000;



const multer  = require('multer')
const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, 'images/patient')
  },
  filename: function(req, file, cb) {
    return cb(null, `${Date.now()}-${file.originalname}`);
  }
})

const upload = multer({ storage: storage });

const storageDoc = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, 'images/doctor')
  },
  filename: function(req, file, cb) {
    return cb(null, `${Date.now()}-${file.originalname}`);
  }
})

const uploadDoc = multer({ storage: storageDoc });

app.set("view engine", "ejs");
app.set("views", path.resolve("./views"))

app.get("/", (req, res)=> {
    return res.render("doctor");
})

app.post('/patientdetails', routes);
app.post('/login', routes);
app.post('/signup', upload.single("image"), routes);
app.post('/doctor', uploadDoc.single("image"), routes);
app.get('/doctordatafetch', routes);
app.post('/doctordetails', routes)
app.post('/bookAppointment', routes)
app.post('/sendemail', routes)
app.get('/getAppointment',routes)
app.post('/fetchappointment',routes)
app.post('/savemedicaldata',routes)
app.post('/getmedicaldata', routes)











server.listen(port, ()=>{
    console.log(`Server is running on ${port} port`);
})