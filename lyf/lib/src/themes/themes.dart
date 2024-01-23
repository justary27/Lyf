import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lyf/src/utils/helpers/theme_helper.dart';

final ThemeHelper lyfTheme = ThemeHelper(
  themeData: ThemeData(
    // useMaterial3: false,
    primaryColor: const Color.fromARGB(255, 14, 105, 87),
    shadowColor: Colors.black,
    cardColor: const Color(0xFF7DF6AD).withOpacity(0.15),
    splashColor: const Color.fromARGB(255, 14, 105, 87).withOpacity(0.35),
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
      displayLarge: GoogleFonts.merienda(
        textStyle: const TextStyle(
            color: Color.fromARGB(255, 14, 105, 87), fontSize: 40),
      ),
      displayMedium: GoogleFonts.merienda(
        textStyle: const TextStyle(color: Colors.white, fontSize: 25),
      ),
      displaySmall: GoogleFonts.merienda(
        textStyle: const TextStyle(color: Colors.white, fontSize: 20),
      ),
      headlineMedium: GoogleFonts.merienda(
        textStyle: const TextStyle(color: Colors.white, fontSize: 17.5),
      ),
      headlineSmall: GoogleFonts.merienda(
        textStyle: const TextStyle(color: Colors.white, fontSize: 15),
      ),
      bodyLarge: GoogleFonts.aBeeZee(
        textStyle: TextStyle(
          color: Colors.white.withOpacity(0.4),
        ),
      ),
      bodyMedium: GoogleFonts.aBeeZee(
        textStyle:
            TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 12),
      ),
      labelLarge: GoogleFonts.ubuntu(),
    ),
  ),
  gradientColors: const [
    Color(0xFFB5FF00),
    Color(0xFF1FC192),
    Color(0xFF03B797),
  ],
);

final ThemeHelper monochromeTheme = ThemeHelper(
  themeData: ThemeData(
    // useMaterial3: false,
    primaryColor: Colors.white,
    shadowColor: Colors.black,
    cardColor: Colors.white.withOpacity(0.15),
    splashColor: Colors.white.withOpacity(0.35),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.all(Colors.white),
      trackColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return Colors.white.withOpacity(.65);
          }
          return Colors.white.withOpacity(.15);
        },
      ),
      overlayColor: MaterialStateProperty.resolveWith<Color?>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return Colors.white.withOpacity(0.35);
          }
          if (states.contains(MaterialState.disabled)) {
            return Colors.grey.shade400;
          }
          return null;
        },
      ),
    ),
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
      displayLarge: GoogleFonts.ubuntu(
        textStyle: const TextStyle(color: Colors.white, fontSize: 50),
      ),
      displayMedium: GoogleFonts.ubuntu(
        textStyle: const TextStyle(color: Colors.white, fontSize: 25),
      ),
      displaySmall: GoogleFonts.ubuntu(
        textStyle: const TextStyle(color: Colors.white, fontSize: 20),
      ),
      headlineMedium: GoogleFonts.ubuntu(
        textStyle: const TextStyle(color: Colors.white, fontSize: 17.5),
      ),
      headlineSmall: GoogleFonts.ubuntu(
        textStyle: const TextStyle(color: Colors.white, fontSize: 15),
      ),
      bodyLarge: GoogleFonts.aBeeZee(
        textStyle: TextStyle(
          color: Colors.white.withOpacity(0.4),
        ),
      ),
      bodyMedium: GoogleFonts.aBeeZee(
        textStyle:
            TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 12),
      ),
      labelLarge: GoogleFonts.ubuntu(),
    ),
  ),
  gradientColors: const [
    Color(0xFF616161),
    Color(0xFF212121),
    Color(0xFF000000),
  ],
);
final ThemeHelper funkyTheme = ThemeHelper(
  themeData: ThemeData(
    // useMaterial3: false,
    primaryColor: const Color(0xFFCA81F5),
    splashColor: const Color(0xFFCA81F5).withOpacity(0.35),
    cardColor: const Color(0xFFCA81F5).withOpacity(0.10),
    listTileTheme: ListTileThemeData(
      tileColor: const Color(0xFFCA81F5).withOpacity(0.15),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.all(const Color(0xFFCA81F5)),
      trackColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return const Color(0xFFCA81F5).withOpacity(.65);
          }
          return const Color(0xFFCA81F5).withOpacity(.15);
        },
      ),
      overlayColor: MaterialStateProperty.resolveWith<Color?>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return const Color(0xFFCA81F5).withOpacity(0.35);
          }
          if (states.contains(MaterialState.disabled)) {
            return Colors.grey.shade400;
          }
          return null;
        },
      ),
    ),
    iconTheme: const IconThemeData(
      color: Color(0xFFCA81F5),
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: const Color(0xFFCA81F5),
      circularTrackColor: const Color(0xFFCA81F5).withOpacity(0.15),
    ),
    textTheme: TextTheme(
      displayLarge: GoogleFonts.londrinaSolid(
        textStyle: const TextStyle(color: Color(0xFFCA81F5), fontSize: 50),
      ),
      displayMedium: GoogleFonts.londrinaSolid(
        textStyle: const TextStyle(color: Color(0xFFCA81F5), fontSize: 25),
      ),
      displaySmall: GoogleFonts.londrinaSolid(
        textStyle: const TextStyle(color: Color(0xFFCA81F5), fontSize: 20),
      ),
      headlineMedium: GoogleFonts.londrinaSolid(
        textStyle: const TextStyle(color: Color(0xFFCA81F5), fontSize: 17.5),
      ),
      headlineSmall: GoogleFonts.londrinaSolid(
        textStyle: const TextStyle(color: Color(0xFFCA81F5), fontSize: 15),
      ),
      bodyLarge: GoogleFonts.aBeeZee(
        textStyle: TextStyle(
          color: const Color(0xFFCA81F5).withOpacity(0.5),
        ),
      ),
      bodyMedium: GoogleFonts.aBeeZee(
        textStyle: TextStyle(
            color: const Color(0xFFCA81F5).withOpacity(0.4), fontSize: 12),
      ),
      labelLarge: GoogleFonts.londrinaSolid(),
    ),
  ),
  gradientColors: const [
    Color(0xFF161A22),
    Color(0xFF0F1218),
    Color(0xFF090B0F),
  ],
);

