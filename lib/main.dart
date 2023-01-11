import 'package:flutter/material.dart';

import 'core/root_view.dart';
import 'core/theme/theme.dart';
import 'package:dynamic_color/dynamic_color.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
        builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
      return MaterialApp(
        title: 'PsychoClock',
        theme: lightDynamic == null
            ? AppTheme.light
            : AppTheme.withColorScheme(lightDynamic),
        darkTheme: darkDynamic == null
            ? AppTheme.dark
            : AppTheme.withColorScheme(darkDynamic),
        themeMode: ThemeMode.system,
        initialRoute: '/',
        onGenerateRoute: (settings) {
          return AppPageRoute(
            builder: (context) => AppRootView(path: settings.name ?? '/'),
          );
        },
        debugShowCheckedModeBanner: false,
      );
    });
  }
}
