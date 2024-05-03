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
        body: Page2(
            documentId: 'Default Document Id', groupName: 'Default Group Name'),
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
  List<Map<String, dynamic>> users = [];
  Map<String, bool> checkboxValues = {};
  bool anyCheckboxChecked = false;
  bool buttonEnabled = true;
  bool submitted = false;

  @override
  void initState() {
    super.initState();
    fetchCurrentUserLocation();
  }

  Future<void> fetchCurrentUserLocation() async {
    // Fetch user's location from Firestore
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

        // Load submission status
        loadSubmissionStatus();
      }
    }
  }

  void _handleCheckboxChange(String userId, bool value) {
    setState(() {
      checkboxValues[userId] = value;
      anyCheckboxChecked = checkboxValues.containsValue(true);
    });
  }

  Future<void> _saveSelectedUsers() async {
    // Get current timestamp
    Timestamp timestamp = Timestamp.now();

    // Filter checked users
    List<Map<String, dynamic>> selectedUsers =
        users.where((user) => checkboxValues[user['id']] ?? false).toList();

    // Prepare data for submission
    List<Map<String, dynamic>> dataToSubmit = selectedUsers.map((user) {
      return {
        'name':
            '${user['firstName']} ${user['middleName']} ${user['lastName']}',
        'timestamp': timestamp,
        'submitted': true,
      };
    }).toList();

    // Save checkbox values in the same document where data is being submitted

    // Submit data and update submission status in Firestore
    await FirebaseFirestore.instance
        .collection('Groups')
        .doc(widget.groupName)
        .collection(widget.groupName)
        .doc(widget.documentId)
        .set({
      'data': dataToSubmit,
      'checkboxValues': checkboxValues,
    });

    // Show a snackbar or any other notification that data is saved
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Data Saved Successfully')),
    );

    // Disable button after saving data
    setState(() {
      buttonEnabled = false;
    });
  }

  void loadSubmissionStatus() {
    FirebaseFirestore.instance
    .collection('Groups')
    .doc(widget.groupName)
    .collection(widget.groupName)
    .doc(widget.documentId)
    .get()
    .then((snapshot) {
  if (snapshot.exists) {
    var data = snapshot.data();
    if (data != null && data.containsKey('data')) {
      var dataArray = data['data'] as List?;
      if (dataArray != null && dataArray.isNotEmpty) {
        var firstItem = dataArray.first as Map<String, dynamic>?;
        if (firstItem != null && firstItem.containsKey('submitted')) {
          setState(() {
            submitted = firstItem['submitted'];
            buttonEnabled = !submitted;
          });
        }
      }
    }
  }
});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Users'),
        actions: anyCheckboxChecked && buttonEnabled
            ? [
                TextButton(
                  onPressed: _saveSelectedUsers,
                  child: Text(
                    'SAVE',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ]
            : null,
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
              onChanged: buttonEnabled
                  ? (value) {
                      _handleCheckboxChange(userId, value ?? false);
                    }
                  : null,
            ),
          );
        },
      ),
    );
  }
}