import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

SnackBar networkErrorSnack = SnackBar(
  padding: EdgeInsets.zero,
  duration: const Duration(seconds: 2),
  backgroundColor: Colors.white,
  dismissDirection: DismissDirection.startToEnd,
  content: ListTile(
    leading: Icon(
      Icons.wifi_off_rounded,
      color: Colors.grey.shade700,
    ),
    title: Text(
      "Network error, check your internet connection!",
      style: GoogleFonts.aBeeZee(
        textStyle: TextStyle(
          color: Colors.grey.shade700,
        ),
      ),
    ),
  ),
);
