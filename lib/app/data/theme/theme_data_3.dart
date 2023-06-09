// This theme was made for FlexColorScheme version 6.1.1. Make sure
// you use same or higher version, but still same major version. If
// you use a lower version, some properties may not be supported. In
// that case you can also remove them after copying the theme to your app.
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

class CustomeThemeDeepPurple {
  ThemeData lightTheme = FlexThemeData.light(
    appBarElevation: 2,
    scheme: FlexScheme.deepPurple,
    surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
    blendLevel: 9,
    tooltipsMatchBackground: true,
    subThemesData: const FlexSubThemesData(
      useFlutterDefaults: true,
      defaultRadius: 4.0,
      sliderTrackHeight: 1,
    ),
    keyColors: const FlexKeyColors(),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    useMaterial3: true,
    swapLegacyOnMaterial3: true,
    // To use the playground font, add GoogleFonts package and uncomment
    // fontFamily: GoogleFonts.notoSans().fontFamily,
  );
  ThemeData darkTheme = FlexThemeData.dark(
    scheme: FlexScheme.deepPurple,
    surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
    blendLevel: 15,
    swapColors: true,
    tooltipsMatchBackground: true,
    subThemesData: const FlexSubThemesData(
      useFlutterDefaults: true,
      defaultRadius: 4.0,
      sliderTrackHeight: 1,
    ),
    keyColors: const FlexKeyColors(),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    useMaterial3: true,
    swapLegacyOnMaterial3: true,
    // To use the Playground font, add GoogleFonts package and uncomment
    // fontFamily: GoogleFonts.notoSans().fontFamily,
  );
// If you do not have a themeMode switch, uncomment this line
// to let the device system mode control the theme mode:
// themeMode: ThemeMode.system,
}
