import 'package:flutter/services.dart';

import '../enums/device_type.dart';

class DeviceHandler {
  DeviceHandler._();

  static DeviceType getDeviceType({required Size deviceSize}) {
    if (deviceSize.width < 390) {
      return DeviceType.smallMobile;
    } else if (390 < deviceSize.width && deviceSize.width <= 480) {
      return DeviceType.largeMobile;
    } else if (480 <= deviceSize.width && deviceSize.width < 600) {
      return DeviceType.largeMobile;
    } else if (600 <= deviceSize.width && deviceSize.width < 720) {
      return DeviceType.smalltablet;
    } else if (720 <= deviceSize.width && deviceSize.width < 1025) {
      return DeviceType.largeTablet;
    } else if (1025 <= deviceSize.width && deviceSize.width < 1224) {
      return DeviceType.smallLaptop;
    } else {
      return DeviceType.largeLaptop;
    }
  }

  static void setAppOrientationOptions(DeviceType deviceType) {
    if (deviceType == DeviceType.smallMobile ||
        deviceType == DeviceType.largeMobile) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }
  }
}
