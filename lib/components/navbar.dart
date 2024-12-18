import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final BuildContext parentContext;
  final int currentIndex;

  CustomBottomNavigationBar({
    required this.parentContext,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Color.fromARGB(255, 50, 171, 54),
      unselectedItemColor: Color(0xFF31473A),
      backgroundColor: Color(0xFFEDF4F2),
      currentIndex: currentIndex,
      onTap: (int index) {
        switch (index) {
          case 0:
            Navigator.pushReplacementNamed(parentContext, '/home');
            break;
          case 1:
            Navigator.pushReplacementNamed(parentContext, '/groupList');
            break;
          case 2:
            Navigator.pushReplacementNamed(parentContext, '/needsandwants');
            break;
          case 3:
            Navigator.pushReplacementNamed(parentContext, '/profile');
            break;
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.wallet),
          label: 'Group Vault',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.monetization_on),
          label: 'Needs and Wants',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}
