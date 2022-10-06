import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ifarm/Screens/AB/Login.dart';
import 'package:ifarm/Screens/AB/SplashScreen.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:switcher_button/switcher_button.dart';

class settings extends StatefulWidget {
  settings({
    Key? key,
  }) : super(key: key);

  @override
  State<settings> createState() => _settingsState();
}

bool foodswitch = false;
bool waterswitch = false;
bool environmentswitch = false;
bool securityswitch = false;

class _settingsState extends State<settings> {
  @override
  void initState() {
    getdata();
    // TODO: implement initState
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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          const Center(
              child: Text(
            'Settings',
            style: TextStyle(
                color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
          )),
          const SizedBox(
            height: 70,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                  child: Text(
                'Food Sensors',
                style: TextStyle(color: Colors.white, fontSize: 17),
              )),
              SwitcherButton(
                value: foodswitch,
                onChange: (value) {
                  setState(() {
                    foodswitch = value;

                    save_datafood(value);
                    print(value);
                  });
                },
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                  child: Text(
                'Water Sensors',
                style: TextStyle(color: Colors.white, fontSize: 17),
              )),
              SwitcherButton(
                value: waterswitch,
                onChange: (value) {
                  setState(() {
                    waterswitch = value;

                    save_datawater(value);
                    print(value);
                  });
                },
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                  child: Text(
                'Environment Sensors',
                style: TextStyle(color: Colors.white, fontSize: 17),
              )),
              SwitcherButton(
                value: environmentswitch,
                onChange: (value) {
                  setState(() {
                    environmentswitch = value;

                    save_dataenv(value);
                    print(value);
                  });
                },
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                  child: Text(
                'Security Sensors',
                style: TextStyle(color: Colors.white, fontSize: 17),
              )),
              SwitcherButton(
                value: securityswitch,
                onChange: (value) {
                  setState(() {
                    securityswitch = value;

                    save_datasecurity(value);
                    print(value);
                  });
                },
              )
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          GestureDetector(
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              SharedPreferences localStorage =
                  await SharedPreferences.getInstance();

              localStorage.clear();

              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => splashScreen()),
                  (route) => false);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Expanded(
                        child: Text(
                      'Logout',
                      style: TextStyle(color: Colors.black, fontSize: 17),
                    )),
                    Icon(
                      Icons.logout,
                      color: Colors.red,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void save_datafood(bool value) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setBool('food', value);
    print('save');
  }

  void save_datawater(bool value) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setBool('water', value);
    print('save');
  }

  void save_dataenv(bool value) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setBool('env', value);
    print('save');
  }

  void save_datasecurity(bool value) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setBool('security', value);
    print('save');
  }
}
