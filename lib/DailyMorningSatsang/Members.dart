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
          documentId: 'Default_Document_Id',
          groupName: 'Default_Group_Name',
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
  late Map<String, bool> submissionStatus;

  @override
  void initState() {
    super.initState();
    users = [];
    checkboxValues = {};
    submissionStatus = {};
    fetchCurrentUserLocation();
    initializeSharedPreferences();
  }

  Future<void> initializeSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    loadCheckboxValues();
  }

  Future<void> loadCheckboxValues() async {
    setState(() {
      checkboxValues = Map.fromIterable(
        users,
        key: (user) => user['id'],
        value: (user) =>
            prefs.getBool('${widget.documentId}_${user['id']}_checkbox') ??
            false,
      );
      submissionStatus = Map.fromIterable(
        users,
        key: (user) => user['id'],
        value: (user) =>
            prefs.getBool('${widget.documentId}_${user['id']}_submitted') ??
            false,
      );
    });
  }

  void saveCheckboxValue(String userId, bool value) {
    prefs.setBool('${widget.documentId}_${userId}_checkbox', value);
  }

  Future<void> saveSubmissionStatus(String userId, bool value) async {
    await prefs.setBool('${widget.documentId}_${userId}_submitted', value);
  }

  void deleteSharedPreferences() async {
    await prefs.clear();
    setState(() {
      checkboxValues.clear();
      submissionStatus.clear();
    });
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

  Future<void> _handleCheckboxChange(String userId, bool? value) async {
    setState(() {
      checkboxValues[userId] = value ?? false;
    });
    saveCheckboxValue(userId, value ?? false);
  }

  Future<void> _saveSelectedUsers() async {
    // Get current timestamp
    Timestamp timestamp = Timestamp.now();

    // Filter checked users
    List<Map<String, dynamic>> selectedUsers =
        users.where((user) => checkboxValues[user['id']] ?? false).toList();

    // Filter out already submitted users
    selectedUsers = selectedUsers
        .where((user) => !(submissionStatus[user['id']] ?? false))
        .toList();

    // Check if any user is selected before saving data
    if (selectedUsers.isNotEmpty) {
      // Prepare data for submission
      List<Map<String, dynamic>> dataToSubmit = selectedUsers.map((user) {
        return {
          'name':
              '${user['firstName']} ${user['middleName']} ${user['lastName']}',
          'timestamp': timestamp,
        };
      }).toList();

      // Submit data to Firestore
      await FirebaseFirestore.instance
          .collection('Groups')
          .doc(widget.groupName)
          .collection(widget.groupName)
          .doc(widget.documentId)
          .set({
        'data': FieldValue.arrayUnion(dataToSubmit),
      }, SetOptions(merge: true));

      // Update submission status for newly submitted users
      for (var user in selectedUsers) {
        await saveSubmissionStatus(user['id'], true);
      }

      // Show a snackbar or any other notification that data is saved
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Data Saved Successfully')),
      );

      // Refresh UI to disable checkboxes and save button after saving
      setState(() {
        for (var user in selectedUsers) {
          submissionStatus[user['id']] = true;
        }
      });
    } else {
      // Show an error message if no user is selected
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select at least one new user')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    bool showSaveButton = false;

    for (var entry in checkboxValues.entries) {
      final userId = entry.key;
      final isChecked = entry.value;
      final isSubmitted = submissionStatus[userId] ?? false;

      if (isChecked && !isSubmitted) {
        showSaveButton = true;
        break;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Select Users'),
        actions: [
          if (showSaveButton)
            TextButton(
              onPressed: () async {
                await _saveSelectedUsers();
                setState(() {
                  // Disable save button after successful submission
                  showSaveButton = false;
                });
              },
              child: Text(
                'SAVE',
                style: TextStyle(color: Colors.black),
              ),
            ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: deleteSharedPreferences,
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
              child: Text(
                '${user['id']}',
                style:
                    TextStyle(fontSize: 12), // Adjust the font size as needed
              ),
            ),
            title: Text(
              '${user['firstName']} ${user['middleName']} ${user['lastName']}',
            ),
            subtitle: Text(user['location']),
            trailing: Checkbox(
              onChanged: submissionStatus[userId] ?? false
                  ? null
                  : (value) {
                      _handleCheckboxChange(userId, value);
                    },
              value: checkboxValues[userId] ?? false,
            ),
          );
        },
      ),
    );
  }
}
