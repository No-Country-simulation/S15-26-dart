import 'package:flutter/material.dart';
import 'package:turistear_aplication_v1/app/ui/components/category_card.dart';

class CategoriesSlider extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {'title': 'Museos', 'icon': Icons.museum},
    {'title': 'Parques', 'icon': Icons.park},
    {'title': 'Monumentos', 'icon': Icons.account_balance},
    {'title': 'Reservas', 'icon': Icons.nature},
    {'title': 'Gastronomía', 'icon': Icons.restaurant},
  ];

  CategoriesSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories.map((category) {
          return CategoryCard(
            title: category['title'],
            icon: category['icon'],
          );
        }).toList(),
      ),
    );
  }
}
