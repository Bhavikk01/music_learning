const mongoose = require("mongoose");
const config = require('../config/config');
const UserModel = require('../models/user_model');
const TutorModel = require('../models/tutor_model');
const CourseModel = require('../models/course_model');

class MongooseDatabase {
    constructor() {
        this.mongooseUrl = config.mongodb.url;
        this.client = null;
    }

    async connect(){
        mongoose.connect(this.mongooseUrl,
            {
                useNewUrlParser: true,
            }
        )
        .then((client) => {
            this.client = client;
            return client;
        })
        .catch((error) => {
            console.log(error + "occured while connectiong to mongoose database");
        });
    }
    
    //Insert Functions
    async insertUser(data){

        const ifExist = await this.getUser(data);
        console.log("This is the get: " + ifExist);

        if(ifExist.mobile != null){
            console.log("Here i am printing")
            return ifExist;
        }else{
            const user = UserModel({
                address: data.address,
                name: data.name,
                authToken: data.authToken,
                createdAt: data.createdAt,
                createUserId: data.createUserId,
                currentPreferedHobby: data.currentPreferedHobby,
                dob: data.dob,
                emailId: data.emailId,
                id: data.id,
                lastUpdated: data.lastUpdated,
                lastUpdatedBy: data.lastUpdatedBy,
                mobile: data.mobile,
                userStatus: data.userStatus
            });
            console.log("Here i am inside")
            return await user.save();
        }
    }

    async insertTutor(data){
        const tutor = TutorModel({
            id: data.id,
            name: data.name,
            description: data.description,
            lastUpdated: data.lastUpdated,
            rating: data.rating,
            createdAt: data.createdAt,
            lastUpdatedBy: data.lastUpdatedBy,
            createUserId: data.createUserId,
            mobile: data.mobile,
            subjectsTaught: data.subjectsTaught,
            address: data.address,
            imageUrl: data.imageUrl,
            introVideoUrl: data.introVideoUrl,
            dob: data.dob,
            timeTableRule: data.timeTableRule,
            noOfSession: data.noOfSession
        });
        return await tutor.save();
    }

    async insertCourse(data){
        const course = CourseModel({
            assignedWorkoutId: data.assignedWorkoutId,
            courseStatus: data.courseStatus,
            createUserId: data.createUserId,
            createdAt: data.createdAt,
            currentTutorId: data.currentTutorId,
            id: data.id,
            lastUpdated: data.lastUpdated,
            lastUpdatedBy: data.lastUpdatedBy,
            name: data.name,
            pastTutorIds: data.pastTutorIds,
            sessionId: data.sessionId,
            sessionsTaken: data.sessionsTaken,
            slotsLeft: data.slotsLeft,
            subject: data.subject,
            totalCourseCostYet: data.totalCourseCostYet,
            userId: data.userId
        });
        return await course.save();
    }

    //Get Functions
    async getUser(data){
        return await UserModel.find({mobile: data.mobile});
    }

    async getTutor(data){
        return TutorModel.find({});
    }

    async getCourse(){
        return CourseModel.find({});
    }
    
    async launch(){

        console.log("Connect to mongoose");
        console.log('mongoose-connect');

        await this.connect()
            .then(() => {
                console.log('Successfully connected to mongoose');
            }).catch((err) => {
                console.log( err + ' while connecting to mongoose');
            });
    }
}

module.exports = MongooseDatabase