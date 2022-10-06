import 'package:flutter/material.dart';
import 'package:ifarm/Screens/AB/SplashScreen.dart';

class networkError extends StatefulWidget {
  networkError({Key? key}) : super(key: key);

  @override
  State<networkError> createState() => _networkErrorState();
}

class _networkErrorState extends State<networkError> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Color(0xffE2E7ED),
      ),
      body: Container(
        color: Color(0xffE2E7ED),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/error.jpg',
              scale: 1,
            ),
            const Text(
              'No Connection!',
              style: TextStyle(
                  color: Color.fromARGB(255, 70, 70, 70), fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => splashScreen()));
              },
              child: Container(
                decoration: BoxDecoration(
                    color: const Color(0xffFEC427),
                    borderRadius: BorderRadius.circular(15)),
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                child: Text('Try Again'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
