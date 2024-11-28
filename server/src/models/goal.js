// src/models/Goal.js
const mongoose = require('mongoose');

const goalSchema = new mongoose.Schema({
  type: {
    type: String,
    enum: [
      'Dining Out',
      'Shopping',
      'Entertainment',
      'Movies',
      'Vacation',
      'Rent',
      'Food',
      'Transportation',
      'Utilities',
      'Insurance',
    ],
    required: true,
  },
  amount: {
    type: Number,
    required: true,
    min: 0,
  },
  userId: {
    type: String,
    ref: 'User',
    required: true,
  },
}, { timestamps: true });

module.exports = mongoose.model('Goal', goalSchema);
