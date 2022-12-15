const mongoose = require('mongoose');

const CourseSchema = mongoose.Schema(
    {
        assignedWorkoutId: [
            {type: String}
        ],
        courseStatus: {
            type: String,
        },
        createUserId: {
            type: String,
        },
        createdAt: {
            type: String,
        },
        currentTutorId: {
            type: String,
        },
        id: {
            type: String,
        },
        lastUpdated: {
            type: Number,
        },
        lastUpdatedBy: {
            type: String,
        },
        name: {
            type: Number,
        },
        pastTutorIds: [
            {type: String}
        ],
        pricingPlan: {
            type: String,
        },
        sessionId: [
            {type: String}
        ],
        sessionsTaken: {
            type: Number,
        },
        slotsLeft: {
            type: Number,
        },
        subject: {
            type: String,
        },
        totalCourseCostYet: {
            type: Number,
        },
        userId: {
            type: String,
        },
    }
);

module.exports = mongoose.model('course_model', CourseSchema);
