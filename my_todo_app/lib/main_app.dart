import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:my_todo_app/providers/theme_notifier.dart';
import 'package:my_todo_app/screens/app_theme.dart';
import 'package:my_todo_app/screens/my_todo_app_screen.dart';
import 'package:provider/provider.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, child) {
        return MaterialApp(
          key: ValueKey(themeNotifier.themeMode),
          debugShowCheckedModeBanner: false,
          title: 'Meine ToDo App',
          locale: const Locale('de', 'DE'),
          localizationsDelegates: GlobalMaterialLocalizations.delegates,
          supportedLocales: const [Locale('de', 'DE')],
          themeMode: themeNotifier.themeMode,
          theme: AppTheme.lightTheme(),
          darkTheme: AppTheme.darkTheme(),
          home: const MyTodoApp(),
        );
      },
    );
  }
}
