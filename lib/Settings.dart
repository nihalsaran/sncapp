import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sncapp/Sidedrawer.dart';

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
  int _selectedIndex = 0;
  
  // Create a GlobalKey for the Scaffold
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Function to toggle the drawer
  void _toggleDrawer() {
    _scaffoldKey.currentState?.openDrawer(); // Use null-aware operator
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Assign the GlobalKey to the Scaffold
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.white), // Add menu icon
          onPressed: _toggleDrawer, // Call _toggleDrawer when icon is pressed
        ),
      ),
      drawer: CustomDrawer(
        context: context,
        selectedIndex: _selectedIndex,
        onItemSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
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
