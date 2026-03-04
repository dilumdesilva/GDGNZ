import 'package:flutter/material.dart';

import '../features/map/presentation/map_screen.dart';
import '../shared/theme/app_theme.dart';

class GdgNzApp extends StatelessWidget {
  const GdgNzApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GDG New Zealand',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const MapScreen(),
    );
  }
}
