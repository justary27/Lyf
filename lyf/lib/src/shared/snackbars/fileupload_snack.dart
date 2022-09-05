import 'package:flutter/material.dart';

SnackBar fileSnackBar = SnackBar(
  content: Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: const [
      Text("Uploading files"),
      CircularProgressIndicator.adaptive(),
    ],
  ),
  duration: const Duration(hours: 1),
);
