import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
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
              StaggeredGrid.count(
                crossAxisCount: 4,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                children: const [
                  StaggeredGridTile.count(
                    crossAxisCellCount: 2,
                    mainAxisCellCount: 2,
                    child: CustomCategoryCard(
                      title: 'Mapa',
                      icon: Icons.map,
                      backgroundColor: Color.fromRGBO(26, 188, 156, 1),
                      textColor: Colors.black,
                      iconColor: Colors.black,
                    ),
                  ),
                  StaggeredGridTile.count(
                    crossAxisCellCount: 2,
                    mainAxisCellCount: 1,
                    child: CustomCategoryCard(
                      title: 'Sitios Turisticos',
                      icon: Icons.mode_of_travel,
                      backgroundColor: Color.fromRGBO(255, 212, 38, 1),
                      textColor: Colors.black,
                      iconColor: Colors.black,
                    ),
                  ),
                  StaggeredGridTile.count(
                    crossAxisCellCount: 2,
                    mainAxisCellCount: 1,
                    child: CustomCategoryCard(
                      title: 'Mis Sitios',
                      icon: Icons.bookmark,
                      backgroundColor: Color.fromRGBO(164, 244, 231, 1),
                      textColor: Colors.black,
                      iconColor: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
