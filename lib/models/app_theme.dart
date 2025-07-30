import 'package:flutter/material.dart';

class AppTheme {
  final String name;
  final Brightness brightness;
  final Color primaryColor;
  final Color accentColor;
  final Color scaffoldBackgroundColor;
  final Color backgroundColor;
  final Color cardColor;
  final Color textColor;
  final Color secondaryTextColor;

  // Custom properties
  final Map<String, dynamic> customStyles;

  const AppTheme({
    required this.name,
    required this.brightness,
    required this.primaryColor,
    required this.accentColor,
    required this.scaffoldBackgroundColor,
    required this.backgroundColor,
    required this.cardColor,
    required this.textColor,
    required this.secondaryTextColor,
    this.customStyles = const {},
  });

  ThemeData toThemeData() {
    return ThemeData(
      brightness: brightness,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      cardColor: cardColor,
      textTheme: _buildTextTheme(),
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: scaffoldBackgroundColor,
        foregroundColor: textColor,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white, backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        ),
      ), colorScheme: ColorScheme.fromSwatch(
        brightness: brightness,
        primarySwatch: _createMaterialColor(primaryColor),
      ).copyWith(
        secondary: accentColor,
      ).copyWith(background: backgroundColor),
    );
  }

  TextTheme _buildTextTheme() {
    final baseTheme =
        brightness == Brightness.dark ? ThemeData.dark() : ThemeData.light();
    return baseTheme.textTheme.apply(
      displayColor: textColor,
      bodyColor: textColor,
    );
  }

  // Helper to create a MaterialColor from a single color
  static MaterialColor _createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = {};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }
}