import 'package:flutter/material.dart';

class AppTheme {
  static const _buttonShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
  );

  static const _contrast0 = Color.fromARGB(255, 0, 0, 0);
  static const _contrast1 = Color.fromARGB(255, 255, 255, 255);

  static ThemeData _generateTheme(ThemeData coloredTheme) {
    final colors = coloredTheme.colorScheme;
    final halfPrime = colors.primary.withOpacity(0.5);
    final Color black, onBlack;
    switch (coloredTheme.brightness) {
      case Brightness.dark:
        black = Color.alphaBlend(_contrast0.withOpacity(0.9), colors.primary);
        onBlack = _contrast1;
        break;
      case Brightness.light:
        black = Color.alphaBlend(_contrast1.withOpacity(0.9), colors.primary);
        onBlack = _contrast0;
        break;
    }
    return coloredTheme.copyWith(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      textTheme: coloredTheme.textTheme.copyWith(
        headline1: coloredTheme.textTheme.headline1
            ?.copyWith(fontSize: 72.0, fontWeight: FontWeight.bold),
        headline6: coloredTheme.textTheme.headline6
            ?.copyWith(fontSize: 36.0, fontStyle: FontStyle.italic),
        bodyText2: coloredTheme.textTheme.bodyText2
            ?.copyWith(fontSize: 14.0, fontFamily: 'Hind'),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: colors.primary,
        textTheme: ButtonTextTheme.primary,
        shape: _buttonShape,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: colors.primary,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        backgroundColor: black,
        unselectedItemColor: onBlack,
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: colors.surface,
        indicatorColor: halfPrime,
        // TODO: the material adaptive scaffold has some issues with the theming of the navigation rail
        // unselectedLabelTextStyle: TextStyle(color: colors.onSurface, fontSize: 21),
        unselectedLabelTextStyle: TextStyle(color: colors.onSurface),
        labelType: NavigationRailLabelType.selected,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.selected)) {
              return colors.primary;
            }
            return colors.onSurface;
          },
        ),
        trackColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.selected)) {
              return halfPrime;
            }
            return colors.onSurface.withOpacity(0.5);
          },
        ),
      ),
    );
  }

  static ThemeData withColorScheme(ColorScheme scheme) {
    return _generateTheme(
      ThemeData(
        colorScheme: scheme,
        fontFamily: 'Roboto',
        useMaterial3: true,
      ),
    );
  }

  static final dark = _generateTheme(_darkColors);
  static final light = _generateTheme(_lightColors);

// rgb of #a8d800 is 168, 216, 0
  // static const _appColor = Color.fromARGB(255, 204, 255, 0);
  static const _appColor = Color.fromARGB(255, 168, 216, 0);
  static final _darkColors = ThemeData(
    fontFamily: 'Roboto',
    colorSchemeSeed: _appColor,
    brightness: Brightness.dark,
    useMaterial3: true,
  );
  static final _lightColors = ThemeData(
    fontFamily: 'Roboto',
    colorSchemeSeed: _appColor,
    brightness: Brightness.light,
    useMaterial3: true,
  );
}
