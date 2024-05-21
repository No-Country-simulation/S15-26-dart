import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turistear_aplication_v1/app/api_connection/dio_instance.dart';
import 'package:turistear_aplication_v1/app/provider/theme_provider.dart';
import 'package:turistear_aplication_v1/app/ui/page/home.dart';
import 'package:turistear_aplication_v1/app/values/theme_app.dart';

void main() {
  DioInstance.configureDio();
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.themeMode,
      home: const MyHomePage(),
    );
  }
}
