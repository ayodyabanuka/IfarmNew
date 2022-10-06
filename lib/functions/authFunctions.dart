import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ifarm/Screens/AB/Navbar.dart';
import 'package:ifarm/Screens/AB/SplashScreen.dart';
import 'package:ifarm/functions/firebaseFunctions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthServices {
  static signupUser(
      String email, String password, String name, BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      await FirebaseAuth.instance.currentUser!.updateDisplayName(name);
      await FirebaseAuth.instance.currentUser!.updateEmail(email);
      await FirestoreServices.saveUser(name, email);
      Fluttertoast.showToast(
          msg: 'Registration Successful',
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_SHORT);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.red,
            content: Text('Password Provided is too weak')));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.red,
            content: Text('Email Provided already Exists')));
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Error!',
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_SHORT);
    }
  }

  static signinUser(String email, String password, bool isChecked,
      BuildContext context) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    if (isChecked == true) {
      localStorage.setInt('login', 1);
    }
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      await Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => Navbar()), (route) => false);

      Fluttertoast.showToast(
          msg: 'Login Successful',
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_SHORT);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.red,
            content: Text('No user Found with this Email')));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.red,
            content: Text('Password did not match')));
      }
    }
  }
}
