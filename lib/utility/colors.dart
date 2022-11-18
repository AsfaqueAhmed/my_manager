import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LightThemeColor {
  LightThemeColor._();

  static const Color primaryColor = Colors.blueGrey;

  static final ThemeData theme = ThemeData.light(useMaterial3: true).copyWith(
      primaryColor: primaryColor,
      appBarTheme: const AppBarTheme(
        color: primaryColor,
        foregroundColor: Colors.white,
        centerTitle: true,
        actionsIconTheme: IconThemeData(color: Colors.white),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      textTheme: GoogleFonts.poppinsTextTheme(),
      floatingActionButtonTheme:
          const FloatingActionButtonThemeData(backgroundColor: primaryColor));
}
