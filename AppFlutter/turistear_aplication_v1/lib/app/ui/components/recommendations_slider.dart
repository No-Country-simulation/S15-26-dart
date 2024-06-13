import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class RecommendationsSlider extends StatelessWidget {
  final List<String> imageUrls;
  final List<String> titles;
  final List<Function> onPressedCallbacks;

  const RecommendationsSlider(
      {super.key,
      required this.imageUrls,
      required this.titles,
      required this.onPressedCallbacks});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Ver Todas...',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SingleChildScrollView(
          child: Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  height: 210.0,
                  autoPlay: true,
                  enlargeCenterPage: true,
                ),
                items: imageUrls.map((url) {
                  int index = imageUrls.indexOf(url);
                  return Container(
                    margin: const EdgeInsets.all(3.0),
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          image: DecorationImage(
                            image: AssetImage(url),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                padding:
                                    const EdgeInsets.fromLTRB(16, 8, 16, 8),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(16),
                                      bottomRight: Radius.circular(16)),
                                  color: Colors.white.withOpacity(0.4),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        titles[imageUrls.indexOf(url)],
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          shadows: [
                                            Shadow(
                                              offset: const Offset(1, 1),
                                              blurRadius: 1,
                                              color:
                                                  Colors.grey.withOpacity(0.9),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () =>
                                          onPressedCallbacks[index](
                                              context, index),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.tealAccent,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                      ),
                                      child: Text(
                                        'Ver más',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          shadows: [
                                            Shadow(
                                              offset: const Offset(1, 1),
                                              blurRadius: 1,
                                              color:
                                                  Colors.grey.withOpacity(0.9),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
