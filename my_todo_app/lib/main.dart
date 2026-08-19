import 'package:flutter/material.dart';
import 'package:my_todo_app/main_app.dart';
import 'package:my_todo_app/providers/theme_notifier.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final themeNotifier = ThemeNotifier();
  await themeNotifier.loadTheme();

  runApp(
    ChangeNotifierProvider.value(value: themeNotifier, child: const MainApp()),
  );
}
