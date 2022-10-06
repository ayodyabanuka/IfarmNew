import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class profile extends StatefulWidget {
  profile({Key? key}) : super(key: key);

  @override
  State<profile> createState() => _profileState();
}

String name = "";
String email = "";

class _profileState extends State<profile> {
  @override
  void initState() {
    getuserData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          const Center(
              child: Text(
            'Profile',
            style: TextStyle(
                color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
          )),
          const SizedBox(
            height: 70,
          ),
          Row(
            children: [
              const SizedBox(
                width: 100,
                child: Text(
                  'Username: ',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: Text(
                  name,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const SizedBox(
                width: 100,
                child: Text(
                  'Email: ',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: Text(
                  email,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void getuserData() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Name, email address, and profile photo URL
      setState(() {
        name = user.displayName.toString();
        email = user.email.toString();
      });
    }
  }
}
