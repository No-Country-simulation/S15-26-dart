import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turistear_aplication_v1/app/ui/components/custom_app_bar.dart';
import '../components/dashed_border_painter.dart';

class ItineraryPage extends StatelessWidget {
  const ItineraryPage({super.key});

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
              const SizedBox(height: 10),
              // Bloque Encabezado
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Crea Nuevo Itinerario',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize:
                            16.sp, // Usa ScreenUtil para el tamaño del texto
                      ),
                ),
              ),
              const SizedBox(height: 24),
              // Iconos de location con línea punteada
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      InkWell(
                        onTap: () {},
                        child: const Icon(Icons.location_on, size: 36.0),
                      ),
                      Text(
                        'Agregar',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontSize: 14
                                  .sp, // Usa ScreenUtil para el tamaño del texto
                            ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: CustomPaint(
                      size: const Size(150, 1),
                      painter: DashedBorderPainter(
                        color: Theme.of(context)
                            .colorScheme
                            .tertiary, // Usa el color del tema
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      const Icon(Icons.location_on, size: 36.0),
                      Text(
                        'Guardar',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontSize: 14
                                  .sp, // Usa ScreenUtil para el tamaño del texto
                            ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Cards
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Card(
                    elevation: 8.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    color: Colors.green,
                    child: Container(
                      width: 150,
                      height: 150,
                      child: const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.map, color: Colors.black, size: 72.0),
                            Text('Mapa', style: TextStyle(color: Colors.black)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    elevation: 8.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    color: Colors.amber,
                    child: Container(
                      width: 150,
                      height: 150,
                      child: const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.luggage_sharp,
                                color: Colors.black, size: 72.0),
                            Text('Sitios Turísticos',
                                style: TextStyle(color: Colors.black)),
                          ],
                        ),
                      ),
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
