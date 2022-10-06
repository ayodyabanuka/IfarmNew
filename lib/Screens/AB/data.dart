import 'dart:async';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:switcher_button/switcher_button.dart';

class datafromfirebase extends StatefulWidget {
  String bucketId;
  datafromfirebase({Key? key, required this.bucketId}) : super(key: key);

  @override
  State<datafromfirebase> createState() => _datafromfirebaseState();
}

String d = '100';
String m = '250';
int s = 0;
bool svalue = false;

class _datafromfirebaseState extends State<datafromfirebase> {
  @override
  void initState() {
    super.initState();

    getData();
    runTimer();
    servovalueinbool();
  }

  Timer? timer;
  void runTimer() {
    timer = Timer.periodic(const Duration(seconds: 2), (_) {
      getData();
      servovalueinbool();
    });
  }

  servovalueinbool() {
    if (s == 0) {
      setState(() {
        svalue = false;
      });
    } else {
      setState(() {
        svalue = true;
      });
    }
  }

  getData() {
    FirebaseDatabase.instance
        .ref()
        .child('Food/' + widget.bucketId + '/Moist/foodMoist')
        .onValue
        .listen((event) {
      setState(() {
        m = event.snapshot.value.toString();
      });
    });
    FirebaseDatabase.instance
        .ref()
        .child('Food/' + widget.bucketId + '/SERVO')
        .onValue
        .listen((event) {
      setState(() {
        s = int.parse(event.snapshot.value.toString());
      });
    });
    FirebaseDatabase.instance
        .ref()
        .child('Food/' + widget.bucketId + '/dis')
        .onValue
        .listen((event) {
      setState(() {
        d = event.snapshot.value.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
            timer!.cancel();
          },
        ),
        backgroundColor: const Color(0xff024F8E),
        elevation: 0,
      ),
      backgroundColor: const Color(0xff024F8E),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 40,
            ),
            const Text(
              'Bucket',
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 30,
                  fontFamily: 'poppins',
                  fontWeight: FontWeight.bold),
            ),
            Text(
              widget.bucketId,
              style: const TextStyle(
                color: Color.fromARGB(136, 255, 255, 255),
                fontSize: 25,
                fontFamily: 'poppins',
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 100,
                    width: 310,
                    child: LiquidLinearProgressIndicator(
                      value: double.parse(d) / 300, // Defaults to 0.5.
                      valueColor: AlwaysStoppedAnimation(
                        double.parse(d) >= 70.0 && double.parse(d) <= 90.0
                            ? Colors.green
                            : Colors.red,
                      ),
                      backgroundColor: const Color.fromARGB(255, 255, 255, 255),

                      borderRadius: 20,
                      direction: Axis.vertical,
                      center: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              FaIcon(
                                FontAwesomeIcons.fill,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Food Presentage',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Color.fromARGB(179, 0, 0, 0),
                                  fontFamily: 'poppins',
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                d,
                                style: const TextStyle(
                                    fontSize: 20,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontWeight: FontWeight.bold),
                              ),
                              const Text(
                                '%',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    elevation: 2,
                    color: double.parse(m) == 0 ? Colors.green : Colors.red,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Moisture',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white70,
                              fontFamily: 'poppins',
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                m,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                  fontFamily: 'poppins',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    elevation: 2,
                    color: svalue ? Colors.green : Colors.red,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Food',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white70,
                              fontFamily: 'poppins',
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SwitcherButton(
                                onColor: Colors.white,
                                offColor: Colors.black,
                                value: svalue,
                                onChange: (value) {
                                  setState(() {
                                    svalue = value;

                                    updateone(value);
                                    print(value);
                                  });
                                },
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  updateone(bool val) async {
    final servoref1 = FirebaseDatabase.instance.ref();
    if (val == true) {
      await servoref1.update({
        "Food/" + widget.bucketId + "/SERVO": 1,
      });
    } else {
      await servoref1.update({
        "Food/" + widget.bucketId + "/SERVO": 0,
      });
    }
  }
}
