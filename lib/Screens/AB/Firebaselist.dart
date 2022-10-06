import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class firebaselist extends StatefulWidget {
  firebaselist({Key? key}) : super(key: key);

  @override
  State<firebaselist> createState() => _firebaselistState();
}

class _firebaselistState extends State<firebaselist> {
  final firebasedatalist = FirebaseDatabase.instance;

  @override
  Widget build(BuildContext context) {
    Query ref = firebasedatalist.ref().child('Food');

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Device',
            style: TextStyle(
              fontSize: 30,
            ),
          ),
          backgroundColor: Colors.indigo[900],
        ),
        body: FirebaseAnimatedList(
            query: ref,
            itemBuilder: (context, snapshot, animation, index) {
              return GestureDetector(
                onTap: () {},
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      tileColor: Colors.indigo[100],
                      trailing: IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red[900],
                        ),
                        onPressed: () {
                          firebasedatalist
                              .ref()
                              .child('Food')
                              .child(snapshot.key!)
                              .remove();
                        },
                      ),
                      title: Text(
                        snapshot.key.toString(),
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }));
  }
}
