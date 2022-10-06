import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:ifarm/Screens/AB/Login.dart';
import 'package:ifarm/Screens/AB/Navbar.dart';
import 'package:ifarm/Screens/AB/NetworkErrorPage.dart';
import 'package:ifarm/functions/Network.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class splashScreen extends StatefulWidget {
  splashScreen({Key? key}) : super(key: key);

  @override
  State<splashScreen> createState() => _splashScreenState();
}

int? logged;

class _splashScreenState extends State<splashScreen>
    with TickerProviderStateMixin {
  bool isoffline = false;
  Map _source = {ConnectivityResult.none: false};
  final NetworkConnectivity _networkConnectivity = NetworkConnectivity.instance;
  String string = '';
  late AnimationController _controller;
  void initState() {
    getdata();
    savedata();
    super.initState();
    _controller = AnimationController(vsync: this);
    _controller.addListener(() {
      print(_controller.value);
      //  if the full duration of the animation is 8 secs then 0.5 is 4 secs
      if (_controller.value > 1) {
// When it gets there hold it there.
        _controller.value = 1;
      }
    });
    //set time to load the new page

    super.initState();
  }

  @override
  void dispose() {
    _networkConnectivity.disposeStream();
    super.dispose();
  }

  savedata() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    if (localStorage.getBool('food') == null) {
      localStorage.setBool('food', true);
    }
    if (localStorage.getBool('water') == null) {
      localStorage.setBool('water', true);
    }
    if (localStorage.getBool('env') == null) {
      localStorage.setBool('env', true);
    }
    if (localStorage.getBool('security') == null) {
      localStorage.setBool('security', true);
    }
  }

  getdata() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    var user_login = localStorage.getInt('login');
    print(user_login);
    setState(() {
      logged = user_login;
    });

    if (user_login == 1) {
      Future.delayed(const Duration(seconds: 5), () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Navbar()),
            (route) => false);
      });
    } else {
      Future.delayed(const Duration(seconds: 5), () {
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) => Login()), (route) => false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff024F8E),
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(color: Color(0xff024F8E)),
        child: Center(
          child: SizedBox(
            height: 60,
            child: Image.asset(
              "assets/images/IFarm_Logo_White.png",
            ),
          ),
        ),
      ),
    );
  }
}
