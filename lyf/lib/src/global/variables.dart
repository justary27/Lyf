import 'package:flutter/material.dart';
import 'package:lyf/src/models/user_model.dart';
import 'package:lyf/src/services/settings/notification_settings.dart';

Map<String, String?>? creds;

/// App login state of the user.
bool loginState = false;

/// Current [LyfUser] interacting with the app,
/// all operations in the app are done by this user only.
/// Equals the [guestUser] before user login.
LyfUser currentUser = guestUser;

///
late int themeCode;

late bool diaryNotifPref;

late DateTime diaryNotifTime;

final GlobalKey<ScaffoldMessengerState> snackKey =
    GlobalKey<ScaffoldMessengerState>();

late NotificationService localNotificationService;
