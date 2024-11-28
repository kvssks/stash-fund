// src/controllers/goalController.js
const Goal = require('../models/goal');

// Add a new goal
const addGoal = async (req, res) => {
  try {
    const { type, amount } = req.body;

    // Check if the goal already exists for the user
    const existingGoal = await Goal.findOne({ type, userId: req.user.id });
    if (existingGoal) {
      return res.status(400).json({ message: 'Goal already exists for this category.' });
    }

    const goal = new Goal({
      type,
      amount,
      userId: req.user.id,
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
    const { id } = req.params;

    const goal = await Goal.findOneAndDelete({ _id: id, userId: req.user.id });

    if (!goal) {
      return res.status(404).json({ message: 'Goal not found' });
    }

    res.status(200).json({ message: 'Goal deleted successfully' });
  } catch (error) {
    res.status(500).json({ message: 'Error deleting goal', error: error.message });
  }
};

module.exports = { addGoal, getGoals, updateGoal, deleteGoal };
