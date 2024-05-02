import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sncapp/HomePage.dart';
import 'package:sncapp/Settings.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MemberList());
}

class MemberList extends StatefulWidget {
  @override
  State<MemberList> createState() => _MemberListState();
}

class _MemberListState extends State<MemberList> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Members List',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MembersListScreen(),
    );
  }
}

class MembersListScreen extends StatefulWidget {
  @override
  State<MembersListScreen> createState() => _MembersListScreenState();
}

class _MembersListScreenState extends State<MembersListScreen> {
  late Stream<QuerySnapshot> _membersStream;
  int _selectedIndex = 1;

  @override
  void initState() {
    super.initState();
    _membersStream = FirebaseFirestore.instance.collection('BranchData').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Members List',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.white,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.replay,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            onPressed: () {
              // Add search functionality
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(
                "John Doe",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              accountEmail: Text(""),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  "JD",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.green,
              ),
            ),
            ListTile(
              leading: Icon(Icons.home,
                  color: _selectedIndex == 0 ? Colors.green : null),
              title: Text(
                'Home',
                style: TextStyle(
                    color: _selectedIndex == 0 ? Colors.green : null,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () {
                setState(() {
                  _selectedIndex = 0;
                });
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  // Navigate to HomePage
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.person,
                  color: _selectedIndex == 1 ? Colors.green : null),
              title: Text(
                'Member List',
                style: TextStyle(
                    color: _selectedIndex == 1 ? Colors.green : null,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () {
                setState(() {
                  _selectedIndex = 1;
                });
                Navigator.pop(context); // Close the drawer
                // Already on the MemberList page
              },
            ),
            ListTile(
              leading: Icon(Icons.list_alt,
                  color: _selectedIndex == 2 ? Colors.green : null),
              title: Text(
                'Local Attendance',
                style: TextStyle(
                    color: _selectedIndex == 2 ? Colors.green : null,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () {
                setState(() {
                  _selectedIndex = 2;
                });
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  // Navigate to SettingsPage
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.list_alt,
                  color: _selectedIndex == 3 ? Colors.green : null),
              title: Text(
                "Today's Attendance Split",
                style: TextStyle(
                    color: _selectedIndex == 3 ? Colors.green : null,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () {
                setState(() {
                  _selectedIndex = 3;
                });
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  // Navigate to SettingsPage
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.group,
                  color: _selectedIndex == 4 ? Colors.green : null),
              title: Text(
                'Visitor Management',
                style: TextStyle(
                    color: _selectedIndex == 4 ? Colors.green : null,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () {
                setState(() {
                  _selectedIndex = 4;
                });
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  // Navigate to SettingsPage
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.web,
                  color: _selectedIndex == 5 ? Colors.green : null),
              title: Text(
                'Hazari Web',
                style: TextStyle(
                    color: _selectedIndex == 5 ? Colors.green : null,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () {
                setState(() {
                  _selectedIndex = 5;
                });
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  // Navigate to SettingsPage
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.settings,
                  color: _selectedIndex == 6 ? Colors.green : null),
              title: Text(
                'Settings',
                style: TextStyle(
                    color: _selectedIndex == 6 ? Colors.green : null,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () {
                setState(() {
                  _selectedIndex = 6;
                });
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  // Navigate to SettingsPage
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              },
            ),
            // Add a Divider after Settings
            Divider(
              color: Colors.grey,
            ),
            // Add Assistance title
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                'Assistance',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Add Tutorials list item
            ListTile(
              leading: Icon(Icons.menu_book,
                  color: _selectedIndex == 7 ? Colors.green : null),
              title: Text(
                'Tutorials',
                style: TextStyle(
                    color: _selectedIndex == 7 ? Colors.green : null,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () {
                setState(() {
                  _selectedIndex = 7;
                });
                // Add navigation logic here
              },
            ),
            // Add other menu items as needed
          ],
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
  stream: _membersStream,
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return Center(child: CircularProgressIndicator());
    } else if (snapshot.hasError) {
      return Center(child: Text('Error: ${snapshot.error}'));
    } else {
      return ListView.builder(
        itemCount: snapshot.data!.docs.length,
        itemBuilder: (context, index) {
          final Map<String, dynamic> memberData = snapshot.data!.docs[index].data() as Map<String, dynamic>;
          final String firstName = memberData['firstName'] ?? '';
          final String middleName = memberData['middleName'] ?? '';
          final String lastName = memberData['lastName'] ?? '';

          return ListTile(
            leading: CircleAvatar(
              child: Icon(Icons.person),
            ),
            title: Text('$firstName $middleName $lastName'),
            subtitle: Text('Bolarum (ARSA)'),
          );
        },
      );
    }
  },
),
    );
  }
}
