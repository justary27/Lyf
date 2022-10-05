import 'dart:developer';

import 'package:lyf/src/global/variables.dart';
import 'package:lyf/src/services/lyf_settings.dart';
import 'package:lyf/src/services/user.dart';

class InitService {
  InitService._();

  static Future<void> initializeServices() async {
    try {
      creds = await UserCredentials.getCredentials();
      themeCode = int.parse(
        (await LyfService.themeService.getTheme()) ?? "1",
      );
    } catch (e) {
      log(e.toString());
    }
  }
}
