import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Page2(
          documentId: 'Default Document Id',
          groupName: 'Default Group Name',
        ),
      ),
    );
  }
}

class Page2 extends StatefulWidget {
  final String documentId;
  final String groupName;

  Page2({required this.documentId, required this.groupName});

  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  late List<Map<String, dynamic>> users;
  late SharedPreferences prefs;
  late Map<String, bool> checkboxValues;

  @override
  void initState() {
    super.initState();
    users = [];
    checkboxValues = {};
    fetchCurrentUserLocation();
    initializeSharedPreferences();
  }

  Future<void> initializeSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    loadCheckboxValues();
  }

  Future<void> loadCheckboxValues() async {
    setState(() {
      checkboxValues = Map.fromIterable(users,
          key: (user) => user['id'],
          value: (user) => prefs.getBool(user['id'].toString()) ?? false);
    });
  }

  void saveCheckboxValue(String userId, bool value) {
    prefs.setBool(userId, value);
  }

  Future<void> fetchCurrentUserLocation() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      String? currentUserLocation = userDoc['location'];
      if (currentUserLocation != null) {
        QuerySnapshot branchDataSnapshot = await FirebaseFirestore.instance
            .collection('BranchData')
            .doc(currentUserLocation)
            .collection('Satsangis')
            .get();

        setState(() {
          users = branchDataSnapshot.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            return {
              'firstName': data['firstName'] ?? '',
              'middleName': data['middleName'] ?? '',
              'lastName': data['lastName'] ?? '',
              'id': data['id'] ?? '',
              'location': data['location'] ?? '',
            };
          }).toList();
        });

        loadCheckboxValues();
      }
    }
  }

  void _handleCheckboxChange(String userId, bool value) {
    setState(() {
      checkboxValues[userId] = value;
    });
    saveCheckboxValue(userId, value); // Save the checkbox state
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Users'),
        actions: [
          if (checkboxValues.containsValue(true))
            TextButton(
              onPressed: () {},
              child: Text(
                'SAVE',
                style: TextStyle(color: Colors.black),
              ),
            ),
        ],
      ),
      body: ListView.builder(
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
                _handleCheckboxChange(userId, value ?? false);
              },
            ),
          );
        },
      ),
    );
  }
}
