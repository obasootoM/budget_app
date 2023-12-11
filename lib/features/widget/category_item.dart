// ignore_for_file: must_be_immutable

import 'package:budget_app/utilis/app_icon.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  CategoryItem({super.key, 
  this.item, required this.onChanged});
  final String? item;
  final ValueChanged<String?> onChanged;
  var appIcon =AppIcon();
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      hint: const Text('Select category'),
      isExpanded: true,
      value: item,
      items: appIcon.homeExpenseCategory.map((e) => DropdownMenuItem<String>(
        value: e['name'],
        child: Row(
          children: [
            Icon(e['icon'],color: Colors.black,),
            const SizedBox(width: 10,),
            Text(e['name'], style: const TextStyle(color: Colors.black),),
          ],
        ))).toList(),
       onChanged: onChanged);
  }
}