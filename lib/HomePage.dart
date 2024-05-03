import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
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
  List<String> groups = []; // Updated to fetch from Firestore
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    fetchGroups(); // Call the method to fetch groups when the screen initializes
  }

  Future<void> fetchGroups() async {
    try {
      // Fetch groups from Firestore
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance.collection('Groups').get();
      
      // Extract document names and update the groups list
      List<String> fetchedGroups = [];
      querySnapshot.docs.forEach((doc) {
        fetchedGroups.add(doc.id);
      });

      setState(() {
        groups = fetchedGroups;
      });
    } catch (e) {
      print("Error fetching groups: $e");
      // Handle error appropriately, like showing a message to the user
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
                  // Navigate to MemberListPage
                  context,
                  MaterialPageRoute(builder: (context) => MemberList()),
                );
              },
            ),
            // Other list tiles remain the same
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
                // Navigation logic remains the same
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
