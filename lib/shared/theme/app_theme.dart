import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTheme {
  static ThemeData get light => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.googleBlue),
        scaffoldBackgroundColor: AppColors.background,
        textTheme: GoogleFonts.openSansTextTheme(),
      );
}
