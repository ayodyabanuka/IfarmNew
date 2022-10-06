import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreServices {
  static saveUser(String name, email) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(name)
        .set({'email': email, 'name': name});
  }

  static savefoodbuckets(foodbucketID, name) async {
    await FirebaseFirestore.instance
        .collection('buckets')
        .doc(name)
        .set({'Buckets': foodbucketID});
  }
}
