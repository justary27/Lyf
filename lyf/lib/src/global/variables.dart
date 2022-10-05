import 'package:flutter/material.dart';
import 'package:lyf/src/models/user_model.dart';

Map<String, String?>? creds;

/// App login state of the user.
bool loginState = false;

/// Current [LyfUser] interacting with the app,
/// all operations in the app are done by this user only.
/// Equals the [guestUser] before user login.
LyfUser currentUser = guestUser;

///
late int themeCode;

final GlobalKey<ScaffoldMessengerState> snackKey =
    GlobalKey<ScaffoldMessengerState>();
