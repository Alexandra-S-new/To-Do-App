import 'package:flutter/material.dart';
import 'package:my_todo_app/services/preferences_service.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  ThemeMode get themeMode => _themeMode;

  Future<void> loadTheme() async {
    final isDark = await PreferencesTodo.loadDarkMode();

    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;

    notifyListeners();
  }

  void setThemeMode() async {
    if (_themeMode == ThemeMode.light) {
      _themeMode = ThemeMode.dark;
    } else {
      _themeMode = ThemeMode.light;
    }
    await PreferencesTodo.setDarkMode(_themeMode == ThemeMode.dark);
    notifyListeners();
  }
}
