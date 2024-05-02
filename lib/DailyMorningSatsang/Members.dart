import 'package:flutter/material.dart';

void main() {
  runApp(MembersPage());
}

class MembersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Daily Morning Satsang',
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            'Daily Morning Satsang',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.green,
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  color: Colors.green, // Add green color here
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'QRCODE',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Text('MEMBERS'),
                Text('VISITORS'),
                Text('GUESTS'),
              ],
            ),
            CounterRow(title: 'Initiated Gents'),
            CounterRow(title: 'Initiated Ladies'),
            CounterRow(title: 'Other Gents Above 15'),
            CounterRow(title: 'Other Ladies Above 15'),
            CounterRow(title: 'Children'),
          ],
        ),
      ),
    );
  }
}

class CounterRow extends StatefulWidget {
  final String title;

  CounterRow({required this.title});

  @override
  _CounterRowState createState() => _CounterRowState();
}

class _CounterRowState extends State<CounterRow> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(Icons.remove),
            onPressed: _counter > 0 ? _decrementCounter : null,
          ),
          Text('$_counter'),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _incrementCounter,
          ),
          SizedBox(width: 16),
          Text(widget.title),
        ],
      ),
    );
  }
}
