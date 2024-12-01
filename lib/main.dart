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
      size: 160, // Ensure this matches outer size + stroke
      stroke: 10, // Stroke matches size difference
    ),
    CircleConfig(
      progress: 0.7,
      gradient: LinearGradient(colors: [Colors.purple, Colors.pink]),
      size: 140, // Adjusted to avoid gaps
      stroke: 10,
    ),
    CircleConfig(
      progress: 0.6,
      gradient: LinearGradient(colors: [Colors.green, Colors.blue]),
      size: 120,
      stroke: 10,
    ),
    CircleConfig(
      progress: 0.5,
      gradient: LinearGradient(colors: [Colors.black, Color.fromARGB(255, 0, 159, 11)]),
      size: 100, // Smallest circle
      stroke: 10,
    ),
  ];

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: double.infinity,
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/savings');
        },
        child: Card(
          color: Colors.white,
          child: Stack(
            alignment: Alignment.center,
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

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: -5.0, end: 5.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.elasticIn,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEDF4F2),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFFEDF4F2),
        elevation: 0,
        toolbarHeight: 100,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5.0, right: 30),
              child: _buildScanToPayButton(context),
            ),
            GestureDetector(
              onTap: () {
                _showNotificationDialog(context);
              },
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(_animation.value, 0),
                    child: child,
                  );
                },
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 50,
                  height: 50,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
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
              SavingsChartCard(),
              SizedBox(height: 20),
              StreakWidget(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        parentContext: context,
        currentIndex: 0,
      ),
    );
  }

  void _showNotificationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Color(0xFF31473A), // Set background color
        title: Row(
          children: [
            Container(
              width: 40, // Set the desired width
              height: 40, // Set the desired height
              child: ClipRect(
                child: Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.contain, // Adjust the fit property as needed
                ),
              ),
            ),
            SizedBox(width: 10), // Add spacing between logo and text
            Text(
              'Hello User',
              style: TextStyle(
                color: Colors.white, // Set text color to white
                fontFamily: 'Helvetica', // Set font to Helvetica
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start, // Align content to the left
          children: [
            Text(
              'How was your experience?\nPlease rate us!\nsmtg',
              style: TextStyle(
                color: Colors.white, // Set text color to white
                fontFamily: 'Helvetica', // Set font to Helvetica
              ),
            ),
            SizedBox(height: 10),
            Divider(
              color: Colors.white, // Set divider color to white
              thickness: 1, // Adjust thickness
            ),
            SizedBox(height: 10),
            Text(
              'Any suggestions for improvement?\nPlease let us know!\nsmtg',
              style: TextStyle(
                color: Colors.white, // Set text color to white
                fontFamily: 'Helvetica', // Set font to Helvetica
              ),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: 'Your response',
                labelStyle: TextStyle(
                  color: Colors.white70, // Set label text color
                  fontFamily: 'Helvetica', // Set font to Helvetica
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white), // White border
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white), // White border when focused
                ),
                border: OutlineInputBorder(),
              ),
              style: TextStyle(
                color: Colors.white, // Text color inside TextField
                fontFamily: 'Helvetica', // Set font to Helvetica
              ),
              maxLines: 2,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'Send',
              style: TextStyle(
                color: Colors.white, // Set button text color
                fontFamily: 'Helvetica', // Set font to Helvetica
              ),
            ),
          ),
        ],
      );
    },
  );
}


  Widget _buildScanToPayButton(BuildContext context) {
    return SizedBox(
      width: 270,
      child: ElevatedButton.icon(
        onPressed: () {
          Navigator.pushNamed(context, '/pay');
        },
        icon: Icon(Icons.qr_code_scanner, color: Color.fromARGB(255, 50, 171, 54)),
        label: Text(
          'Scan to pay',
          style: TextStyle(color: Color(0xFF31473A)),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.lightGreen[100],
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          alignment: Alignment.center,
        ),
      ),
    );
  }
}
