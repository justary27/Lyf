import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'settings/billing_settings.dart';
import 'settings/account_settings.dart';
import 'settings/data_settings.dart';
import 'settings/help_settings.dart';
import 'settings/invite_settings.dart';
import 'settings/language_settings.dart';
import 'settings/notification_settings.dart';
import 'settings/theme_settings.dart';

class LyfSettings {
  static const _storageInstance = FlutterSecureStorage();
  static final AccountSettings accountSettings =
      AccountSettings(_storageInstance);
  static final BillingSettings billingSettings =
      BillingSettings(_storageInstance);
  static final DataSettings dataSettings = DataSettings(_storageInstance);
  static final HelpSettings helpSettings = HelpSettings(_storageInstance);
  static final InviteSettings inviteSettings = InviteSettings(_storageInstance);
  static final LanguageSettings languageSettings =
      LanguageSettings(_storageInstance);
  static final NotificationSettings notificationSettings =
      NotificationSettings(_storageInstance);
  static final ThemeSettings themeSettings = ThemeSettings(_storageInstance);
}
