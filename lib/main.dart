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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.only(top: 65.0, right: 30), // Adjust the top padding as needed
                  child: _buildScanToPayButton(context),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 65.0), // Adjust the top padding as needed
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 50, // Adjust the width as needed
                    height: 50, // Adjust the height as needed
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(right: 140),
              child: AnimatedTextButton(
                text: 'Log Untracked Expenses ->',
                route: '/manualentry',
              ),
            ),
            SizedBox(height: 20),
            SavingsChartCard(),
            SizedBox(height: 24),
            _buildPendingPayments(),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        parentContext: context,
        currentIndex: 0, // 0 for Home
      ),
    );
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

  Widget _buildPendingPayments() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Mark For Later',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              'Pending log entries',
              style: TextStyle(color: Colors.grey),
            ),
            Divider(),
            _buildPaymentItem('Payment 1'),
            Divider(),
            _buildPaymentItem('Payment 2'),
            Divider(),
            _buildPaymentItem('Payment 3'),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentItem(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Text('₹'),
      ],
    );
  }
}
