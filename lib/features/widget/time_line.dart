import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeLineWidget extends StatefulWidget {
  const TimeLineWidget({super.key, required this.changed});
  final ValueChanged<String?> changed;

  @override
  State<TimeLineWidget> createState() => _TimeLineWidgetState();
}

class _TimeLineWidgetState extends State<TimeLineWidget> {
  String currentMonth = '';
  List<String> month = [];
  void initState() {
    super.initState();
    DateTime date = DateTime.now();
    for (int i = -17; i <= 0; i++) {
      month.add(
          DateFormat('MMM y').format(DateTime(date.year, date.month + i, 1)));
    }
    currentMonth = DateFormat('MMM y').format(date);

    Future.delayed(Duration(seconds: 1), () {
      scrollToMonth();
    });
  }

  final scrollAction = ScrollController();
  scrollToMonth() {
    final scrollMonthIndex = month.indexOf(currentMonth);
    if (scrollMonthIndex != -1) {
      final scrollOffset = (scrollMonthIndex * 100.0) - 170;
      scrollAction.animateTo(scrollOffset,
          duration: const Duration(milliseconds: 500), curve: Curves.ease);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: ListView.builder(
          controller: scrollAction,
          scrollDirection: Axis.horizontal,
          itemCount: month.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  currentMonth = month[index];
                  widget.changed(month[index]);
                });
                scrollToMonth();
              },
              child: Container(
                margin: const EdgeInsets.all(2),
                height: 200,
                decoration: BoxDecoration(
                    color: currentMonth == month[index]
                        ? Colors.blue.shade700.withOpacity(0.3)
                        : Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: Text(
                    month[index],
                    style: TextStyle(
                      color: currentMonth == month[index]
                          ? Colors.blue.shade700
                          : Colors.red,
                    ),
                  )),
                ),
              ),
            );
          }),
    );
  }
}
