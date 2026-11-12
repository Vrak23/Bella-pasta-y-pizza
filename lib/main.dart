import 'package:flutter/material.dart';
import 'utils/app_routes.dart';
import 'utils/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const BellaPastaPizzaApp());
}

class BellaPastaPizzaApp extends StatelessWidget {
  const BellaPastaPizzaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bella Pasta & Pizza',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.splash,
      routes: AppRoutes.routes,
    );
  }
}
