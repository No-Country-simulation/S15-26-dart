import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turistear_aplication_v1/app/provider/navigation_provider.dart';
import 'package:turistear_aplication_v1/app/ui/page/home_page.dart';
import 'package:turistear_aplication_v1/app/ui/page/itinerary_list_page.dart';
import 'package:turistear_aplication_v1/app/ui/page/profile_page.dart';

class DashboardOfFragments extends StatelessWidget {
  final List<Widget> _fragmentScreens = [
    MyHomePage(),
    const ItineraryListPage(),
    const ProfilePage(),
  ];

  final List _navigationButtonProperties = [
    {
      "active_icon": Icons.home,
      "inactive_icon": Icons.home,
      "label": "", // Etiqueta vacía
    },
    {
      "active_icon": Icons.add_card,
      "inactive_icon": Icons.add_card,
      "label": "", // Etiqueta vacía
    },
    {
      "active_icon": Icons.person_2,
      "inactive_icon": Icons.person_2,
      "label": "", // Etiqueta vacía
    },
  ];

  DashboardOfFragments({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<NavigationProvider>(
          builder: (context, navigationProvider, child) {
            return _fragmentScreens[navigationProvider.currentIndex];
          },
        ),
      ),
      bottomNavigationBar: Opacity(
        opacity: 1, // Ajusta la opacidad aquí
        child: Container(
          height: 95, // Ajusta la altura aquí

          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 164, 244, 231),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
            ),
          ),
          child: ClipRRect(
            child: Consumer<NavigationProvider>(
              builder: (context, navigationProvider, child) {
                return BottomNavigationBar(
                  backgroundColor: Colors
                      .transparent, // Hacer el fondo transparente para mostrar el color del contenedor
                  currentIndex: navigationProvider.currentIndex,
                  onTap: (value) {
                    navigationProvider.setIndex(value);
                  },
                  showSelectedLabels: false, // Ocultar etiquetas seleccionadas
                  showUnselectedLabels:
                      false, // Ocultar etiquetas no seleccionadas
                  items: List.generate(3, (index) {
                    var navBtnProperty = _navigationButtonProperties[index];
                    return BottomNavigationBarItem(
                      icon: Container(
                        width: 60,
                        height: 60,
                        decoration: navigationProvider.currentIndex == index
                            ? BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors
                                    .teal, // Color de fondo del círculo activo
                                border: Border.all(
                                  color: Colors.white, // Color del borde blanco
                                  width: 2.0, // Ancho del borde
                                ),
                              )
                            : null, // Sin decoración para el ícono inactivo
                        child: Icon(
                          navigationProvider.currentIndex == index
                              ? navBtnProperty["active_icon"]
                              : navBtnProperty["inactive_icon"],
                          size: 30,
                          color: Colors.black,
                        ),
                      ),

                      label: navBtnProperty["label"], // Etiqueta vacía
                    );
                  }),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
