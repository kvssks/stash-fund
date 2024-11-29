import 'package:flutter/material.dart';
import 'package:state_secret/screens/dashboard.dart';
import 'package:state_secret/screens/missions.dart';
import 'package:state_secret/screens/pay.dart';
import 'package:state_secret/screens/profile.dart';
import 'package:state_secret/screens/savings.dart';
// import 'package:state_secret/components/savings_chart.dart';
import 'package:state_secret/screens/test.dart';
import 'package:state_secret/screens/form.dart';
import 'package:state_secret/screens/categories.dart';

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
      debugShowCheckedModeBanner: false,
      title: 'Routing Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
      routes: {
        // '/savings_chart':(context) => SavingsChart(),
        '/categories': (context) => CategoriesPage(),
        '/form': (context) => BudgetForm(),
        '/test': (context) => TestScreen(),
        '/dashboard': (context) => DashboardScreen(),
        '/pay': (context) => PayScreen(),
        '/missions': (context) => MissionsScreen(),
        '/savings': (context) => SavingsPage(),
        '/profile': (context) => ProfileScreen(),
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
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.pushNamed(context, '/savings_chart');
            //   },
            //   child: Text('Go to savings chart'),
            // ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/categories');
              },
              child: Text('Go to categories'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/form');
              },
              child: Text('Go to form'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/test');
              },
              child: Text('Go to test'),
            ),
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
