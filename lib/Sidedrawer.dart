import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;
  final BuildContext context; // Add BuildContext as a parameter

  const CustomDrawer({
    Key? key,
    required this.context,
    required this.selectedIndex,
    required this.onItemSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
          _buildDrawerItem(
            icon: Icons.home,
            title: 'Home',
            index: 0,
          ),
          _buildDrawerItem(
            icon: Icons.person,
            title: 'Member List',
            index: 1,
          ),
          _buildDrawerItem(
            icon: Icons.list_alt,
            title: 'Local Attendance',
            index: 2,
          ),
          _buildDrawerItem(
            icon: Icons.list_alt,
            title: "Today's Attendance Split",
            index: 3,
          ),
          _buildDrawerItem(
            icon: Icons.group,
            title: 'Visitor Management',
            index: 4,
          ),
          _buildDrawerItem(
            icon: Icons.web,
            title: 'Hazari Web',
            index: 5,
          ),
          _buildDrawerItem(
            icon: Icons.settings,
            title: 'Settings',
            index: 6,
          ),
          Divider(
            color: Colors.grey,
          ),
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
          _buildDrawerItem(
            icon: Icons.menu_book,
            title: 'Tutorials',
            index: 7,
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required int index,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: selectedIndex == index ? Colors.green : null,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: selectedIndex == index ? Colors.green : null,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: () {
        onItemSelected(index);
        Navigator.pop(context); // Use the context passed from the constructor
      },
    );
  }
}
