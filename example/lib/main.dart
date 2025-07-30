import 'package:custom_theme_picker/managers/theme_manager.dart';
import 'package:custom_theme_picker/themes/predefined_themes.dart';
import 'package:custom_theme_picker/widgets/theme_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// The main function must be async to await the ThemeManager creation.
Future<void> main() async {
  // This is required to ensure plugins are initialized before runApp.
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Create the ThemeManager instance before running the app.
  final themeManager = await ThemeManager.create(
    themes: PredefinedThemes.all,
    defaultThemeName: 'Light',
  );

  // 2. Use ChangeNotifierProvider.value to provide the existing instance.
  runApp(
    ChangeNotifierProvider.value(value: themeManager, child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // The Consumer widget listens for changes in the ThemeManager
    return Consumer<ThemeManager>(
      builder: (context, themeManager, child) {
        return MaterialApp(
          title: 'Theme Manager Demo',
          theme: themeManager.currentTheme.toThemeData(),
          home: const HomePage(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeManager>(context).currentTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme Manager Demo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => const SettingsPage()));
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome!',
              // CORRECTED: headline4 -> headlineMedium
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'This is a demonstration of the Advanced Theming and Style Manager package. Change the theme from the settings page.',
              // CORRECTED: subtitle1 -> titleMedium
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: theme.secondaryTextColor,
              ),
            ),
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sample Card',
                      // CORRECTED: headline6 -> titleLarge
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    const Text('This card uses the theme\'s cardColor.'),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: const Text('Action 1'),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text('Action 2'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            Center(
              child: FloatingActionButton.extended(
                onPressed: () {},
                icon: const Icon(Icons.color_lens),
                label: const Text('Accent Color'),
                backgroundColor: theme.accentColor,
                foregroundColor: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Choose a Theme',
                // CORRECTED: headline6 -> titleLarge
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              const ThemePicker(),
            ],
          ),
        ),
      ),
    );
  }
}
