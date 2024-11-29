require('dotenv').config(); // Load environment variables
const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');
// const morgan = require('morgan');

// Import Routes
// const userRoutes = require('./src/routes/userRoutes');
const goalRoutes = require('./src/routes/goalRoutes');
const authRoutes = require('./src/routes/authRoutes');
const personalVaultRoutes = require('./src/routes/personalVaultRoutes');
const groupVaultRoutes = require('./src/routes/groupVaultRoutes');
// Initialize Express App
const app = express();

// Middleware
app.use(express.json()); // Parse JSON bodies
app.use(cors()); // Enable Cross-Origin Resource Sharing
// app.use(morgan('dev')); // Log HTTP requests in dev mode

// Routes
// app.use('/api/users', userRoutes); // User authentication routes
app.use('/api/goals', goalRoutes); // Financial goal routes
app.use("/api/auth", authRoutes);
app.use('/personal-vault', personalVaultRoutes);
app.use('/group-vault', groupVaultRoutes);
// Database Connection
mongoose
  .connect(process.env.MONGO_URI)
  .then(() => console.log('Connected to MongoDB'))
  .catch((error) => console.error('Database connection error:', error));

// Start Server
const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
