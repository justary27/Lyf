import 'dart:developer';

import 'package:lyf/src/global/functions.dart';
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
      diaryNotifPref = boolParser(
        await LyfService.notificationService.getDiaryNotificationPreference() ??
            "false",
      );
      diaryNotifTime = DateTime.parse(
        await LyfService.notificationService
                .getDiaryNotificationTimePreference() ??
            "2022-11-25T04:00:00+05:30",
      );
      // Initialize the notification service.
      localNotificationService = LyfService.notificationService;
      localNotificationService.initialize();
    } catch (e) {
      log(e.toString());
    }
  }
}
