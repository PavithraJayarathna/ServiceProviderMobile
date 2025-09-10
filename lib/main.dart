import 'package:flutter/material.dart';
import 'core/app_theme.dart';
import 'core/app_routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const FurGloProApp());
}

class FurGloProApp extends StatelessWidget {
  const FurGloProApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FurGlo Pro',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.initialRoute,
      routes: AppRoutes.routes,
    );
  }
}