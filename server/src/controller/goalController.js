// src/controllers/goalController.js
const Goal = require('../models/goal');

// Add a new goal
const addGoal = async (req, res) => {
  try {
    const { type, amount ,userid} = req.body;
  
    // Check if the goal already exists for the user
    const existingGoal = await Goal.findOne({ type, userId: userid });
    if (existingGoal) {
      return res.status(400).json({ message: 'Goal already exists for this category.' });
    }

    const goal = new Goal({
      type,
      amount,
      userId: userid,
    });

    await goal.save();
    res.status(201).json(goal);
  } catch (error) {
    res.status(500).json({ message: 'Error adding goal', error: error.message });
  }
};

// Get all goals for the user
const getGoals = async (req, res) => {
  try {
    const goals = await Goal.find({ userId: req.user.id });
    res.status(200).json(goals);
  } catch (error) {
    res.status(500).json({ message: 'Error fetching goals', error: error.message });
  }
};

// Update a goal's amount
const updateGoal = async (req, res) => {
  try {
    const { id } = req.params;
    const { amount } = req.body;

    const goal = await Goal.findOneAndUpdate(
      { _id: id, userId: req.user.id },
      { amount },
      { new: true } // Return the updated document
    );

    if (!goal) {
      return res.status(404).json({ message: 'Goal not found' });
    }

    res.status(200).json(goal);
  } catch (error) {
    res.status(500).json({ message: 'Error updating goal', error: error.message });
  }
};

// Delete a goal
const deleteGoal = async (req, res) => {
  try {
    const { userid, type } = req.body; // Extract userId and type from the request body
    console.log(userid, type);
    // Find and delete the goal based on userId and type
    const goal = await Goal.findOneAndDelete({ userId : userid, type });

    if (!goal) {
      return res.status(404).json({ message: 'Goal not found for the given user and category.' });
    }

    res.status(200).json({ message: 'Goal deleted successfully', deletedGoal: goal });
  } catch (error) {
    res.status(500).json({ message: 'Error deleting goal', error: error.message });
  }
};


module.exports = { addGoal, getGoals, updateGoal, deleteGoal };
