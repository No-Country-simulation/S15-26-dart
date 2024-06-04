import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FormNombre extends StatelessWidget {
  const FormNombre({super.key});

  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
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
          child: Text(
            'Nombre',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 10.sp, // Usa ScreenUtil para el tamaño del texto
                ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: TextFormField(
            controller: nameController,
            validator: (val) =>
                val == "" ? "Dale un nombre a tu itinerario" : null,
            decoration: InputDecoration(
              hintText: "Dale un nombre a tu itinerario",
              hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 8.sp, // Usa ScreenUtil para el tamaño del texto
                  ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(
                  color: Colors.white60,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(
                  color: Colors.white60,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(
                  color: Colors.white60,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(
                  color: Colors.white60,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 6,
              ),
              fillColor: Colors.white,
              filled: true,
            ),
          ),
        ),
      ],
    );
  }
}