final ThemeHelper loveTheme = ThemeHelper(
  themeData: ThemeData(
    // useMaterial3: false,
    primaryColor: const Color(0xFFFDF5F7),
    splashColor: const Color(0xFFFDF5F7).withOpacity(0.35),
    cardColor: const Color(0xFFFDF5F7).withOpacity(0.10),
    listTileTheme: ListTileThemeData(
      tileColor: const Color(0xFFFDF5F7).withOpacity(0.15),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.all(Colors.white),
      trackColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return Colors.white.withOpacity(.65);
          }
          return Colors.white.withOpacity(.15);
        },
      ),
      overlayColor: MaterialStateProperty.resolveWith<Color?>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return Colors.white.withOpacity(0.35);
          }
          if (states.contains(MaterialState.disabled)) {
            return Colors.grey.shade400;
          }
          return null;
        },
      ),
    ),
    iconTheme: const IconThemeData(
      color: Color(0xFFFDF5F7),
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: const Color(0xFFFDF5F7),
      circularTrackColor: const Color(0xFFFDF5F7).withOpacity(0.15),
    ),
    textTheme: TextTheme(
      displayLarge: GoogleFonts.workSans(
        textStyle: const TextStyle(color: Color(0xFFFDF5F7), fontSize: 47.5),
      ),
      displayMedium: GoogleFonts.workSans(
        textStyle: const TextStyle(color: Color(0xFFFDF5F7), fontSize: 25),
      ),
      displaySmall: GoogleFonts.workSans(
        textStyle: const TextStyle(color: Color(0xFFFDF5F7), fontSize: 20),
      ),
      headlineMedium: GoogleFonts.workSans(
        textStyle: const TextStyle(color: Color(0xFFFDF5F7), fontSize: 17.5),
      ),
      headlineSmall: GoogleFonts.workSans(
        textStyle: const TextStyle(color: Color(0xFFFDF5F7), fontSize: 15),
      ),
      bodyLarge: GoogleFonts.aBeeZee(
        textStyle: TextStyle(
          color: const Color(0xFFFDF5F7).withOpacity(0.5),
        ),
      ),
      bodyMedium: GoogleFonts.aBeeZee(
        textStyle: TextStyle(
            color: const Color(0xFFFDF5F7).withOpacity(0.4), fontSize: 12),
      ),
      labelLarge: GoogleFonts.workSans(),
    ),
  ),
  gradientColors: const [
    Color(0xFFE45352),
    Color.fromARGB(255, 206, 64, 64),
    Color.fromARGB(255, 156, 40, 40),
  ],
);
