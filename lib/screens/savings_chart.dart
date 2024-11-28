import 'package:flutter/material.dart';
import 'package:gradient_circular_progress_indicator/gradient_circular_progress_indicator.dart';

class SavingsChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Savings Progress")),
      body: Center(
        child: ConcentricGradientProgress(),
      ),
    );
  }
}

class ConcentricGradientProgress extends StatefulWidget {
  @override
  _ConcentricGradientProgressState createState() =>
      _ConcentricGradientProgressState();
}

class _ConcentricGradientProgressState extends State<ConcentricGradientProgress> {
  String _hoverText = ''; // Variable to store the text that will be displayed on hover

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Create each concentric circle using the reusable function wrapped in MouseRegion
        _buildConcentricCircle(
          progress: 0.25,
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.green],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          size: 300.0,
          stroke: 12.0,
          label: '25% Progress - Task 1', // Label for the circle
        ),
        _buildConcentricCircle(
          progress: 0.5,
          gradient: LinearGradient(
            colors: [Colors.red, Colors.orange],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          size: 250.0,
          stroke: 12.0,
          label: '50% Progress - Task 2', // Label for the circle
        ),
        _buildConcentricCircle(
          progress: 0.75,
          gradient: LinearGradient(
            colors: [Colors.purple, Colors.pink],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          size: 200.0,
          stroke: 12.0,
          label: '75% Progress - Task 3', // Label for the circle
        ),
        _buildConcentricCircle(
          progress: 0.9,
          gradient: LinearGradient(
            colors: [Colors.yellow, Colors.greenAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          size: 150.0,
          stroke: 12.0,
          label: '90% Progress - Task 4', // Label for the circle
        ),
        // Display the hover text when the mouse is over any of the circles
        Positioned(
          bottom: 50,
          child: AnimatedOpacity(
            opacity: _hoverText.isEmpty ? 0.0 : 1.0,
            duration: Duration(milliseconds: 300),
            child: Text(
              _hoverText,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                backgroundColor: Colors.white.withOpacity(0.7),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Reusable function to create a concentric circle with custom parameters
  Widget _buildConcentricCircle({
    required double progress,
    required LinearGradient gradient,
    required double size,
    required double stroke,
    required String label,
  }) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _hoverText = label; // Set hover text when entering the region
        });
      },
      onExit: (_) {
        setState(() {
          _hoverText = ''; // Clear hover text when exiting the region
        });
      },
      child: GradientCircularProgressIndicator(
        progress: progress, // Progress value for each circle
        gradient: gradient, // Gradient for each circle
        backgroundColor: Colors.grey, // Background color
        size: size, // Size of the circular progress indicator
        stroke: stroke, // Stroke width for the progress arc
      ),
    );
  }
}
