import 'package:flutter/material.dart';

import '../app/views/about_view.dart';
import '../app/views/home_view.dart';
import '../app/views/settings_view.dart';
import 'models/routing.dart';

final AppRouter router = AppRouter(routes: [
  AppRout(
    name: 'Home',
    path: '/',
    icon: Icons.home,
    componentBuilder: (context) => const HomeView(),
  ),
  AppRout(
    name: 'Settings',
    path: '/settings',
    icon: Icons.settings,
    componentBuilder: (context) => const SettingsView(),
  ),
  AppRout(
    name: 'About',
    path: '/about',
    icon: Icons.info,
    componentBuilder: (context) => const AboutView(),
  ),
]);
