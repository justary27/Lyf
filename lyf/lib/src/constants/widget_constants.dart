import 'package:flutter/material.dart';
import 'package:lyf/src/shared/widgets/home/fidget.dart';
import 'package:lyf/src/shared/widgets/home/heart.dart';
import 'package:lyf/src/themes/themes.dart';
import 'package:lyf/src/utils/helpers/screen_helper.dart';

import '../shared/widgets/home/clock.dart';
import '../utils/helpers/theme_helper.dart';

final Map<ThemeHelper, Widget> widgetConstants = {
  lyfTheme: SizedBox(
    width: logicalScreenSize.width,
    height: logicalScreenSize.height,
    child: Clock(
      size: logicalScreenSize,
    ),
  ),
  monochromeTheme: SizedBox(
    width: logicalScreenSize.width,
    height: logicalScreenSize.height,
    child: Clock(
      size: logicalScreenSize,
    ),
  ),
  funkyTheme: Positioned(
    top: 0.375 * logicalScreenSize.height,
    right: -0.15 * logicalScreenSize.height,
    child: Fidget(
      size: logicalScreenSize,
    ),
  ),
  loveTheme: Positioned(
    top: 0.35 * logicalScreenSize.height,
    right: -0.15 * logicalScreenSize.height,
    child: Heart(
      size: logicalScreenSize,
    ),
  ),
};
