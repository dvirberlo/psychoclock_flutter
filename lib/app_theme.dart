import 'package:flutter/material.dart';

const primary = Colors.blue;
const secondary = Colors.amber;
const error = Colors.red;
const surface = Colors.black;
const text = Colors.white;
const textDark = Colors.black;
final appDarkTheme = ThemeData(
  useMaterial3: true,
  primarySwatch: primary,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  fontFamily: 'Roboto',
  textTheme: const TextTheme(
    headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
    headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
    bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
  ),
  iconTheme: const IconThemeData(color: text),
  colorScheme: const ColorScheme.dark(
    primary: primary,
    secondary: secondary,
    error: error,
    surface: surface,
    background: surface,
    onPrimary: textDark,
    onSecondary: textDark,
    onError: text,
    onSurface: text,
    onBackground: text,
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: primary,
    textTheme: ButtonTextTheme.primary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: surface,
    selectedItemColor: primary,
    unselectedItemColor: text,
    showUnselectedLabels: true,
    showSelectedLabels: true,
  ),
  navigationRailTheme: const NavigationRailThemeData(
    backgroundColor: surface,
    indicatorColor: primary,
    selectedIconTheme: IconThemeData(color: primary),
    unselectedIconTheme: IconThemeData(color: text),
    selectedLabelTextStyle: TextStyle(color: text),
    unselectedLabelTextStyle: TextStyle(color: text),
    labelType: NavigationRailLabelType.selected,
  ),
  switchTheme: SwitchThemeData(
    thumbColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return primary;
        }
        return text;
      },
    ),
    trackColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return primary.withOpacity(0.5);
        }
        return text.withOpacity(0.5);
      },
    ),
  ),
);
