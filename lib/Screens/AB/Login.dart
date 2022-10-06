import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ifarm/Screens/AB/register.dart';
import 'package:ifarm/functions/authFunctions.dart';
import 'package:ifarm/widget/customizedTextField.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
bool isChecked = false;
bool _isLogin = false;

class _LoginState extends State<Login> {
  bool _obscureText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    @override
    void initState() {
      super.initState();
    }

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff024F8E),
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: size.height,
              width: size.width,
              color: const Color(0xff024F8E),
              child: Transform.translate(
                offset: const Offset(0, -190),
                child: Image.asset(
                  "assets/images/login_image.png",
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(
                    height: 200,
                  ),
                  ClipRect(
                      child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
                    child: Container(
                      width: size.width - 40,
                      height: size.height - 315,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color.fromARGB(255, 241, 246, 255)),
                        color: const Color(0xff06375F).withOpacity(0.37),
                        borderRadius: BorderRadius.circular(20),
                      ),
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
                            'Hello, log in to your profile',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'poppins',
                              fontSize: 15,
                            ),
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
                            height: 5,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Row(
                              children: [
                                Checkbox(
                                    checkColor: Colors.white,
                                    value: isChecked,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        isChecked = value!;
                                      });
                                    }),
                                const Text(
                                  'Remember Me',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontFamily: 'poppins'),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FlatButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => register()));
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: const Color(0xffFEC427)),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 1),
                                      child: Text(
                                        'Create Account',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'poppins'),
                                      ),
                                    ),
                                  )),
                              FlatButton(
                                  onPressed: () {
                                    print(emailController.text);
                                    print(passwordController.text);
                                    if (emailController.text.isEmpty &&
                                        passwordController.text.isEmpty) {
                                      Fluttertoast.showToast(
                                          msg: 'Enter Credintials',
                                          gravity: ToastGravity.BOTTOM,
                                          toastLength: Toast.LENGTH_SHORT);
                                    } else {
                                      AuthServices.signinUser(
                                          emailController.text,
                                          passwordController.text,
                                          isChecked,
                                          context);
                                      print(isChecked);
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    decoration: BoxDecoration(
                                        color: const Color(0xffFEC427),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 1),
                                      child: Text(
                                        'Login',
                                        style: TextStyle(fontFamily: 'poppins'),
                                      ),
                                    ),
                                  )),
                            ],
                          )
                        ],
                      ),
                    ),
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
