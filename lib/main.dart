import 'package:flutter/material.dart';

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
      theme: ThemeData(useMaterial3: true),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
            builder: (context) => AppRootView(path: settings.name ?? '/'));
      },
    );
  }
}
