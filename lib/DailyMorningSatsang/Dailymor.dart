import 'package:flutter/material.dart';
import 'package:sncapp/DailyMorningSatsang/QRcode.dart';
import 'package:sncapp/DailyMorningSatsang/Members.dart';
import 'package:sncapp/DailyMorningSatsang/visitors.dart';
import 'package:sncapp/DailyMorningSatsang/guests.dart';

void main() {
  runApp(Dailymorning(documentId: "Default Document Id", groupName: "Default Group Name"));
}

class Dailymorning extends StatefulWidget {
  final String documentId;
  final String groupName;

  Dailymorning({required this.documentId, required this.groupName});

  @override
  _DailymorningState createState() => _DailymorningState();
}

class _DailymorningState extends State<Dailymorning> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '${widget.documentId}',
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            '${widget.documentId}',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.green,
        ),
        body: _getBodyWidget(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
  items: const <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.face),
      label: 'Face',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.people),
      label: 'Members',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.group),
      label: 'Visitors',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Guests',
    ),
  ],
  currentIndex: _selectedIndex,
  selectedItemColor: Colors.green, // Change this to the desired selected item color
  unselectedItemColor: Colors.black, // Change this to the desired unselected item color
  onTap: _onItemTapped,
),
      ),
    );
  }

  Widget _getBodyWidget(int index) {
    switch (index) {
      case 0:
       return Page1(documentId: widget.documentId, groupName: widget.groupName);
      case 1:
        return Page2(documentId: widget.documentId, groupName: widget.groupName);
      case 2:
        return Page3();
      case 3:
        return Page4();
      default:
        return Container();
    }
  }
}
