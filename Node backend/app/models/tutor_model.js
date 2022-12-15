const mongoose = require('mongoose');

const TutorSchema = mongoose.Schema(
    {
        id: {
            type: Number,
        },
        name: {
            type: String,
        },
        description: {
            type: String,
        },
        lastUpdated: {
            type: Number,
        },
        rating: {
            type: Number,
        },
        createdAt: {
            type: Number,
        },
        lastUpdatedBy: {
            type: String,
        },
        createUserId: {
            type: String,
        },
        mobile: {
            type: String,
        },
        subjectsTaught: [
            {type: String}
        ],
        address: {
            address1: {
                type: String,
            },
            address2: {
                type: String,
            },
            city: {
                type: String,
            },
            country: {
                type: String,
            },
            district: {
                type: String,
            },
            name: {
                type: String,
            },
            pincode: {
                type: String,
            },
            state: {
                type: String,
            },
        },
        imageUrl: {
            type: String
        },
        introVideoUrl: [
            {type: String}
        ],
        dob: {
            type: Number
        },
        timeTableRule: {
            type: String
        },
        noOfSession: {
            type: Number
        }
        
    }
);

module.exports = mongoose.model('tutor_model', TutorSchema);
