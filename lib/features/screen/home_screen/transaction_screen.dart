import 'package:budget_app/features/widget/category.dart';
import 'package:budget_app/features/widget/tab_bar.dart';
import 'package:budget_app/features/widget/time_line.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  var category = 'All';
  var monthyear = '';

  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    setState(() {
      monthyear = DateFormat('MMM y').format(now);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Expensive')),
      body: Column(children: [
        TimeLineWidget(
          changed: (String? value) {
            if (value != null) {
             setState(() {
                monthyear = value;
             });
            }
          },
        ),
        const SizedBox(
          height: 10,
        ),
        Category(
          changed: (String? value) {
            if (value != null) {
             setState(() {
                category = value;
             });
            }
          },
        ),
        const SizedBox(
          height: 10,
        ),
        TabBars(
          category: category,
          monthYear: monthyear,
        )
      ]),
    );
  }
}
