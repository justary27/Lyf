import 'package:flutter/material.dart';

SnackBar fileSnackBar = SnackBar(
    duration: const Duration(hours: 1),
    content: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text("Uploading files"),
        CircularProgressIndicator.adaptive(),
      ],
    ));
