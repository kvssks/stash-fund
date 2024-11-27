import 'package:flutter/material.dart';
import 'package:state_secret/screens/dashboard.dart';
import 'package:state_secret/screens/missions.dart';
import 'package:state_secret/screens/pay.dart';
import 'package:state_secret/screens/profile.dart';
import 'package:state_secret/screens/qr.dart';
import 'package:state_secret/screens/savings.dart';
// import 'dashboard.dart';
// import 'pay.dart';
// import 'missions.dart';
// import 'savings.dart';
// import 'profile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Routing Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
      routes: {
        '/dashboard': (context) => DashboardScreen(),
        // '/pay': (context) => PayScreen(),
        '/missions': (context) => MissionsScreen(),
        '/savings': (context) => SavingsScreen(),
        '/profile': (context) => ProfileScreen(),
        '/pay': (context) => QRViewExample(),

      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/dashboard');
              },
              child: Text('Go to Dashboard'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/pay');
              },
              child: Text('Go to Pay'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/missions');
              },
              child: Text('Go to Missions'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/savings');
              },
              child: Text('Go to Savings'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/profile');
              },
              child: Text('Go to Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
