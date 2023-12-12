import 'package:budget_app/features/widget/transaction_list.dart';
import 'package:flutter/material.dart';

class TabBars extends StatelessWidget {
  TabBars({super.key, 
  required this.category, 
  required this.monthYear});
  final String category;
  final String monthYear;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              const TabBar(
                tabs: [
                  Tab(
                    text: 'Credit',
                  ),
                  Tab(
                    text: 'Debit',
                  )
                ],
              ),
              Expanded(
                child: TabBarView(children: [
                  TransactionListed(
                      categorys: category,
                      monthYear: monthYear,
                      type: 'credit'),
                   TransactionListed(
                      categorys: category,
                      monthYear: monthYear,
                      type: 'debit'),
                ]),
              )
            ],
          )),
    );
  }
}
