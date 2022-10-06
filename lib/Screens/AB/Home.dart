import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ifarm/Screens/AB/Food.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:switcher_button/switcher_button.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

String t = '29';
bool tempgood = true;

bool foodswitch = false;
bool waterswitch = false;
bool environmentswitch = false;
bool securityswitch = false;

class _HomeState extends State<Home> {
  @override
  void initState() {
    getdata();
    super.initState();
  }

  getdata() async {
    print('login');
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var foodswitch1 = localStorage.getBool('food') as bool;
    var waterswitch1 = localStorage.getBool('water') as bool;
    var environmentswitch1 = localStorage.getBool('env') as bool;
    var securityswitch1 = localStorage.getBool('security') as bool;

    setState(() {
      foodswitch = foodswitch1;
      waterswitch1 = waterswitch1;
      environmentswitch = environmentswitch1;
      securityswitch = securityswitch1;
    });
  }

  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff024F8E),
      body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
              ),
              Container(
                width: 150,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Colors.white12,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Temp',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: tempgood ? Colors.green : Colors.red),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Row(
                        children: [
                          Text(
                            t,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 50),
                          ),
                          const Text(
                            '\u2103',
                            style: TextStyle(color: Colors.white, fontSize: 50),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //Food
                      Expanded(
                        child: GestureDetector(
                          onTap: foodswitch
                              ? () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => foodbuckets()));
                                }
                              : null,
                          child: Container(
                            height: 100,
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                color: Colors.white24,
                                borderRadius: BorderRadius.circular(20)),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                FaIcon(
                                  FontAwesomeIcons.bowlFood,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Food',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      //Water
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            print('water');
                          },
                          child: Container(
                            height: 100,
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                color: Colors.white24,
                                borderRadius: BorderRadius.circular(20)),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                FaIcon(
                                  FontAwesomeIcons.water,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Water',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //Env
                      Expanded(
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: 100,
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                color: Colors.white24,
                                borderRadius: BorderRadius.circular(20)),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                FaIcon(
                                  FontAwesomeIcons.fan,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Environment',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      //Security
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            print('water');
                          },
                          child: Container(
                            height: 100,
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                color: Colors.white24,
                                borderRadius: BorderRadius.circular(20)),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                FaIcon(
                                  FontAwesomeIcons.radiation,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Security',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          )),
    );
  }
}
