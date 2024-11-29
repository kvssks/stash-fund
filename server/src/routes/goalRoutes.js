// src/routes/goalRoutes.js
const express = require('express');
const { addGoal, getGoals, updateGoal, deleteGoal } = require('../controller/goalController');


const router = express.Router();

// Add a new goal
router.post('/addGoal',  addGoal);

// Get all goals for the user
router.get('/getGoals/:id', getGoals);

// Update a goal
router.post('/updateGoal', updateGoal);

// Delete a goal
router.delete('/deleteGoal', deleteGoal);

module.exports = router;
