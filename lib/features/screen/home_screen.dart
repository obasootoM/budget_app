import 'package:budget_app/features/screen/home_screen/home_screen_bar.dart';
import 'package:budget_app/features/screen/home_screen/transaction_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void changePage(int page) {
    setState(() {
      selectIndex = page;
    });
  }

  List pageView = [const HomeScreenBar(), const TransactionScreen()];
  int selectIndex = 0;
  var isLoading = false;
  logout() async {
    setState(() {
      isLoading = true;
    });
    await FirebaseAuth.instance.signOut();
    // Navigator.push(context, MaterialPageRoute(builder: (context) => SignIn()));
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 30,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.grey,
        currentIndex: selectIndex,
        onTap: changePage,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.commute), label: ''),
        ],
      ),
      // NavBar(
      //     selectIndex: selectIndex,
      //     onSelected: ((value) {
      //       setState(() {
      //         selectIndex = value;
      //        });
      //     })),
      body: pageView[selectIndex],
    );
  }
}
