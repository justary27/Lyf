import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'settings/billing_settings.dart';
import 'settings/account_settings.dart';
import 'settings/data_settings.dart';
import 'settings/invite_settings.dart';
import 'settings/language_settings.dart';
import 'settings/notification_settings.dart';
import 'settings/theme_settings.dart';

class LyfService {
  LyfService._();

  static const _storageInstance = FlutterSecureStorage();

  static final AccountsService accountService =
      AccountsService(_storageInstance);
  static final BillingService billingService = BillingService(_storageInstance);
  static final DataService dataService = DataService(_storageInstance);
  static final InviteService inviteService = InviteService(_storageInstance);
  static final LanguageService languageService =
      LanguageService(_storageInstance);
  static final NotificationService notificationService =
      NotificationService(_storageInstance);
  static final ThemesService themeService = ThemesService(_storageInstance);
}
