import 'package:flutter/material.dart';
import 'package:sncapp/HomePage.dart';
import 'package:sncapp/MemberList.dart';

void main() {
  runApp(SettingsPage());
}

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Settings',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: SettingsScreen(),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool useInternet = false;

  int _selectedIndex = 6;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu, color: Colors.white), // Add menu icon
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
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
                  // Navigate to SettingsPage
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
                Navigator.push(
                  // Navigate to SettingsPage
                  context,
                  MaterialPageRoute(builder: (context) => MemberList()),
                );
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
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 40,
                child: Icon(Icons.person, size: 60),
              ),
            ),
            SizedBox(height: 16.0),
            Center(
              child: Text(
                'Duggirala Satyaprasad',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 32.0),
            Text('Sync'),
            SizedBox(height: 32.0),
            Text('UID No-'),
            SizedBox(height: 16.0),
            Text('Logout'),
          ],
        ),
      ),
    );
  }
}
