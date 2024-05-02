import 'package:flutter/material.dart';
import 'package:sncapp/Satsang.dart';
import 'package:sncapp/Settings.dart';
import 'package:sncapp/MemberList.dart';

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
                // Navigate to Home page
                Navigator.pop(context);
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
          ],
        ),
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
