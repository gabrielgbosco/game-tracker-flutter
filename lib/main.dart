import 'package:flutter/material.dart';

import 'screens/dashboard_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const GameTrackerApp());
}

/// Widget raiz do aplicativo Game Tracker.
class GameTrackerApp extends StatelessWidget {
  const GameTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Game Tracker',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.themeData,
      home: const DashboardScreen(),
    );
  }
}
