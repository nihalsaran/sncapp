import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'package:sncapp/DailyMorningSatsang/Members.dart'; // Import the MembersPage.dart file

void main() {
  runApp(SatsangPage());
}

class SatsangPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Satsang',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: SatsangScreen(),
    );
  }
}

class SatsangScreen extends StatefulWidget {
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
                  builder: (context) =>
                      HomePage()), // Navigate to HomePage.dart
            );
          },
        ),
        title: Text(
          'Satsang',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
      body: Theme(
        data: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: Color.fromRGBO(
                255, 68, 0, 1), // set the color for the date picker
          ),
        ),
        child: Column(
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
            ListTile(
              title: Text('Daily Morning Satsang'),
              trailing: Icon(Icons.arrow_drop_down),
              onTap: () {
                // Navigate to MembersPage.dart
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MembersPage()),
                );
              },
            ),
            ListTile(
              title: Text('Daily Evening Satsang'),
              trailing: Icon(Icons.arrow_drop_down),
              onTap: () {
                // Handle onTap for Daily Evening Satsang
              },
            ),
          ],
        ),
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
