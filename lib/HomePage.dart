import 'package:flutter/material.dart';
import 'package:sncapp/Satsang.dart';
import 'package:sncapp/Sidedrawer.dart';
import 'package:sncapp/Settings.dart';

void main() {
  runApp(HomePage());
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Your Groups',
      home: GroupsScreen(),
       routes: {
    '/settings': (context) => SettingsPage(), // Replace SettingsPage with your actual settings page widget
  },
    );
  }
}

class GroupsScreen extends StatefulWidget {
  @override
  _GroupsScreenState createState() => _GroupsScreenState();
}

class _GroupsScreenState extends State<GroupsScreen> {
  final List<String> groups = [
    'MPG Activities',
    'Sant (Su)perman Activities',
    'Sant(Su)perman Activities (MPG)',
    'Satsang',
    'Youth Association Activities',
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Groups',
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
      ),
      drawer: CustomDrawer( // Pass the context here
        context: context,
        selectedIndex: _selectedIndex,
        onItemSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
          // Handle navigation here based on the index
          // For now, let's leave it empty
        },
      ),
        body: ListView.builder(
        itemCount: groups.length + 1, // Add 1 for "Update Location"
        itemBuilder: (context, index) {
          if (index == 0) {
            // Return the "Update Location" ListTile
            return Container(
              color: Color.fromRGBO(255, 68, 0, 1),
              padding: EdgeInsets.symmetric(vertical: 1.0),
              child: ListTile(
                title: Center(
                  child: Text(
                    'Update Location',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                onTap: () {
                  // Show dialog with selectable places
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Select Location'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildPlaceTile('Place 1', context),
                            _buildPlaceTile('Place 2', context),
                            _buildPlaceTile('Place 3', context),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            );
          } else {
            // Return ListTile for each group
            return ListTile(
              title: Text(groups[index - 1]),
              trailing: Icon(Icons.download),
              onTap: () {
                // Handle navigation for each group
                switch (index - 1) {
                  case 0:
                    // Navigation logic for MPG Activities
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MPGActivitiesPage()),
                    );
                    break;
                  case 1:
                    // Navigation logic for Sant (Su)perman Activities
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SantSupermanActivitiesPage()),
                    );
                    break;
                  case 2:
                    // Navigation logic for Sant(Su)perman Activities (MPG)
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SantSupermanMPGActivitiesPage()),
                    );
                    break;
                  case 3:
                    // Navigation logic for Satsang
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SatsangPage()),
                    );
                    break;
                  case 4:
                    // Navigation logic for Youth Association Activities
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              YouthAssociationActivitiesPage()),
                    );
                    break;
                  default:
                }
              },
            );
          }
        },
      ),
    );
  }

  // Function to build a ListTile for each place
  Widget _buildPlaceTile(String placeName, BuildContext context) {
    return ListTile(
      title: Text(placeName),
      onTap: () {
        // Handle tap on each place
        Navigator.pop(context); // Close the dialog
        // Add logic to handle selection of each place
      },
    );
  }
}

// Define other pages here
class MPGActivitiesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MPG Activities'),
      ),
      body: Center(
        child: Text('This is the MPG Activities Page'),
      ),
    );
  }
}

class SantSupermanActivitiesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sant (Su)perman Activities'),
      ),
      body: Center(
        child: Text('This is the Sant (Su)perman Activities Page'),
      ),
    );
  }
}

class SantSupermanMPGActivitiesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sant(Su)perman Activities (MPG)'),
      ),
      body: Center(
        child: Text('This is the Sant(Su)perman Activities (MPG) Page'),
      ),
    );
  }
}

class YouthAssociationActivitiesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Youth Association Activities'),
      ),
      body: Center(
        child: Text('This is the Youth Association Activities Page'),
      ),
    );
  }
}
 