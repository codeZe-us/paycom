import 'package:flutter/material.dart';

import 'src/core/constants/routes/route_generator.dart';
import 'src/core/global_variables.dart';
import 'src/core/theme/main_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      onGenerateRoute: RouteGenerator.onGenerateRoute,
      onUnknownRoute: RouteGenerator.unKnownRoute,
      theme: AppTheme.primaryTheme,
    );
  }
}
