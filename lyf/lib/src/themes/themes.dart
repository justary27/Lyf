import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lyfTheme = ThemeData();
// Map<int, Color> monochromeThemeColors = {
//   50: const Color(0xFFFAFAFA),
//   100: const Color(0xFFF5F5F5),
//   200: const Color(0xFFEEEEEE),
//   300: const Color(0xFFE0E0E0),
//   350: const Color(0xFFD6D6D6),
//   400: const Color(0xFFBDBDBD),
//   600: const Color(0xFF757575),
//   700: const Color(0xFF616161),
//   800: const Color(0xFF424242),
//   850: const Color(0xFF303030),
//   900: const Color(0xFF212121),
// };

ThemeData monochromeTheme = ThemeData(
  primaryColor: Colors.grey,
  shadowColor: Colors.black,
  cardColor: Colors.white.withOpacity(0.15),
  textTheme: TextTheme(
    headline1: GoogleFonts.ubuntu(
      textStyle: const TextStyle(color: Colors.white, fontSize: 50),
    ),
    headline2: GoogleFonts.ubuntu(
      textStyle: const TextStyle(color: Colors.white, fontSize: 25),
    ),
    headline3: GoogleFonts.ubuntu(
      textStyle: const TextStyle(color: Colors.white, fontSize: 20),
    ),
    headline4: GoogleFonts.ubuntu(
      textStyle: const TextStyle(color: Colors.white, fontSize: 17.5),
    ),
    headline5: GoogleFonts.ubuntu(
      textStyle: const TextStyle(color: Colors.white, fontSize: 15),
    ),
    bodyText1: GoogleFonts.aBeeZee(
      textStyle: TextStyle(
        color: Colors.white.withOpacity(0.4),
      ),
    ),
    bodyText2: GoogleFonts.aBeeZee(
      textStyle: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 12),
    ),
    button: GoogleFonts.ubuntu(),
  ),
);
