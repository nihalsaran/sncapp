import 'package:flutter/material.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Page1 extends StatefulWidget {
  final String documentId;
  final String groupName;

  Page1({required this.documentId, required this.groupName});

  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  String? _scannedAttendanceId;
  String? _personName;
  String? _initiationStatus;
  String? _location;
  String? _middleName;
  String? _satsangUID;
  String? _id;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _scanAttendance() async {
  try {
    final result = await BarcodeScanner.scan();
    final qrCodeId = result.rawContent;

    // Get the current user's location
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      String? currentUserLocation = userDoc['location'];

      // Check if the QR code is linked to a person
      final personSnapshot = await _firestore
          .collection('BranchData')
          .doc(currentUserLocation)
          .collection('Satsangis')
          .where('qrCodeId', isEqualTo: qrCodeId)
          .limit(1)
          .get();

      if (personSnapshot.docs.isNotEmpty) {
        final personData = personSnapshot.docs.first.data();
        setState(() {
          _scannedAttendanceId = qrCodeId;
          _personName = personData['name'];
        });

        // Submit the attendance to Firestore
        await _submitAttendance(_scannedAttendanceId, _personName);
      } else {
        setState(() {
          _scannedAttendanceId = qrCodeId;
          _personName = 'No person found';
        });
      }

      // Display the details for 3 seconds
      await Future.delayed(const Duration(seconds: 3));

      // Reset the state
      setState(() {
        _scannedAttendanceId = null;
        _personName = null;
      });
    }
  } catch (e) {
    setState(() {
      _scannedAttendanceId = 'Error: $e';
    });
  }
}

  Future<void> _submitAttendance(String? attendanceId, String? personName) async {
    if (attendanceId != null && personName != null) {
      // Add the attendance record to Firestore
      await FirebaseFirestore.instance
          .collection('Groups')
          .doc(widget.groupName)
          .collection(widget.groupName)
          .doc(widget.documentId)
          .set({
        'data': FieldValue.arrayUnion([
          {
            'name': personName,
            'timestamp': Timestamp.now(),
          }
        ])
      }, SetOptions(merge: true));

      print('Attendance marked for $personName (Attendance ID: $attendanceId)');
    }
  }

  Future<void> _linkQRCodeToPerson() async {
    final firstNameController = TextEditingController();
    final idController = TextEditingController();
    final initiationStatusController = TextEditingController();
    final lastNameController = TextEditingController();
    final locationController = TextEditingController();
    final middleNameController = TextEditingController();
    final satsangUIDController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Link QR Code to Person'),
          content: Column(
            children: [
              TextField(
                controller: firstNameController,
                decoration: const InputDecoration(
                  hintText: 'Enter first name',
                ),
              ),
              TextField(
                controller: idController,
                decoration: const InputDecoration(
                  hintText: 'Enter ID',
                ),
              ),
              TextField(
                controller: initiationStatusController,
                decoration: const InputDecoration(
                  hintText: 'Enter initiation status',
                ),
              ),
              TextField(
                controller: lastNameController,
                decoration: const InputDecoration(
                  hintText: 'Enter last name',
                ),
              ),
              TextField(
                controller: locationController,
                decoration: const InputDecoration(
                  hintText: 'Enter location',
                ),
              ),
              TextField(
                controller: middleNameController,
                decoration: const InputDecoration(
                  hintText: 'Enter middle name',
                ),
              ),
              TextField(
                controller: satsangUIDController,
                decoration: const InputDecoration(
                  hintText: 'Enter satsang UID',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                final firstName = firstNameController.text.trim();
                final id = idController.text.trim();
                final initiationStatus = initiationStatusController.text.trim();
                final lastName = lastNameController.text.trim();
                final location = locationController.text.trim();
                final middleName = middleNameController.text.trim();
                final satsangUID = satsangUIDController.text.trim();

                if (firstName.isNotEmpty &&
                    id.isNotEmpty &&
                    initiationStatus.isNotEmpty &&
                    lastName.isNotEmpty &&
                    location.isNotEmpty &&
                    middleName.isNotEmpty &&
                    satsangUID.isNotEmpty) {
                  setState(() {
                    _personName = '$firstName $middleName $lastName';
                    _initiationStatus = initiationStatus;
                    _location = location;
                    _middleName = middleName;
                    _satsangUID = satsangUID;
                    _id = id;
                  });

                  // Scan the QR code and link it to the person
                  await _scanQRCodeAndLink();
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Link'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _scanQRCodeAndLink() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      String? currentUserLocation = userDoc['location'];
      try {
        final result = await BarcodeScanner.scan();
        final qrCodeId = result.rawContent;

        // Check if the required fields are not null
        if (_personName != null &&
            _initiationStatus != null &&
            _location != null &&
            _middleName != null &&
            _satsangUID != null &&
            _id != null && currentUserLocation != null) {
          // Add the person-QR code link to Firestore
          await _firestore.collection('BranchData').doc(currentUserLocation).collection('Satsangis').doc(_personName).set({
            'name': _personName,
            'qrCodeId': qrCodeId,
            'initiationStatus': _initiationStatus,
            'location': _location,
            'middleName': _middleName,
            'satsangUID': _satsangUID,
            'id': _id
          });

          print('QR code ($qrCodeId) linked to $_personName');
        } else {
          print('Error: Some required fields are missing.');
        }
      } catch (e) {
        print('Error scanning QR code: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page 1'),
        actions: [
          IconButton(
            onPressed: _scanAttendance,
            icon: const Icon(Icons.qr_code_scanner),
          ),
          IconButton(
            onPressed: _linkQRCodeToPerson,
            icon: const Icon(Icons.person_add),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_scannedAttendanceId != null)
              Text(
                'Scanned Attendance ID: $_scannedAttendanceId',
                style: const TextStyle(fontSize: 18.0),
              ),
            if (_personName != null)
              Text(
                'Linked to: $_personName',
                style: const TextStyle(fontSize: 18.0),
              ),
          ],
        ),
      ),
    );
  }
}