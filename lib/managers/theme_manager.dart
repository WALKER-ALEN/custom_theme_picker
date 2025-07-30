// --- FILE: lib/managers/theme_manager.dart ---
// CORRECTED VERSION

import 'package:custom_theme_picker/models/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeManager extends ChangeNotifier {
  static const String _themePrefKey = 'app_theme';

  AppTheme _currentTheme;
  final List<AppTheme> _themes;
  late SharedPreferences _prefs;

  // The constructor is now private.
  ThemeManager._({
    required List<AppTheme> themes,
    required AppTheme defaultTheme,
  }) : _themes = themes,
       _currentTheme = defaultTheme;

  // This is the new, public way to create a ThemeManager.
  static Future<ThemeManager> create({
    required List<AppTheme> themes,
    required String defaultThemeName,
  }) async {
    final defaultTheme = themes.firstWhere(
      (t) => t.name == defaultThemeName,
      orElse: () => themes.first,
    );

    final manager = ThemeManager._(themes: themes, defaultTheme: defaultTheme);
    await manager._init();
    return manager;
  }

  // This method now loads the theme from storage.
  Future<void> _init() async {
    _prefs = await SharedPreferences.getInstance();
    final savedThemeName = _prefs.getString(_themePrefKey);
    if (savedThemeName != null) {
      final theme = _themes.firstWhere(
        (t) => t.name == savedThemeName,
        orElse: () => _currentTheme,
      );
      _currentTheme = theme;
      // No need to notify listeners here, as it's part of initial setup.
    }
  }

  AppTheme get currentTheme => _currentTheme;
  List<AppTheme> get availableThemes => _themes;

  Future<void> _saveTheme(String themeName) async {
    await _prefs.setString(_themePrefKey, themeName);
  }

  void setTheme(String themeName) {
    final newTheme = _themes.firstWhere(
      (t) => t.name == themeName,
      orElse: () => _currentTheme,
    );

    if (newTheme.name != _currentTheme.name) {
      _currentTheme = newTheme;
      _saveTheme(themeName);
      notifyListeners();
    }
  }
}
