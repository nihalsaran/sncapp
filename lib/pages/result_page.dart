import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sncapp/model/detect_response.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({
    Key? key,
    required this.data,
    required this.groupName,
    required this.documentId,
  }) : super(key: key);

  final DetectResponse data;
  final String groupName;
  final String documentId;

  @override
  Widget build(BuildContext context) {
    // Store the name under the specified document in Firestore
    FirebaseFirestore.instance
        .collection('Groups') // Assuming 'Groups' is your top-level collection
        .doc(groupName) // Specific group document based on groupName
        .collection(groupName) // Subcollection under the group document
        .doc(documentId) // Specific document within the subcollection
        .set({
          'name': data.name,
          // You can add other fields if needed
        })
        .then((value) {
          print('Name added to Firestore under $documentId!');
        })
        .catchError((error) {
          print('Failed to add name to Firestore under $documentId: $error');
        });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Result'),
      ),
      body: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Name: ${data.name}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Gender: ${data.gender}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Group Name: $groupName',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Document ID: $documentId',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
