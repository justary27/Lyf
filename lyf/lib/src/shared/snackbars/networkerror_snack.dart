import 'package:flutter/material.dart';

SnackBar networkErrorSnack = SnackBar(
  padding: const EdgeInsets.symmetric(
    horizontal: 12,
    vertical: 10,
  ),
  content: Row(
    children: const [
      Icon(Icons.wifi_off_rounded, color: Colors.white),
      SizedBox(width: 12),
      Text("Network error, check your internet connection!"),
    ],
  ),
  duration: const Duration(seconds: 2),
);
