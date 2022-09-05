import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

SnackBar diaryUpdateSnack = SnackBar(
  padding: EdgeInsets.zero,
  duration: const Duration(seconds: 2),
  backgroundColor: Colors.white,
  dismissDirection: DismissDirection.startToEnd,
  content: ListTile(
    leading: Icon(
      Icons.check_rounded,
      color: Colors.grey.shade700,
    ),
    title: Text(
      "Entry updated successfully!",
      style: GoogleFonts.aBeeZee(
        textStyle: TextStyle(
          color: Colors.grey.shade700,
        ),
      ),
    ),
  ),
);

SnackBar todoUpdateSnack = SnackBar(
  padding: EdgeInsets.zero,
  duration: const Duration(seconds: 2),
  backgroundColor: Colors.white,
  dismissDirection: DismissDirection.startToEnd,
  content: ListTile(
    leading: Icon(
      Icons.check_rounded,
      color: Colors.grey.shade700,
    ),
    title: Text(
      "Todo updated successfully!",
      style: GoogleFonts.aBeeZee(
        textStyle: TextStyle(
          color: Colors.grey.shade700,
        ),
      ),
    ),
  ),
);
