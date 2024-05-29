import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turistear_aplication_v1/app/provider/navigation_provider.dart';
import 'package:turistear_aplication_v1/app/ui/page/home_page.dart';
import 'package:turistear_aplication_v1/app/ui/page/map_page.dart';
import 'package:turistear_aplication_v1/app/ui/page/profile_page.dart';

class DashboardOfFragments extends StatelessWidget {
  final List<Widget> _fragmentScreens = [
    const MyHomePage(),
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
      bottomNavigationBar: Consumer<NavigationProvider>(
        builder: (context, navigationProvider, child) {
          return BottomNavigationBar(
            currentIndex: navigationProvider.currentIndex,
            onTap: (value) {
              navigationProvider.setIndex(value);
            },
            showSelectedLabels: true,
            showUnselectedLabels: true,
            backgroundColor: Colors.grey,
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
    );
  }
}
