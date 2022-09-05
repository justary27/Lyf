import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

SnackBar fileSnackBar = SnackBar(
  duration: const Duration(hours: 1),
  padding: EdgeInsets.zero,
  backgroundColor: Colors.white,
  dismissDirection: DismissDirection.startToEnd,
  content: ListTile(
    leading: CircularProgressIndicator.adaptive(
      backgroundColor: Colors.grey.shade700,
    ),
    title: Text(
      "Uploading files...",
      style: GoogleFonts.aBeeZee(
        textStyle: TextStyle(
          color: Colors.grey.shade700,
        ),
      ),
    ),
  ),
);
