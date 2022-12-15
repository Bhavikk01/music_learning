const MongooseDatabase = require('../mongoose/mongoose_database');
const express = require('express');

const mongooseDatabase = new MongooseDatabase();
const app = express();
app.use(express.json());
app.use(
    express.urlencoded(
        {
            extended: true
        }
    )
);

// Home Route
app.get("/", function (req, res) {
    res.send("This is the home page");
});

mongooseDatabase.launch().then(() => {
    console.log('Connection to mongoose is completed');
});

app.listen(5000, function () {
    console.log("Server started at port 5000");
});


app.post("/api/getUser", async (req, res) => {
    await mongooseDatabase.insertUser(req.body)
    .then((user) => {
        console.log(user);
        res.send(user).status(400)
    })
});

app.post("/api/tutor", async (req, res) => {
    await mongooseDatabase.insertTutor(req.body)
    .then((tutor) => {
        res.send(tutor).status(400)
    })
});

app.post("/api/course", async (req, res) => {
    await mongooseDatabase.insertCourse(req.body)
    .then((course) => {
        res.send(course).status(400)
    })
});

//Get Tutor
app.get("/api/getTutor", async (req, res) => {
    await mongooseDatabase.getTutor(req.body)
    .then((tutor) => {
        res.send(tutor).status(400)
    })
    .catch((error) => {
        console.log(error + "has occured");
        res.sendStatus(200)
    });
});

//Get Course
app.get("/api/getAllCourses", async (req, res) => {
    await mongooseDatabase.getCourse()
    .then((courses) => {
        res.send(courses).status(400)
    });
});
