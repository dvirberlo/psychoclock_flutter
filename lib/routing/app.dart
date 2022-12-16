import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';

import 'routes.dart';

class AppRoot extends StatelessWidget {
  final String path;
  const AppRoot({super.key, required this.path});

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      body: (context) =>
          routes.firstWhere((route) => route.path == path).component,
      selectedIndex: routes.indexWhere((route) => route.path == path),
      onSelectedIndexChange: (index) {
        Navigator.pushNamed(context, routes[index].path);
      },
      destinations: routes
          .map(
            (route) => NavigationDestination(
              icon: Icon(route.icon),
              selectedIcon: Icon(route.icon),
              label: route.name,
            ),
          )
          .toList(),
      internalAnimations: false,
      useDrawer: false,
    );
  }
}
