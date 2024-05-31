import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turistear_aplication_v1/app/provider/navigation_provider.dart';
import 'package:turistear_aplication_v1/app/ui/page/home_page.dart';
import 'package:turistear_aplication_v1/app/ui/page/map_page.dart';
import 'package:turistear_aplication_v1/app/ui/page/profile_page.dart';

class DashboardOfFragments extends StatelessWidget {
  final List<Widget> _fragmentScreens = [
    MyHomePage(),
    const MapPage(),
    const ProfilePage()
  ];

  final List _navigationButtonProperties = [
    {
      "active_icon": Icons.home,
      "inactive_icon": Icons.home_outlined,
      "label": "Home",
    },
    {
      "active_icon": Icons.add_box,
      "inactive_icon": Icons.add_card_outlined,
      "label": "Consulta",
    },
    {
      "active_icon": Icons.person_2,
      "inactive_icon": Icons.person_2_outlined,
      "label": "Perfil",
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
        opacity: 0.8, // Ajusta la opacidad aquí
        child: Container(
          height: 59.6, // Ajusta la altura aquí
          margin:
              const EdgeInsets.only(top: 7.4), // Ajusta el margen superior aquí
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 164, 244, 231),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
            ),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
            ),
            child: Consumer<NavigationProvider>(
              builder: (context, navigationProvider, child) {
                return BottomNavigationBar(
                  backgroundColor: Colors
                      .transparent, // Hacer el fondo transparente para mostrar el color del contenedor
                  currentIndex: navigationProvider.currentIndex,
                  onTap: (value) {
                    navigationProvider.setIndex(value);
                  },
                  showSelectedLabels: true,
                  showUnselectedLabels: true,
                  items: List.generate(3, (index) {
                    var navBtnProperty = _navigationButtonProperties[index];
                    return BottomNavigationBarItem(
                      icon: Icon(navBtnProperty["inactive_icon"]),
                      activeIcon: Icon(navBtnProperty["active_icon"]),
                      label: navBtnProperty["label"],
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
