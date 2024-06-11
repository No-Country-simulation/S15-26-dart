import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turistear_aplication_v1/app/ui/components/custom_app_bar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  bool isSelectedCuenta = true;
  bool isSelectedAjustes = false;

  void toggleOption(int index) {
    setState(() {
      if (index == 0) {
        isSelectedCuenta = true;
        isSelectedAjustes = false;
      } else {
        isSelectedCuenta = false;
        isSelectedAjustes = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'TuristAPP'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Titulo
            Text(
              'Perfil',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 16.sp, // Usa ScreenUtil para el tamaño del texto
                  ),
            ),
            const SizedBox(height: 20),
            // Foto
            Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.width * 0.3,
                child: Center(
                  child: Text(
                    'Sube tu Foto',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize:
                              12.sp, // Usa ScreenUtil para el tamaño del texto
                        ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Boton Selector
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ToggleButtons(
                  isSelected: [isSelectedCuenta, isSelectedAjustes],
                  onPressed: toggleOption,
                  selectedColor: Colors.white,
                  selectedBorderColor: Colors.amber,
                  fillColor: Colors.amber,
                  splashColor: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(8),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        'Cuenta',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontSize: 10
                                  .sp, // Usa ScreenUtil para el tamaño del texto
                            ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Ajustes',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontSize: 10
                                  .sp, // Usa ScreenUtil para el tamaño del texto
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 5),
            // Formulario
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isSelectedCuenta ? 'Cuenta' : 'Ajustes',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize:
                              16.sp, // Usa ScreenUtil para el tamaño del texto
                        ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Realice los cambios en su cuenta aquí. Haga clic en guardar cuando haya terminado.',
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      labelText:
                          isSelectedCuenta ? 'Nombre' : 'Correo Electrónico',
                      labelStyle: TextStyle(
                        fontSize: 10.sp, // Tamaño del texto de la etiqueta
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                    ),
                    style: TextStyle(
                      fontSize: 12.sp, // Tamaño del texto del contenido
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(
                      labelText: isSelectedCuenta ? 'Usuario' : 'Celular',
                      labelStyle: TextStyle(
                        fontSize: 10.sp, // Tamaño del texto de la etiqueta
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                    ),
                    style: TextStyle(
                      fontSize: 12.sp, // Tamaño del texto del contenido
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(
                          Theme.of(context).colorScheme.primary),
                      side: WidgetStateProperty.all(
                          const BorderSide(color: Colors.transparent)),
                      shape: WidgetStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5))),
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
            ),
          ],
        ),
      ),
    );
  }
}
