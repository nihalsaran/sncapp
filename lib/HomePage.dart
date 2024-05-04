import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sncapp/MemberList.dart';
import 'package:sncapp/Satsang.dart';
import 'package:sncapp/AttandanceSplit.dart';
import 'package:sncapp/Settings.dart';
import 'package:sncapp/LocalAttandance.dart';

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
  List<String> groups = [];
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    fetchGroups();
  }

  Future<void> fetchGroups() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance.collection('Groups').get();

      List<String> fetchedGroups = [];
      querySnapshot.docs.forEach((doc) {
        fetchedGroups.add(doc.id);
      });

      setState(() {
        groups = fetchedGroups;
      });
    } catch (e) {
      print("Error fetching groups: $e");
    }
  }

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
                  MaterialPageRoute(
                      builder: (context) => LocalAttandancePage()),
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
                  context,
                  MaterialPageRoute(
                      builder: (context) => AttandanceSplitPage()),
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
        itemCount: groups.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
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
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Select Location'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildPlaceTile('Place 1', context, 0),
                            _buildPlaceTile('Place 2', context, 1),
                            _buildPlaceTile('Place 3', context, 2),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            );
          } else {
            return ListTile(
              title: Text(groups[index - 1]),
              trailing: Icon(Icons.download),
              onTap: () {
                // Debug statement to check if onTap is triggered
                print("Tapped on group: ${groups[index - 1]}");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        SatsangPage(groupName: groups[index - 1]),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildPlaceTile(String placeName, BuildContext context, int index) {
    return ListTile(
      title: Text(placeName),
      onTap: () {
        print("Tapped on tile at index $index");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SatsangPage(groupName: groups[index]),
          ),
        );
      },
    );
  }
}
