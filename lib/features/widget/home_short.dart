import 'package:budget_app/features/screen/sing_in.dart';
import 'package:flutter/material.dart';

class HomeShort extends StatelessWidget {
  const HomeShort({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignIn()));
            },
            icon: const Icon(Icons.logout))
      ]),
    );
  }
}
