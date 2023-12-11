import 'package:budget_app/features/screen/home_screen/home_screen_bar.dart';
import 'package:budget_app/features/screen/home_screen/transaction_screen.dart';
import 'package:budget_app/features/screen/sing_in.dart';
import 'package:budget_app/features/widget/nav_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var pageView = [
    const HomeScreenBar(), 
    const TransactionScreen()];
  int selectIndex = 0;
  var isLoading = false;
  logout() async {
    setState(() {
      isLoading = true;
    });
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const SignIn()));
    isLoading = false;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavBar(
          selectIndex: selectIndex,
          onSelected: ((value) {
            setState(() {
              selectIndex = value;
             });
          })),
      body: pageView[selectIndex],
    );
  }
}
