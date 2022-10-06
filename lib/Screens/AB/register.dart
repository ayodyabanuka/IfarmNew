import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ifarm/Screens/AB/Login.dart';

import 'package:ifarm/functions/authFunctions.dart';
import 'package:ifarm/widget/customizedTextField.dart';

class register extends StatefulWidget {
  register({Key? key}) : super(key: key);

  @override
  State<register> createState() => _registerState();
}

TextEditingController nameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class _registerState extends State<register> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xff024F8E),
      appBar: AppBar(
        backgroundColor: const Color(0xff024F8E),
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 25,
                ),
                Center(
                  child: SizedBox(
                    height: 55,
                    child: Image.asset(
                      "assets/images/IFarm_Logo_White.png",
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  'Hello,Register here!',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'poppins',
                    fontSize: 15,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),

                // Name textbox
                customizedTextField(
                  empty: 'Please enter Name',
                  mycontroller: nameController,
                  lableText: "UserName",
                  isPassword: false,
                ),
                const SizedBox(
                  height: 20,
                ),
                // Email textbox
                customizedTextField(
                  empty: 'Please enter Email',
                  mycontroller: emailController,
                  lableText: "Email",
                  isPassword: false,
                ),
                const SizedBox(
                  height: 20,
                ),

                // Password textbox
                customizedTextField(
                  empty: 'Please enter password',
                  mycontroller: passwordController,
                  lableText: "Password",
                  isPassword: true,
                ),

                const SizedBox(
                  height: 50,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FlatButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Login()));
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: const Color(0xffFEC427)),
                              borderRadius: BorderRadius.circular(10)),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 1),
                            child: Text(
                              'Login',
                              style: TextStyle(
                                  color: Colors.white, fontFamily: 'poppins'),
                            ),
                          ),
                        )),
                    FlatButton(
                        onPressed: () {
                          print(emailController.text);
                          print(passwordController.text);
                          if (emailController.text.isEmpty &&
                              passwordController.text.isEmpty &&
                              nameController.text.isEmpty) {
                            Fluttertoast.showToast(
                                msg: 'Enter your details',
                                gravity: ToastGravity.BOTTOM,
                                toastLength: Toast.LENGTH_SHORT);
                          } else {
                            AuthServices.signupUser(
                                emailController.text,
                                passwordController.text,
                                nameController.text,
                                context);
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                              color: const Color(0xffFEC427),
                              borderRadius: BorderRadius.circular(10)),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 1),
                            child: Text(
                              'Create Account',
                              style: TextStyle(fontFamily: 'poppins'),
                            ),
                          ),
                        )),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
