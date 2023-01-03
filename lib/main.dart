import 'package:flutter/material.dart';

import 'core/root_view.dart';
import 'core/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PsychoClock',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      initialRoute: '/',
      onGenerateRoute: (settings) {
        return AppPageRoute(
          builder: (context) => AppRootView(path: settings.name ?? '/'),
        );
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
