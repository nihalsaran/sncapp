import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore package

void main() {
  runApp(SatsangPage(groupName: "Default Group Name"));
}

class SatsangPage extends StatelessWidget {
  final String groupName;

  SatsangPage({required this.groupName});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: groupName, // Set the title to the groupName
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: SatsangScreen(groupName: groupName), // Pass groupName to SatsangScreen
    );
  }
}

class SatsangScreen extends StatefulWidget {
  final String groupName;

  SatsangScreen({required this.groupName});

  @override
  _SatsangScreenState createState() => _SatsangScreenState();
}

class _SatsangScreenState extends State<SatsangScreen> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
          },
        ),
        title: Text(
          widget.groupName, // Use groupName in the title
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Groups').doc(widget.groupName).collection(widget.groupName).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator(); // Show loading indicator while fetching data
          }
          return Column(
            children: [
              Container(
                color: Color.fromRGBO(255, 68, 0, 1),
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${selectedDate.day} ${_getMonthName(selectedDate.month)} ${selectedDate.year}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                    SizedBox(width: 8.0),
                    IconButton(
                      icon: Icon(Icons.calendar_today, color: Colors.white),
                      onPressed: () {
                        _selectDate(context);
                      },
                    ),
                  ],
                ),
              ),
              // Display document names
              ListView(
                shrinkWrap: true,
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  return ListTile(
                    title: Text(document.id),
                    // Handle onTap for each document
                    onTap: () {
                      // Example: Navigate to a detail screen passing the document id
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DetailScreen(documentId: document.id)),
                      );
                    },
                  );
                }).toList(),
              ),
            ],
          );
        },
      ),
    );
  }

  String _getMonthName(int month) {
    List<String> months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[month - 1];
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: Color.fromRGBO(
                  255, 68, 0, 1), // Set the color to app bar orange
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
}

class DetailScreen extends StatelessWidget {
  final String documentId;

  DetailScreen({required this.documentId});

  @override
  Widget build(BuildContext context) {
    // Implement your detail screen here, using the documentId to fetch additional data if needed
    return Scaffold(
      appBar: AppBar(
        title: Text('Document Details'),
      ),
      body: Center(
        child: Text('Details for document: $documentId'),
      ),
    );
  }
}
