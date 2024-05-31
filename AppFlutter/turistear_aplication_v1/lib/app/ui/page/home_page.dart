import 'package:flutter/material.dart';
import 'package:turistear_aplication_v1/app/ui/components/categories_slider.dart';
import 'package:turistear_aplication_v1/app/ui/components/custom_app_bar.dart';
import 'package:turistear_aplication_v1/app/ui/components/custom_category_card.dart';
import 'package:turistear_aplication_v1/app/ui/components/recommendatio_slider.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});
  final List<String> imageUrls = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR3-Ec6DdzFKkII3zqh7UrNbf8uA9_BQL1h2g&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQhZhpNtodRsPmnWZAG3eRWRRcbQCf8joUI1w&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcToR9yMEptxmtRnpIu5Qp2NklsAXWEGXAG9-A&s',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'TuristAPP'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              CategoriesSlider(),
              const SizedBox(height: 16),
              RecommendationsSlider(imageUrls: imageUrls),
              const SizedBox(height: 16),
              const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      child: CustomCategoryCard(
                        title: 'Mapa',
                        icon: Icons.map,
                        backgroundColor: Colors.teal,
                        textColor: Colors.black,
                        iconColor: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        SizedBox(
                          height:
                              90, // Puedes ajustar la altura según sea necesario
                          child: CustomCategoryCard(
                            title: 'Sitios Turisticos',
                            icon: Icons.location_city,
                            backgroundColor: Colors.yellow,
                            textColor: Colors.black,
                            iconColor: Colors.black,
                          ),
                        ),
                        SizedBox(height: 16),
                        SizedBox(
                          height:
                              90, // Puedes ajustar la altura según sea necesario
                          child: CustomCategoryCard(
                            title: 'Mis Sitios',
                            icon: Icons.bookmark,
                            backgroundColor: Colors.lightBlueAccent,
                            textColor: Colors.black,
                            iconColor: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
