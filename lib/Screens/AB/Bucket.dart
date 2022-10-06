import 'package:cloud_firestore/cloud_firestore.dart';

class Bucket {
  final List<String>? bucketId;

  Bucket({this.bucketId});
  factory Bucket.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    return Bucket(
        bucketId:
            data?['Buckets'] is Iterable ? List.from(data?['regions']) : null);
  }
}
