import 'package:budget_app/features/auth/auth_service/db.dart';
import 'package:budget_app/features/screen/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  var db = DB();
  createService(context, data) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: data['email'],
        password: data['password'],
      );
      // await db.addUser(data, context);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()));
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Login error'),
              content: Text(e.toString()),
            );
          });
    }
  }

  login(context, data) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: data['email'], password: data['password']);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()));
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Login error'),
              content: Text(e.toString()),
            );
          });
    }
  }
}
