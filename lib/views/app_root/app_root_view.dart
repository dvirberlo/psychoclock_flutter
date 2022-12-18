import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';

import '../../app_router.dart';

class AppRootView extends StatelessWidget {
  final String path;
  const AppRootView({super.key, required this.path});

  @override
  Widget build(BuildContext context) {
    final currentRouteIndex = router.getRouteIndex(path);
    final currentRoute = router.routes[currentRouteIndex];
    return AdaptiveScaffold(
      body: currentRoute.componentBuilder,
      selectedIndex: currentRouteIndex,
      onSelectedIndexChange: (index) {
        Navigator.pushNamed(context, router.routes[index].path);
      },
      destinations: router.routes
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
