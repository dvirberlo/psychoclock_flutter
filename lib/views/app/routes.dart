import 'package:flutter/material.dart';
import 'package:psychoclock/views/about/about_view.dart';
import 'package:psychoclock/views/home/home_view.dart';
import 'package:psychoclock/views/settings/settings_view.dart';

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
    component: HomeView(),
  ),
  Routing(
    name: 'Settings',
    path: '/settings',
    icon: Icons.settings,
    component: SettingsView(),
  ),
  Routing(
    name: 'About',
    path: '/about',
    icon: Icons.info,
    component: AboutView(),
  ),
];
