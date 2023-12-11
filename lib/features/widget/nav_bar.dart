import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key, required this.selectIndex,
   required this.onSelected});
  final int selectIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      indicatorColor: Colors.blue[100],
      selectedIndex: selectIndex,
      onDestinationSelected: onSelected,
      destinations: const [
        NavigationDestination(icon:  Icon(Icons.home), label: 'Home'),
         NavigationDestination(icon:  Icon(Icons.commute), label: 'Transaction'),
      ]);
  }
}
