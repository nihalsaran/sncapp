import 'package:flutter/material.dart';
import 'package:sncapp/pages/camera_page.dart';
import 'package:sncapp/widget/name_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title, required this.groupName, required this.documentId}) : super(key: key);
  final String title;
  final String groupName;
  final String documentId;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
            child: SizedBox(
              width: 100,
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                      context: context, builder: (_) => const NameDialog());
                },
                child: const Text('Add'),
              ),
            ),
          ),
          Center(
            child: SizedBox(
              width: 100,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CameraPage(
                        isAdd: false,
                        groupName: widget.groupName,
                        documentId: widget.documentId,
                      ),
                    ),
                  );
                },
                child: const Text('Detect'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
