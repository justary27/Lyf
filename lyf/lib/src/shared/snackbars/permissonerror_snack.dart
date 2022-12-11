import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

SnackBar permissionErrorSnack = SnackBar(
  padding: EdgeInsets.zero,
  duration: const Duration(seconds: 2),
  backgroundColor: Colors.white,
  dismissDirection: DismissDirection.down,
  content: ListTile(
    leading: Icon(
      Icons.warning_rounded,
      color: Colors.grey.shade700,
    ),
    title: Text(
      "Permission error, grant required permission!",
      style: GoogleFonts.aBeeZee(
        textStyle: TextStyle(
          color: Colors.grey.shade700,
        ),
      ),
    ),
  ),
);
