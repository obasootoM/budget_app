import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppIcon {
  final List<Map<String, dynamic>> homeExpenseCategory = [
    {'name': 'gas filling', 'icon': FontAwesomeIcons.gasPump},
    {'name': 'Grocery', 'icon': FontAwesomeIcons.cartShopping},
    {'name': 'Milk', 'icon': FontAwesomeIcons.mugHot},
    {'name': 'internet', 'icon': FontAwesomeIcons.wifi},
    {'name': 'Electricity', 'icon': FontAwesomeIcons.bolt},
    {'name': 'Water', 'icon': FontAwesomeIcons.water},
    {'name': 'Rent', 'icon': FontAwesomeIcons.home},
    {'name': 'Clothes', 'icon': FontAwesomeIcons.tshirt},
    {'name': 'Entertainment', 'icon': FontAwesomeIcons.film},
    {'name': 'HealthCare', 'icon': FontAwesomeIcons.medkit},
    {'name': 'Transportation', 'icon': FontAwesomeIcons.bus},
    {'name':'music', 'icon':FontAwesomeIcons.music},
    {'name':'smoking', 'icon':FontAwesomeIcons.cannabis},
    
  ];
   IconData categoryItem(String categoryName) {
    final category = homeExpenseCategory.firstWhere(
      (element) => element['name'] == categoryName,
      orElse: () => {'icon': FontAwesomeIcons.cartShopping},
    );
    return category['icon'];
  }
}
