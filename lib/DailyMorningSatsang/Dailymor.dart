import 'package:flutter/material.dart';
import 'package:sncapp/DailyMorningSatsang/QRcode.dart';
import 'package:sncapp/DailyMorningSatsang/Members.dart';
import 'package:sncapp/DailyMorningSatsang/visitors.dart';
import 'package:sncapp/DailyMorningSatsang/guests.dart';

void main() {
  runApp(Dailymorning(documentId: "Default Document Id"));
}

class Dailymorning extends StatefulWidget {
  final String documentId;

  Dailymorning({required this.documentId});

  @override
  _DailymorningState createState() => _DailymorningState();
}

class _DailymorningState extends State<Dailymorning>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: 4, vsync: this); // Increased length to 4
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
          bottom: TabBar(
            controller: _tabController,
            tabs: [
              Tab(text: 'Face'),
              Tab(text: 'Members'),
              Tab(text: 'Visitors'),
              Tab(text: 'Guests'), // Added Tab for the fourth page
            ],
            indicatorColor: Colors.white,
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            Page1(),
            Page2(),
            Page3(),
            Page4(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
