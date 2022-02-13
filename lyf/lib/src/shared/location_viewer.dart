import 'package:flutter/material.dart';

Widget locationViewer({
  required Size size,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(
      horizontal: 0.05 * size.width,
      vertical: 0.015 * size.height,
    ),
    child: Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.white.withOpacity(0.15),
      // child: GridView.builder(gridDelegate: gridDelegate, itemBuilder: itemBuilder),
    ),
  );
}
