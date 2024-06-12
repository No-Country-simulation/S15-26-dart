import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FormNombre extends StatelessWidget {
  final Function(String) onSave;

  const FormNombre({super.key, required this.onSave});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text(
            'Agrega un Nombre',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 14.sp, // Usa ScreenUtil para el tamaño del texto
                ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment:
                    Alignment.centerLeft, // Alinea el texto a la izquierda
                child: Text(
                  'Nombre',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize:
                            12.sp, // Usa ScreenUtil para el tamaño del texto
                      ),
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: nameController,
                validator: (val) =>
                    val == "" ? "Dale un nombre a tu itinerario" : null,
                decoration: InputDecoration(
                  hintText: "Dale un nombre a tu itinerario",
                  hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize:
                            10.sp, // Usa ScreenUtil para el tamaño del texto
                      ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 6,
                  ),
                  fillColor: Theme.of(context).colorScheme.secondary,
                  filled: true,
                ),
              ),
              const SizedBox(
                  height: 24), // Espacio entre el TextFormField y los botones
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Cierra el dialogo
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      'Cancelar',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 12.sp,
                          ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      onSave(nameController.text);
                      Navigator.pop(context); // Cierra el dialogo
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      'Guardar',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 12.sp,
                          ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
