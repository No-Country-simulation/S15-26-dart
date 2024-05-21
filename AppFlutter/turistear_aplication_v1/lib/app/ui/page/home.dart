import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turistear_aplication_v1/app/provider/theme_provider.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Theme Switcher'),
        actions: [
          Switch(
            value: themeProvider.themeMode == ThemeMode.dark,
            onChanged: (value) {
              themeProvider.toggleTheme();
            },
          ),
        ],
      ),
      body: const Center(
        child: Text('Hello World'),
      ),
    );
  }
}
