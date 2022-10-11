import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lyf/src/utils/helpers/theme_helper.dart';

ThemeHelper lyfTheme = ThemeHelper(
  themeData: ThemeData(
    primaryColor: Color.fromARGB(255, 14, 105, 87),
    shadowColor: Colors.black,
    cardColor: Color(0xFF7DF6AD).withOpacity(0.15),
    splashColor: Color.fromARGB(255, 14, 105, 87).withOpacity(0.35),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    listTileTheme: ListTileThemeData(
      tileColor: const Color.fromARGB(255, 14, 105, 87).withOpacity(0.15),
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: const Color.fromARGB(255, 14, 105, 87),
      circularTrackColor:
          const Color.fromARGB(255, 14, 105, 87).withOpacity(0.15),
    ),
    textTheme: TextTheme(
      headline1: GoogleFonts.merienda(
        textStyle: const TextStyle(
            color: Color.fromARGB(255, 14, 105, 87), fontSize: 40),
      ),
      headline2: GoogleFonts.merienda(
        textStyle: const TextStyle(color: Colors.white, fontSize: 25),
      ),
      headline3: GoogleFonts.merienda(
        textStyle: const TextStyle(color: Colors.white, fontSize: 20),
      ),
      headline4: GoogleFonts.merienda(
        textStyle: const TextStyle(color: Colors.white, fontSize: 17.5),
      ),
      headline5: GoogleFonts.merienda(
        textStyle: const TextStyle(color: Colors.white, fontSize: 15),
      ),
      bodyText1: GoogleFonts.aBeeZee(
        textStyle: TextStyle(
          color: Colors.white.withOpacity(0.4),
        ),
      ),
      bodyText2: GoogleFonts.aBeeZee(
        textStyle:
            TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 12),
      ),
      button: GoogleFonts.ubuntu(),
    ),
  ),
  gradientColors: const [
    Color(0xFFB5FF00),
    Color(0xFF1FC192),
    Color(0xFF03B797),
  ],
);

ThemeHelper monochromeTheme = ThemeHelper(
  themeData: ThemeData(
    primaryColor: Colors.white,
    shadowColor: Colors.black,
    cardColor: Colors.white.withOpacity(0.15),
    splashColor: Colors.white.withOpacity(0.35),
    listTileTheme: ListTileThemeData(
      tileColor: Colors.white.withOpacity(0.15),
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: Colors.white,
      circularTrackColor: Colors.white.withOpacity(0.15),
    ),
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
        textStyle:
            TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 12),
      ),
      button: GoogleFonts.ubuntu(),
    ),
  ),
  gradientColors: const [
    Color(0xFF616161),
    Color(0xFF212121),
    Color(0xFF000000),
  ],
);
ThemeHelper funkyTheme = ThemeHelper(
  themeData: ThemeData(
    primaryColor: const Color(0xFFCA81F5),
    splashColor: const Color(0xFFCA81F5).withOpacity(0.35),
    cardColor: const Color(0xFFCA81F5).withOpacity(0.10),
    listTileTheme: ListTileThemeData(
      tileColor: const Color(0xFFCA81F5).withOpacity(0.15),
    ),
    iconTheme: const IconThemeData(
      color: Color(0xFFCA81F5),
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: const Color(0xFFCA81F5),
      circularTrackColor: const Color(0xFFCA81F5).withOpacity(0.15),
    ),
    textTheme: TextTheme(
      headline1: GoogleFonts.londrinaSolid(
        textStyle: const TextStyle(color: Color(0xFFCA81F5), fontSize: 50),
      ),
      headline2: GoogleFonts.londrinaSolid(
        textStyle: const TextStyle(color: Color(0xFFCA81F5), fontSize: 25),
      ),
      headline3: GoogleFonts.londrinaSolid(
        textStyle: const TextStyle(color: Color(0xFFCA81F5), fontSize: 20),
      ),
      headline4: GoogleFonts.londrinaSolid(
        textStyle: const TextStyle(color: Color(0xFFCA81F5), fontSize: 17.5),
      ),
      headline5: GoogleFonts.londrinaSolid(
        textStyle: const TextStyle(color: Color(0xFFCA81F5), fontSize: 15),
      ),
      bodyText1: GoogleFonts.aBeeZee(
        textStyle: TextStyle(
          color: const Color(0xFFCA81F5).withOpacity(0.5),
        ),
      ),
      bodyText2: GoogleFonts.aBeeZee(
        textStyle: TextStyle(
            color: const Color(0xFFCA81F5).withOpacity(0.4), fontSize: 12),
      ),
      button: GoogleFonts.londrinaSolid(),
    ),
  ),
  gradientColors: const [
    Color(0xFF161A22),
    Color(0xFF0F1218),
    Color(0xFF090B0F),
    // Color(0xFFC6C5FF),
    // Color(0xFFA5DEF2),
    // Color(0xFF8D4EF2),
    // Color(0xFF1E80C1),
  ],
);

ThemeHelper loveTheme = ThemeHelper(
  themeData: ThemeData(
    primaryColor: const Color(0xFFFDF5F7),
    splashColor: const Color(0xFFFDF5F7).withOpacity(0.35),
    cardColor: const Color(0xFFFDF5F7).withOpacity(0.10),
    listTileTheme: ListTileThemeData(
      tileColor: const Color(0xFFFDF5F7).withOpacity(0.15),
    ),
    iconTheme: const IconThemeData(
      color: Color(0xFFFDF5F7),
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: const Color(0xFFFDF5F7),
      circularTrackColor: const Color(0xFFFDF5F7).withOpacity(0.15),
    ),
    textTheme: TextTheme(
      headline1: GoogleFonts.workSans(
        textStyle: const TextStyle(color: Color(0xFFFDF5F7), fontSize: 47.5),
      ),
      headline2: GoogleFonts.workSans(
        textStyle: const TextStyle(color: Color(0xFFFDF5F7), fontSize: 25),
      ),
      headline3: GoogleFonts.workSans(
        textStyle: const TextStyle(color: Color(0xFFFDF5F7), fontSize: 20),
      ),
      headline4: GoogleFonts.workSans(
        textStyle: const TextStyle(color: Color(0xFFFDF5F7), fontSize: 17.5),
      ),
      headline5: GoogleFonts.workSans(
        textStyle: const TextStyle(color: Color(0xFFFDF5F7), fontSize: 15),
      ),
      bodyText1: GoogleFonts.aBeeZee(
        textStyle: TextStyle(
          color: const Color(0xFFFDF5F7).withOpacity(0.5),
        ),
      ),
      bodyText2: GoogleFonts.aBeeZee(
        textStyle: TextStyle(
            color: const Color(0xFFFDF5F7).withOpacity(0.4), fontSize: 12),
      ),
      button: GoogleFonts.workSans(),
    ),
  ),
  gradientColors: const [
    Color(0xFFE45352),
    Color.fromARGB(255, 206, 64, 64),
    Color.fromARGB(255, 156, 40, 40),
  ],
);
