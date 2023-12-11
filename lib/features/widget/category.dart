import 'package:budget_app/utilis/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class Category extends StatefulWidget {
  const Category({super.key, required this.changed});
  final ValueChanged<String?> changed;
  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  List<Map<String, dynamic>> categoryList = [];
  var appIcon = AppIcon();
  String currentCategory = '';

  void initState() {
    super.initState();
    var addList = {'name': 'All', 'icon': FontAwesomeIcons.cartPlus};
    setState(() {
      categoryList = appIcon.homeExpenseCategory;
     appIcon.homeExpenseCategory.insert(0, addList);
    });
  }

  final scrollAction = ScrollController();
  // scrollToMonth() {

  //   final scrollMonthIndex = mo.indexOf(currentCategory);
  //   if (scrollMonthIndex != -1) {
  //     final scrollOffset = (scrollMonthIndex * 100.0) - 170;
  //     scrollAction.animateTo(scrollOffset,
  //         duration: const Duration(milliseconds: 500), curve: Curves.ease);
  //   }
  // }
 
  @override
  Widget build(BuildContext context) {
   
    return Container(
      height: 40,
      child: ListView.builder(
          controller: scrollAction,
          scrollDirection: Axis.horizontal,
          itemCount: categoryList.length,
          itemBuilder: (context, index) {
            var data = appIcon.homeExpenseCategory[index];
            return GestureDetector(
              onTap: () {
                setState(() {
                  currentCategory = data['name'];
                  widget.changed(data['name']);
                });
              },
              child: Container(
                margin: const EdgeInsets.all(2),
                height: 200,
                decoration: BoxDecoration(
                    color: currentCategory == data['name']
                        ? const Color.fromARGB(255, 109, 80, 239)
                        : const Color.fromARGB(255, 40, 55, 187).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: Row(
                    children: [
                      Icon(
                        data['icon'],
                        size: 20,
                        color: currentCategory == data['name']
                            ? Colors.white
                            : const Color.fromARGB(255, 54, 143, 244),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        data['name'],
                        style: TextStyle(
                          color: currentCategory == data['name']
                              ? const Color.fromARGB(255, 205, 249, 255)
                              : const Color.fromARGB(255, 54, 143, 244),
                        ),
                      ),
                    ],
                  )),
                ),
              ),
            );
          }),
    );
  }
}
