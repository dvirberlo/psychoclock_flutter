import 'package:flutter/material.dart';

class Routing {
  const Routing({
    required this.name,
    required this.path,
    required this.icon,
    required this.component,
  });
  final String name;
  final String path;
  final Widget component;
  final IconData icon;
}

const List<Routing> routes = [
  Routing(
    name: 'Home',
    path: '/',
    icon: Icons.home,
    component: Center(
      child: Text('Home'),
    ),
  ),
  Routing(
    name: 'Settings',
    path: '/settings',
    icon: Icons.settings,
    component: Center(
      child: Text('Settings'),
    ),
  ),
  Routing(
    name: 'About',
    path: '/about',
    icon: Icons.info,
    component: Center(
      child: Text('About'),
    ),
  ),
];
