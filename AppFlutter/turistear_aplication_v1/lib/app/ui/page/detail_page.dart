import 'package:flutter/material.dart';

import '../../data/model/detail_item.dart';

class DetailPage extends StatelessWidget {
  final DetailItem detailItem;

  const DetailPage({required this.detailItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(detailItem.title),
      ),
      body: Column(
        children: [
          Card(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                detailItem.imageUrl,
                fit: BoxFit.cover,
                width: 300,
                height: 300,
              ),
            ),
          ),
          SizedBox(height: 16),
          Card(
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                detailItem.description,
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // Añadir Lógica para Agregar a Itinerarios
            },
            child: Text(
              'Agregar a Itinerarios',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    offset: Offset(1, 1),
                    blurRadius: 1,
                    color: Colors.grey.withOpacity(0.9),
                  ),
                ],
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.tealAccent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
          ),
        ],
      ),
    );
  }
}
