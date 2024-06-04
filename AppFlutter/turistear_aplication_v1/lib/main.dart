import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:turistear_aplication_v1/app/api_connection/dio_instance.dart';
import 'package:turistear_aplication_v1/app/provider/navigation_provider.dart';
import 'package:turistear_aplication_v1/app/provider/theme_provider.dart';
import 'package:turistear_aplication_v1/app/ui/dashboard_of_fragments.dart';
import 'package:turistear_aplication_v1/app/values/theme_app.dart';

void main() {
  DioInstance.configureDio();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return ScreenUtilInit(
      designSize: const Size(360, 690), // Ajusta según tu diseño
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeProvider.themeMode,
          home: DashboardOfFragments(),
        );
      },
      child: DashboardOfFragments(),
    );
  }
}
