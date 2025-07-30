import 'package:custom_theme_picker/models/app_theme.dart';
import 'package:flutter/material.dart';


class PredefinedThemes {
  static final AppTheme lightTheme = AppTheme(
    name: 'Light',
    brightness: Brightness.light,
    primaryColor: const Color(0xFF6200EE),
    accentColor: const Color(0xFF03DAC6),
    scaffoldBackgroundColor: const Color(0xFFF5F5F5),
    backgroundColor: Colors.white,
    cardColor: Colors.white,
    textColor: Colors.black87,
    secondaryTextColor: Colors.black54,
  );

  static final AppTheme darkTheme = AppTheme(
    name: 'Dark',
    brightness: Brightness.dark,
    primaryColor: const Color(0xFFBB86FC),
    accentColor: const Color(0xFF03DAC6),
    scaffoldBackgroundColor: const Color(0xFF121212),
    backgroundColor: const Color(0xFF1E1E1E),
    cardColor: const Color(0xFF1E1E1E),
    textColor: Colors.white.withOpacity(0.87),
    secondaryTextColor: Colors.white.withOpacity(0.60),
  );

  static final AppTheme oledTheme = AppTheme(
    name: 'OLED',
    brightness: Brightness.dark,
    primaryColor: const Color(0xFFCF6679),
    accentColor: const Color(0xFF03DAC6),
    scaffoldBackgroundColor: Colors.black,
    backgroundColor: Colors.black,
    cardColor: const Color(0xFF1A1A1A),
    textColor: Colors.white.withOpacity(0.9),
    secondaryTextColor: Colors.white.withOpacity(0.7),
  );
  
  static final AppTheme nordTheme = AppTheme(
    name: 'Nord',
    brightness: Brightness.dark,
    primaryColor: const Color(0xFF88C0D0),
    accentColor: const Color(0xFF8FBCBB),
    scaffoldBackgroundColor: const Color(0xFF2E3440),
    backgroundColor: const Color(0xFF3B4252),
    cardColor: const Color(0xFF434C5E),
    textColor: const Color(0xFFD8DEE9),
    secondaryTextColor: const Color(0xFFE5E9F0),
  );

  static List<AppTheme> get all => [lightTheme, darkTheme, oledTheme, nordTheme];
}