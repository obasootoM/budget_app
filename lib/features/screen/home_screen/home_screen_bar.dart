// ignore_for_file: prefer_const_constructors

import 'package:budget_app/features/auth/auth_service/auth_service.dart';
import 'package:budget_app/features/widget/alert_dialog.dart';
import 'package:budget_app/features/widget/flat_card.dart';
import 'package:budget_app/features/widget/recent_transaction.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreenBar extends StatefulWidget {
  const HomeScreenBar({super.key});

  @override
  State<HomeScreenBar> createState() => _HomeScreenBarState();
}

class _HomeScreenBarState extends State<HomeScreenBar> {
  logout() async {
    setState(() {
      isLoading = true;
    });
    await FirebaseAuth.instance.signOut();
    isLoading = false;
  }

  var authService = AuthService();
  var isLoading = false;
  _dialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: AlertDialogs()
          );
        });
  }

  @override
  Widget build(BuildContext context) {
     final userId = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      floatingActionButton: FloatingActionButton.small(
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        onPressed: () {
          _dialog(context);
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
          title:  Text(
            'Hello, ',
            style: TextStyle(fontSize: 20),
          ),
          backgroundColor: Colors.blue[700],
          actions: [
            IconButton(
                onPressed: logout,
                icon: isLoading
                    ? const CircularProgressIndicator()
                    : const Icon(Icons.logout))
          ]),
      body: SingleChildScrollView(
        child: Column(
          children: [FlatCard(userId: userId,), RecentTransaction()],
        ),
      ),
    );
  }
}
