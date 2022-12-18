import 'package:flutter/material.dart';

class AppRout {
  const AppRout({
    required this.name,
    required this.path,
    required this.icon,
    required this.componentBuilder,
  });
  final String name;
  final String path;
  final IconData icon;
  final Widget Function(BuildContext) componentBuilder;
}

class AppRouter {
  final List<AppRout> routes;
  AppRouter({required this.routes});

  AppRout getRoute(String path) {
    return routes.firstWhere((route) => route.path == path);
  }

  int getRouteIndex(String path) {
    return routes.indexWhere((route) => route.path == path);
  }
}
