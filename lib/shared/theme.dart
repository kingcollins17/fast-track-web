import 'package:flutter/material.dart';

// colors
const defranc = Color(0xFF0091EA);
const cyan = Color(0xFF56B7E0);
const cobaltBlue = Color(0xFF0D46A0);
const mikadoYellow = Color(0xFFFEC400);
const vermilion = Color(0xFFDC2C00);

// backgrounds
const codgray = Color(0xFF0B0B0B); // light
const woodsmoke = Color(0xFF121212); // lighter
const eerieBlack = Color(0xFF1B1B1B); // lightest

abstract class FastTrackTheme {
  static final light = ThemeData(
    fontFamily: 'OpenSans',
    colorScheme: const ColorScheme.light(
      primary: defranc,
      secondary: cobaltBlue,
    ),
  );
  static final dark = ThemeData(
    fontFamily: 'OpenSans',
    colorScheme: const ColorScheme.dark(
      primary: defranc,
      secondary: cobaltBlue,
    ),
  );
  static final mode = ValueNotifier(ThemeMode.dark);

  static void setLightMode() => mode.value = ThemeMode.light;
  static void setDarkMode() => mode.value = ThemeMode.dark;
}
