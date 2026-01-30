import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      scaffoldBackgroundColor: Color.from(
        alpha: 1,
        red: 17 / 255,
        green: 17 / 255,
        blue: 17 / 255,
      ),
      colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: Color.from(
          alpha: 1,
          red: 139 / 255,
          green: 248 / 255,
          blue: 37 / 255,
        ),
        secondary: Color.from(
          alpha: 1,
          red: 249 / 255,
          green: 172 / 255,
          blue: 65 / 255,
        ),
        surface: Color.from(
          alpha: 1,
          red: 34 / 255,
          green: 34 / 255,
          blue: 34 / 255,
        ),
        secondaryContainer: Color.from(
          alpha: 1,
          red: 64 / 255,
          blue: 64 / 255,
          green: 64 / 255,
        ),
        error: Color.from(
          alpha: 1,
          red: 255 / 255,
          green: 49 / 255,
          blue: 49 / 255,
        ),
        onPrimary: Color.from(
          alpha: 1,
          red: 17 / 255,
          green: 17 / 255,
          blue: 17 / 255,
        ),
        onSecondary: Color.from(
          alpha: 1,
          red: 17 / 255,
          green: 17 / 255,
          blue: 17 / 255,
        ),
        onSurface: Color.from(
          alpha: 1,
          red: 229 / 255,
          green: 229 / 255,
          blue: 229 / 255,
        ),
        onSurfaceVariant: Color.from(
          alpha: 1,
          red: 128 / 255,
          green: 128 / 255,
          blue: 128 / 255,
        ),
        onError: Color.from(
          alpha: 1,
          red: 229 / 255,
          green: 229 / 255,
          blue: 229 / 255,
        ),
        onSecondaryContainer: Color.from(
          alpha: 1,
          red: 229 / 255,
          green: 229 / 255,
          blue: 229 / 255,
        ),
      ),
      cardTheme: CardThemeData(
        color: Color.from(
          alpha: 1,
          red: 34 / 255,
          green: 34 / 255,
          blue: 34 / 255,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.0),
        ),
      ),
      textTheme: GoogleFonts.poppinsTextTheme(),
    );
  }
}

extension ThemeGetter on BuildContext {
  ThemeData get theme => Theme.of(this);

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  TextTheme get textTheme => Theme.of(this).textTheme;

  Color get scaffoldBackgroundColor => Theme.of(this).scaffoldBackgroundColor;
}
