import 'package:flutter/material.dart';
import 'package:psychoclock/views/about/about_view.dart';
import 'package:psychoclock/views/home/home_view.dart';
import 'package:psychoclock/views/settings/settings_view.dart';

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
