import 'package:custom_theme_picker/managers/theme_manager.dart';
import 'package:custom_theme_picker/themes/predefined_themes.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  // This is a critical line. It ensures that the Flutter testing framework
  // is initialized, which is required for SharedPreferences to work in tests.
  TestWidgetsFlutterBinding.ensureInitialized();

  group('ThemeManager', () {
    // Test case 1: Check if the manager initializes with the default theme
    // when there's nothing saved in storage.
    test('initializes with default theme when no theme is saved', () async {
      // Arrange: We set the mock initial values to an empty map to simulate
      // a fresh install.
      SharedPreferences.setMockInitialValues({});

      // Act: Create the manager instance.
      final themeManager = await ThemeManager.create(
        themes: PredefinedThemes.all,
        defaultThemeName: 'Light',
      );

      // Assert: The current theme should be the default 'Light' theme.
      expect(themeManager.currentTheme.name, 'Light');
    });

    // Test case 2: Check if the manager correctly loads a theme that was
    // previously saved to storage.
    test('loads saved theme from storage on initialization', () async {
      // Arrange: We set the mock initial values to contain a saved theme.
      SharedPreferences.setMockInitialValues({'app_theme': 'OLED'});

      // Act: Create the manager. It should read this value during its init process.
      final themeManager = await ThemeManager.create(
        themes: PredefinedThemes.all,
        defaultThemeName: 'Light', // The default should be ignored
      );

      // Assert: The current theme should be 'OLED', not the default.
      expect(themeManager.currentTheme.name, 'OLED');
    });

    // Test case 3: Check if changing the theme updates the state and
    // notifies any listeners.
    test('setTheme updates current theme and notifies listeners', () async {
      // Arrange: Start with an empty storage and create the manager.
      SharedPreferences.setMockInitialValues({});
      final themeManager = await ThemeManager.create(
        themes: PredefinedThemes.all,
        defaultThemeName: 'Light',
      );

      bool listenerWasCalled = false;
      themeManager.addListener(() {
        listenerWasCalled = true;
      });

      // Act: Call the method to change the theme.
      themeManager.setTheme('Dark');

      // Assert: The theme should be updated in the manager, and the listener
      // should have been triggered.
      expect(themeManager.currentTheme.name, 'Dark');
      expect(listenerWasCalled, isTrue);
    });

    // Test case 4: We can infer saving works if loading works. This test
    // combines setting and then reloading to confirm the save-load loop.
    test('setTheme saves the theme, which is loaded by a new instance', () async {
      // Arrange: Start with an empty storage and create the first manager.
      SharedPreferences.setMockInitialValues({});
      final firstManager = await ThemeManager.create(
        themes: PredefinedThemes.all,
        defaultThemeName: 'Light',
      );

      // Act 1: Set the theme. This should save 'Nord' to our mock storage.
      firstManager.setTheme('Nord');
      expect(firstManager.currentTheme.name, 'Nord');

      // Act 2: Create a *new* manager instance. It should load the value
      // that the first instance just saved.
      final secondManager = await ThemeManager.create(
        themes: PredefinedThemes.all,
        defaultThemeName: 'Light',
      );

      // Assert: The second manager's theme should be the one saved by the first.
      expect(secondManager.currentTheme.name, 'Nord');
    });
  });
}
