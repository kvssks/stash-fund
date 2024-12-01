import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // For encoding and decoding JSON
import 'package:state_secret/components/navbar.dart';
import 'package:state_secret/services/groupVaultService.dart';

class GroupListScreen extends StatefulWidget {
  const GroupListScreen({Key? key}) : super(key: key);

  @override
  _GroupListScreenState createState() => _GroupListScreenState();
}

class _GroupListScreenState extends State<GroupListScreen> {
  List<dynamic> groupVaults = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchGroupVaults();
  }

  Future<void> fetchGroupVaults() async {
    final service = GroupVaultService();
    final userId = "6749954e5c6f1e3fc91d100f"; // Replace with actual userId
    final response = await service.getUserVaults(userId);

    if (response['success']) {
      setState(() {
        groupVaults = response['userVaults'];
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response['message'])),
      );
    }
  }

  Future<void> saveGroupToSharedPreferences(Map<String, dynamic> group) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('selectedGroup', jsonEncode(group)); // Save as a JSON string
  }

  Future<void> createNewGroupVault(String name, String purpose) async {
    final service = GroupVaultService();
    final response = await service.createGroupVault(name, purpose);

    if (response['success']) {
      setState(() {
        groupVaults.add(response['groupVault']); // Add the new group to the list
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Group Vault "$name" created successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${response['message']}')),
      );
    }
  }

  void showCreateGroupDialog() {
    String groupName = '';
    String groupPurpose = '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
  backgroundColor: const Color(0xFF31473A), // Set background color
  title: const Text(
    'Create New Group Vault',
    style: TextStyle(
      color: Colors.white, // Set text color to white
      fontFamily: 'Helvetica', // Set font to Helvetica
    ),
  ),
  content: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      TextField(
        decoration: const InputDecoration(
          hintText: 'Group Name',
          hintStyle: TextStyle(
            color: Colors.white70, // Hint text color
            fontFamily: 'Helvetica', // Set font to Helvetica
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white), // White border
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white), // White border when focused
          ),
        ),
        style: const TextStyle(
          color: Colors.white, // Text color inside TextField
          fontFamily: 'Helvetica', // Set font to Helvetica
        ),
        onChanged: (value) {
          groupName = value;
        },
      ),
      const SizedBox(height: 16),
      TextField(
        decoration: const InputDecoration(
          hintText: 'Purpose',
          hintStyle: TextStyle(
            color: Colors.white70, // Hint text color
            fontFamily: 'Helvetica', // Set font to Helvetica
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white), // White border
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white), // White border when focused
          ),
        ),
        style: const TextStyle(
          color: Colors.white, // Text color inside TextField
          fontFamily: 'Helvetica', // Set font to Helvetica
        ),
        onChanged: (value) {
          groupPurpose = value;
        },
      ),
    ],
  ),
  actions: [
    TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: const Text(
        'Cancel',
        style: TextStyle(
          color: Colors.white, // Set button text color
          fontFamily: 'Helvetica', // Set font to Helvetica
        ),
      ),
    ),
    TextButton(
      onPressed: () {
        Navigator.pop(context);
        if (groupName.isNotEmpty && groupPurpose.isNotEmpty) {
          createNewGroupVault(groupName, groupPurpose);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Name and Purpose are required!',
                style: TextStyle(
                  color: Colors.white, // Set text color to white
                  fontFamily: 'Helvetica', // Set font to Helvetica
                ),
              ),
              backgroundColor: Color(0xFF31473A), // Match background color
            ),
          );
        }
      },
      child: const Text(
        'Create',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEDF4F2),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Group List',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Color(0xFFEDF4F2),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : groupVaults.isEmpty
              ? const Center(child: Text('No groups found'))
              : ListView.builder(
                  itemCount: groupVaults.length,
                  itemBuilder: (context, index) {
                    final group = groupVaults[index];
                    return GestureDetector(
                      onTap: () async {
                        await saveGroupToSharedPreferences(group);

                        Navigator.pushNamed(context, '/groupVault');
                      },
                      child: Card(
                        color: Colors.lightGreen[100],
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        child: ListTile(
                          title: Text(
                            group['name'],
                            style: const TextStyle(
                                fontSize: 18, color: Colors.black),
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios,
                              color: Colors.black),
                        ),
                      ),
                    );
                  },
                ),
      bottomNavigationBar: CustomBottomNavigationBar(
        parentContext: context,
        currentIndex: 1,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightGreen[100],
        onPressed: showCreateGroupDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert'; // For encoding and decoding JSON
// import 'package:state_secret/components/navbar.dart';
// import 'package:state_secret/services/groupVaultService.dart';

// class GroupListScreen extends StatefulWidget {
//   const GroupListScreen({Key? key}) : super(key: key);

//   @override
//   _GroupListScreenState createState() => _GroupListScreenState();
// }

// class _GroupListScreenState extends State<GroupListScreen> {
//   List<dynamic> groupVaults = [];
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     fetchGroupVaults();
//   }

//   Future<void> fetchGroupVaults() async {
//     final service = GroupVaultService();
//     final userId = "6749954e5c6f1e3fc91d100f"; // Replace with actual userId
//     final response = await service.getUserVaults(userId);

//     if (response['success']) {
//       setState(() {
//         groupVaults = response['userVaults'];
//         isLoading = false;
//       });
//     } else {
//       setState(() {
//         isLoading = false;
//       });
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text(response['message'])),
//       );
//     }
//   }

//   Future<void> saveGroupToSharedPreferences(Map<String, dynamic> group) async {
//     final prefs = await SharedPreferences.getInstance();
//     print(group);
//     prefs.setString('selectedGroup', jsonEncode(group)); // Save as a JSON string
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Group List',
//           style: TextStyle(color: Colors.black),
//         ),
//         backgroundColor: Colors.white,
//       ),
//       body: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : groupVaults.isEmpty
//               ? const Center(child: Text('No groups found'))
//               : ListView.builder(
//                   itemCount: groupVaults.length,
//                   itemBuilder: (context, index) {
//                     final group = groupVaults[index];
//                     print(groupVaults);
//                     return GestureDetector(
//                       onTap: () async {
//                         await saveGroupToSharedPreferences(group);

//                         Navigator.pushNamed(context, '/groupVault');
//                       },
//                       child: Card(
//                         margin: const EdgeInsets.symmetric(
//                             vertical: 8, horizontal: 16),
//                         elevation: 3,
//                         child: ListTile(
//                           title: Text(
//                             group['name'],
//                             style: const TextStyle(
//                                 fontSize: 18, color: Colors.black),
//                           ),
//                           trailing: const Icon(Icons.arrow_forward_ios,
//                               color: Colors.black),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//       bottomNavigationBar: CustomBottomNavigationBar(
//         parentContext: context,
//         currentIndex: 1,
//       ),
//     );
//   }
// }
