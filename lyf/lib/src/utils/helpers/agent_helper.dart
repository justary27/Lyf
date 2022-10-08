import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class AgentHelper {
  AgentHelper._();

  static DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  static Future<Map<String, String>> buildUserAgentHeader() async {
    final deviceInfo = await deviceInfoPlugin.deviceInfo;
    final map = deviceInfo.toMap();

    Map<String, String> userAgentHeader = {};

    userAgentHeader.addAll({
      'deviceName': map["brand"] + " " + map["model"],
      'platform': Platform.operatingSystem,
      'dartVersion': Platform.version
    });

    return userAgentHeader;
  }
}
