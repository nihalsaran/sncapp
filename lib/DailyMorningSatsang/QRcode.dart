import 'package:flutter/material.dart';
import 'package:sncapp/pages/home_page.dart';

void main() {
  runApp(Page1(groupName: "YourGroupName", documentId: "YourDocumentId"));
}

class Page1 extends StatelessWidget {
  final String groupName;
  final String documentId;

  const Page1({Key? key, required this.groupName, required this.documentId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Face Recognition',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(title: 'Flutter Face Recognition', groupName: groupName, documentId: documentId),
    );
  }
}
