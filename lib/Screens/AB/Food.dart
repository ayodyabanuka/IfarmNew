import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:ifarm/Screens/AB/bucket.dart';
import 'package:ifarm/Screens/AB/data.dart';
import 'package:ifarm/functions/firebaseFunctions.dart';

class foodbuckets extends StatefulWidget {
  foodbuckets({Key? key}) : super(key: key);

  @override
  State<foodbuckets> createState() => _foodbucketsState();
}

String name = "";

final firebasedatalist = FirebaseDatabase.instance;
var getResult = 'QR Code Result';
List buckets = [];

class _foodbucketsState extends State<foodbuckets> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> bucketref =
        FirebaseFirestore.instance.collection('buckets').snapshots();

    return Scaffold(
      backgroundColor: const Color(0xff024F8E),
      appBar: AppBar(
        backgroundColor: const Color(0xff024F8E),
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Food',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 40),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
                child: StreamBuilder<QuerySnapshot>(
              stream: bucketref,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                final storedata = [];
                snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map a = document.data() as Map<String, dynamic>;
                  storedata.add(a);
                }).toList();

                return storedata[0]['Buckets'].isEmpty
                    ? const Center(
                        child: Text(
                        'Add bucket',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ))
                    : ListView.builder(
                        itemCount: storedata[0]['Buckets'].length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => datafromfirebase(
                                            bucketId: storedata[0]['Buckets']
                                                [index],
                                          )));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15)),
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 25),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Bucket :',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(storedata[0]['Buckets'][index],
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 15))
                                      ]),
                                  const Icon(
                                    Icons.arrow_right,
                                    color: Colors.black,
                                  )
                                ],
                              ),
                            ),
                          );
                        });
              },
            ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          scanQRCode();
        },
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.add,
          color: Color(0xff024F8E),
        ),
      ),
    );
  }

  void scanQRCode() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);

      if (!mounted) return;

      setState(() {
        getResult = qrCode;
        if (buckets.contains(qrCode) || qrCode == '-1') {
        } else {
          buckets.add(qrCode);
          saveQRCodes();
        }
      });
      print("QRCode_Result:-");
      print(qrCode);
    } on PlatformException {
      getResult = 'Failed to scan QR Code.';
    }
  }

  saveQRCodes() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        name = user.displayName.toString();
      });
    }
    FirestoreServices.savefoodbuckets(buckets, name);
  }
}
