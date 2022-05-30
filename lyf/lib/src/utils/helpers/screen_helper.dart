import 'dart:ui';

double pixelRatio = window.devicePixelRatio;

Size logicalScreenSize = window.physicalSize / pixelRatio;

double logicalWidth = logicalScreenSize.width;
double logicalHeight = logicalScreenSize.height;
