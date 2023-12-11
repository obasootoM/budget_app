import 'package:flutter/material.dart';

class cardItem extends StatelessWidget {
  const cardItem({
    super.key,
    required this.cash,
    required this.num,
    required this.color,
  });
  final String cash;
  final String num;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: ShapeDecoration(
            color: color.withOpacity(0.2),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cash,
                style: TextStyle(fontSize: 20, color: color),
              ),
              Text(
                'N ${num}',
                style: TextStyle(fontSize: 30, color: color),
              )
            ],
          ),
          Icon(
            cash == 'credit' ? Icons.arrow_upward : Icons.arrow_downward,
            color: color,
          )
        ]),
      ),
    );
  }
}
