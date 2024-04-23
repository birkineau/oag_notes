import 'package:flutter/material.dart';

class NotesTheme {
  static final lightTheme = ThemeData(
    brightness: colorScheme.brightness,
    colorScheme: colorScheme,
    textButtonTheme: TextButtonThemeData(style: textButtonStyle),
    filledButtonTheme: FilledButtonThemeData(style: filledButtonStyle),
    iconButtonTheme: const IconButtonThemeData(style: iconButtonStyle),
    textTheme: textTheme,
    iconTheme: iconTheme,
    inputDecorationTheme: inputDecorationTheme,
  );

  static const _mutedGrey = Color.fromARGB(255, 60, 60, 60);

  static const iconTheme = IconThemeData(color: _mutedGrey, size: 20.0);

  static const inputDecorationTheme = InputDecorationTheme(
    contentPadding: EdgeInsets.only(bottom: 4.0),
    border: InputBorder.none,
    isDense: true,
    isCollapsed: true,
    hintStyle: TextStyle(color: Color.fromARGB(255, 190, 190, 190)),
    labelStyle: TextStyle(fontSize: 16.0),
  );

  static const textTheme = TextTheme(
    headlineLarge: TextStyle(fontSize: 40.0, color: _mutedGrey),
    headlineMedium: TextStyle(fontSize: 36.0, color: _mutedGrey),
    headlineSmall: TextStyle(fontSize: 32.0, color: _mutedGrey),
    titleLarge: TextStyle(fontSize: 28.0, color: _mutedGrey),
    titleMedium: TextStyle(fontSize: 24.0, color: _mutedGrey),
    titleSmall: TextStyle(fontSize: 20.0, color: _mutedGrey),
    bodyLarge: TextStyle(fontSize: 18.0),
    bodyMedium: TextStyle(fontSize: 16.0),
    bodySmall: TextStyle(fontSize: 14.0),
  );

  static const colorScheme = ColorScheme(
    brightness: Brightness.light,
    background: Color.fromARGB(255, 238, 238, 238),
    onBackground: Colors.black,
    primary: Color.fromARGB(255, 133, 200, 254),
    onPrimary: Colors.black,
    secondary: Color.fromARGB(255, 155, 159, 254),
    onSecondary: Colors.black,
    surface: Color.fromARGB(255, 231, 231, 231),
    onSurface: Colors.black,
    error: Color.fromARGB(255, 255, 65, 51),
    onError: Colors.white,
    primaryContainer: Color.fromARGB(255, 248, 248, 248),
    onPrimaryContainer: Color.fromARGB(255, 64, 64, 64),
  );

  static final textButtonStyle = ButtonStyle(
    tapTargetSize: MaterialTapTargetSize.padded,
    splashFactory: InkSparkle.splashFactory,
    padding: const MaterialStatePropertyAll(
      EdgeInsets.symmetric(horizontal: 8.0),
    ),
    shape: MaterialStatePropertyAll(_defaultRoundedBorder),
    foregroundColor: const MaterialStatePropertyAll(Colors.blue),
    textStyle: const MaterialStatePropertyAll(
      TextStyle(fontWeight: FontWeight.w500),
    ),
    maximumSize: const MaterialStatePropertyAll(Size(double.infinity, 48.0)),
    enableFeedback: false,
  );

  static final filledButtonStyle = ButtonStyle(
    tapTargetSize: MaterialTapTargetSize.padded,
    splashFactory: InkSparkle.splashFactory,
    padding: const MaterialStatePropertyAll(
      EdgeInsets.symmetric(horizontal: 8.0),
    ),
    shape: MaterialStatePropertyAll(_defaultRoundedBorder),
    maximumSize: const MaterialStatePropertyAll(Size(double.infinity, 48.0)),
    enableFeedback: false,
  );

  static const iconButtonStyle = ButtonStyle(
    enableFeedback: false,
  );

  static final _defaultRoundedBorder = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(8.0),
  );
}
