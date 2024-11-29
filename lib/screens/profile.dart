import 'package:flutter/material.dart';
import 'package:state_secret/components/navbar.dart';
import 'package:state_secret/screens/categories.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 30), // Adjust padding as needed
          Padding(
            padding: const EdgeInsets.only(top: 50.0), // Add padding above the avatar
            child: CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage(
                  'assets/images/logo.png'), 
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "Avtomat Kalashnikova",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(height: 5),
          Text(
            "@kalashnikova_ak47",
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
          const SizedBox(height: 30),
          ListTile(
            leading: Icon(Icons.person, color: Colors.blueGrey),
            title: Text("Edit Profile"),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to Edit Profile page
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => ),
              // );
            },
          ),
          Divider(height: 1, thickness: 1),
          ListTile(
            leading: Icon(Icons.flag, color: Colors.blueGrey),
            title: Text("Set up Goal"),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to CategoriesPage
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CategoriesPage()),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        parentContext: context,
        currentIndex: 3, // 3 for Profile
      ),
    );
  }
}
