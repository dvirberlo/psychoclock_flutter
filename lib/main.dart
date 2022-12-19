import 'package:flutter/material.dart';

import 'app_theme.dart';
import 'views/app_root/app_root_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PsychoClock',
      theme: appDarkTheme,
      initialRoute: '/',
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
            builder: (context) => AppRootView(path: settings.name ?? '/'));
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
