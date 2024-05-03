import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Page2(),
      ),
    );
  }
}

class Page2 extends StatefulWidget {
  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  List<Map<String, dynamic>> users = [];
  Map<String, bool> checkboxValues = {};

  @override
  void initState() {
    super.initState();
    fetchCurrentUserLocation();
  }


  Future<void> fetchCurrentUserLocation() async {
    // Get current user
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Retrieve user document from Firestore
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      // Get user's location
      String? currentUserLocation = userDoc['location'];

      if (currentUserLocation != null) {
        // Fetch users' data based on the user's location
        QuerySnapshot branchDataSnapshot = await FirebaseFirestore.instance
            .collection('BranchData')
            .doc(currentUserLocation)
            .collection('Satsangis')
            .get();

        // Update the list with data from Satsangis collection
        setState(() {
          users = branchDataSnapshot.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data() as Map<String, dynamic>;
            return {
              'firstName': data['firstName'] ?? '',
              'middleName': data['middleName'] ?? '',
              'lastName': data['lastName'] ?? '',
              'id': data['id'] ?? '',
              'location': data['location'] ?? '',
            };
          }).toList();
        });
      }
    }
  }

 @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        final userId = user['id'];
        return ListTile(
          leading: CircleAvatar(
            child: Text('${user['id']}'),
          ),
          title: Text(
            '${user['firstName']} ${user['middleName']} ${user['lastName']}',
          ),
          subtitle: Text(user['location']),
          trailing: Checkbox(
            value: checkboxValues[userId] ?? false,
            onChanged: (value) {
              setState(() {
                checkboxValues[userId] = value ?? false;
              });
            },
          ),
        );
      },
    );
  }
}