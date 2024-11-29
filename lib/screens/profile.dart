import 'package:flutter/material.dart';
import 'package:state_secret/components/navbar.dart';


class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Account Stats',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            SizedBox(height: 20),
            Text('Name: John Doe'),
            Text('Points: 500'),
            Text('Completed Missions: 5'),
            Text('Total Savings: \$450'),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        parentContext: context,
        currentIndex: 3, // 0 for Home
      ),
    );
  }
}
