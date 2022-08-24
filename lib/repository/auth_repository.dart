import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myoxigin/Screens/Login/login_screen.dart';

import '../Screens/Home/homescreen.dart';

class AuthRepositoryImpl {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //check if user logged in or not
  Stream<User?> get authStateChange => _auth.authStateChanges();

  Future<void> signInWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      return _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((user) {
        if (user.user != null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text('Login Successful'),
            duration: const Duration(seconds: 2),
            action: SnackBarAction(
              label: 'Close',
              onPressed: () {},
            ),
          ));
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const Homescreen();
          }));
        }
      }).catchError((e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.toString()),
          duration: const Duration(seconds: 5),
          action: SnackBarAction(
            label: 'Close',
            onPressed: () {},
          ),
        ));
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        duration: const Duration(seconds: 5),
        action: SnackBarAction(
          label: 'Close',
          onPressed: () {},
        ),
      ));
      print(e.toString());
    }
  }

  Future<void> signOut(BuildContext context) async {
    await _auth.signOut();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text('Logged out of account successful'),
      duration: const Duration(seconds: 2),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {},
      ),
    ));
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
      return const LoginScreen();
    }), (Route<dynamic> route) => false);
  }

  Future<void> sendPasswordInfo(
      {required BuildContext context, required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email).then((value) {
        //print(value);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text(
              'Password reset Info sent, Check Email to follow the instruction'),
          duration: const Duration(seconds: 2),
          action: SnackBarAction(
            label: 'Close',
            onPressed: () {},
          ),
        ));
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) {
          return const LoginScreen();
        }), (Route<dynamic> route) => false);
        /* Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
              return EmailSent(email: email,);
            }));*/
      });
    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'Close',
          onPressed: () {},
        ),
      ));
    }
  }

  Future<void> signUpWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      return _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((user) {
        if (user.user != null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text('Account Successfully Created, please login'),
            duration: const Duration(seconds: 2),
            action: SnackBarAction(
              label: 'Close',
              onPressed: () {},
            ),
          ));
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (context) {
            return const LoginScreen();
          }), (Route<dynamic> route) => false);
        }
      });
    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'Close',
          onPressed: () {},
        ),
      ));
    }
  }
}
