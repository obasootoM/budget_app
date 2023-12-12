import 'dart:async';

import 'package:budget_app/features/widget/auth_gate.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 5),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const AuthGate())));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color.fromARGB(255, 126, 122, 122),
      child: const Center(child: Text('Budgetty',style: TextStyle(fontSize: 20, color: Colors.white),)),
    );
  }
}
