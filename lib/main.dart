import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_secret/components/auth_provider.dart';
import 'package:state_secret/screens/login.dart';
import 'package:state_secret/screens/signup.dart';
import 'package:state_secret/screens/categories.dart';
import 'package:state_secret/screens/form.dart';
import 'package:state_secret/screens/pay.dart';
import 'package:state_secret/screens/profile.dart';
import 'package:state_secret/screens/groupVault.dart';
import 'package:state_secret/screens/needsandwants.dart';
import 'package:state_secret/screens/savings.dart';
import 'package:state_secret/screens/manual_entry.dart';
import 'package:state_secret/screens/Grouplist.dart';

import 'package:state_secret/components/savings_chart.dart';
import 'package:state_secret/components/navbar.dart';
import 'package:state_secret/components/AnimatedTextButton.dart';
import 'package:state_secret/components/streak_widget.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AuthProvider(),
      child: MyApp(),
    ),
  );
}
class SavingsChartCard extends StatefulWidget {
  @override
  _SavingsChartCardState createState() => _SavingsChartCardState();
}

class _SavingsChartCardState extends State<SavingsChartCard> {
  List<CircleConfig> _buildCircles() {
    return [
      CircleConfig(
        progress: 0.8,
        gradient: LinearGradient(colors: [Colors.red, Colors.orange]),
        size: 150,
        stroke: 8,
      ),
      CircleConfig(
        progress: 0.7,
        gradient: LinearGradient(colors: [Colors.purple, Colors.pink]),
        size: 130,
        stroke: 8,
      ),
      CircleConfig(
        progress: 0.6,
        gradient: LinearGradient(colors: [Colors.green, Colors.blue]),
        size: 110,
        stroke: 8,
      ),
      CircleConfig(
        progress: 0.5,
        gradient: LinearGradient(colors: [Colors.black, const Color.fromARGB(255, 0, 159, 11)]),
        size: 170,
        stroke: 8,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/savings');
        },
        child: Card(
          color: Colors.white,
          child: Stack(
            alignment: Alignment.center, // Aligns text to the center
            children: [
              Padding(
                padding: EdgeInsets.all(18),
                child: SavingsChart(circles: _buildCircles()),
              ),
              Text(
                "Savings",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/groupList':
            return _createRoute(GroupListScreen());
          case '/manualentry':
            return _createRoute(ManualPage());
          case '/savings':
            return _createRoute(SavingsPage());
          case '/needsandwants':
            return _createRoute(EmptyPage());
          case '/home':
            return _createRoute(HomeScreen());
          case '/categories':
            return _createRoute(CategoriesPage());
          case '/form':
            return _createRoute(BudgetForm());
          case '/groupVault':
            return _createRoute(GroupVaultScreen());
          case '/pay':
            return _createRoute(PayScreen());
          case '/profile':
            return _createRoute(ProfileScreen());
          case '/signup':
            return _createRoute(SignupScreen());
          case '/login':
            return _createRoute(LoginScreen());
          default:
            return null;
        }
      },
    );
  }

  Route _createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0); // Start from right to left
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[50],
        elevation: 0,
        toolbarHeight: 100, // Increase height for better layout
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 30), // Adjust spacing
              child: SizedBox(
                width: 270, // Width for the button
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/pay');
                  },
                  icon: Icon(Icons.qr_code_scanner, color: Colors.green),
                  label: Text(
                    'Scan to Pay',
                    style: TextStyle(color: Colors.green, fontSize: 14),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightGreen[100],
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12), // Adjust padding
                  ),
                ),
              ),
            ),
            Image.asset(
              'assets/images/logo.png',
              width: 50, // Adjust the width as needed
              height: 50, // Adjust the height as needed
            ),
          ],
        ),
      ),
      body: SingleChildScrollView( // Added to make the page scrollable
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(right: 140),
                child: AnimatedTextButton(
                  text: 'Log Untracked Expenses ->',
                  route: '/manualentry',
                ),
              ),
              SizedBox(height: 20),
              SavingsChartCard(), // Existing Savings Chart Card
              SizedBox(height: 20), // Add space between cards
              StreakWidget(), // New Streak Card
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        parentContext: context,
        currentIndex: 0, // 0 for Home
      ),
    );
  }
}
Widget _buildScanToPayButton(BuildContext context) {
    return SizedBox(
      width: 270, // Makes the button take the full width of its parent
      child: ElevatedButton.icon(
        onPressed: () {
          Navigator.pushNamed(context, '/pay');
        },
        icon: Icon(Icons.qr_code_scanner, color: Colors.green),
        label: Text(
          'Scan to pay',
          style: TextStyle(color: Colors.green),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.lightGreen[100],
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12), // Adjust padding
          alignment: Alignment.center, // Center the content
        ),
      ),
    );
  }

