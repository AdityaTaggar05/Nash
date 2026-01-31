import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      scaffoldBackgroundColor: Color(0xff111111),
      appBarTheme: AppBarTheme(
        backgroundColor: Color(0xff111111),
        shape: Border(bottom: BorderSide(color: Color(0xff606060), width: 4.0)),
      ),
      colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: Color(0xff8bf825),
        secondary: Color(0xfff9ac41),
        surface: Color(0xff222222),
        secondaryContainer: Color(0xff404040),
        error: Color(0xffff3131),
        onPrimary: Color(0xff111111),
        onSecondary: Color(0xff111111),
        onSurface: Color(0xffe5e5e5),
        onSurfaceVariant: Color(0xff808080),
        onError: Color(0xffe5e5e5),
        onSecondaryContainer: Color(0xffe5e5e5),
      ),
      cardTheme: CardThemeData(
        color: Color(0xff222222),
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
