import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your Groups',
      home: GroupsScreen(),
    );
  }
}

class GroupsScreen extends StatelessWidget {
  final List<String> groups = [
    'MPG Activities',
    'Sant (Su)perman Activities',
    'Sant(Su)perman Activities (MPG)',
    'Satsang',
    'Youth Association Activities',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Groups'),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        itemCount: groups.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(groups[index]),
            trailing: Icon(Icons.arrow_downward),
          );
        },
      ),
    );
  }
}