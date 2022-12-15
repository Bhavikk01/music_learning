const mongoose = require('mongoose');

const UserSchema = mongoose.Schema(
    {
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
        name: {
            type: String,
        },
        authToken: {
            type: String,
            default: "authToken"
        },
        createdAt: {
            type: Number,
        },
        createUserId: {
            type: String,
        },
        currentPreferedHobby: {
            type: String,
        },
        dob: {
            type: Number,
        },
        emailId: {
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
        mobile: {
            type: String,
        },
        userStatus: {
            type: String,
        },
    }
);

module.exports = mongoose.model('user_model', UserSchema);
