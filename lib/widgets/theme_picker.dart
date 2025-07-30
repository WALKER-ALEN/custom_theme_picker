import 'package:custom_theme_picker/managers/theme_manager.dart';
import 'package:custom_theme_picker/models/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ThemePicker extends StatelessWidget {
  const ThemePicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: themeManager.availableThemes.length,
      itemBuilder: (context, index) {
        final theme = themeManager.availableThemes[index];
        final isSelected = theme.name == themeManager.currentTheme.name;

        return Card(
          elevation: isSelected ? 4 : 1,
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          color: isSelected ? theme.primaryColor.withOpacity(0.2) : theme.cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: isSelected
                ? BorderSide(color: theme.primaryColor, width: 2)
                : BorderSide.none,
          ),
          child: ListTile(
            onTap: () => themeManager.setTheme(theme.name),
            title: Text(
              theme.name,
              style: TextStyle(
                color: theme.textColor,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            leading: Radio<String>(
              value: theme.name,
              groupValue: themeManager.currentTheme.name,
              onChanged: (value) {
                if (value != null) {
                  themeManager.setTheme(value);
                }
              },
              activeColor: theme.primaryColor,
            ),
            trailing: _ThemeSwatch(theme: theme),
          ),
        );
      },
    );
  }
}

class _ThemeSwatch extends StatelessWidget {
  final AppTheme theme;
  const _ThemeSwatch({Key? key, required this.theme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _ColorDot(color: theme.primaryColor),
        const SizedBox(width: 4),
        _ColorDot(color: theme.accentColor),
        const SizedBox(width: 4),
        _ColorDot(color: theme.backgroundColor),
      ],
    );
  }
}

class _ColorDot extends StatelessWidget {
  final Color color;
  const _ColorDot({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(
          color: Theme.of(context).dividerColor,
          width: 1,
        ),
      ),
    );
  }
}