import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lyf/src/routes/routing.dart';
import 'package:lyf/src/utils/enums/channel_type.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationService {
  late final FlutterSecureStorage _storageInstance;
  final String _keyNotificationsPrefSettings = 'nsPUuid';
  final String _keyNotificationsTimeSettings = 'nsTUuid';
  final FlutterLocalNotificationsPlugin _localNotificationService =
      FlutterLocalNotificationsPlugin();

  NotificationService(this._storageInstance) {
    tz.initializeTimeZones();
  }

  // Notification Preferences

  Future<void> setDiaryNotificationPreference(bool value) async =>
      await _storageInstance.write(
        key: _keyNotificationsPrefSettings,
        value: value.toString(),
      );

  Future<String?> getDiaryNotificationPreference() async =>
      await _storageInstance.read(key: _keyNotificationsPrefSettings);

  Future<void> setDiaryNotificationTimePreference(DateTime time) async =>
      await _storageInstance.write(
        key: _keyNotificationsTimeSettings,
        value: time.toIso8601String(),
      );

  Future<String?> getDiaryNotificationTimePreference() async =>
      await _storageInstance.read(key: _keyNotificationsTimeSettings);

  // Notification Service

  Future<void> initialize() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings("@drawable/ic_stat_lyf");

    const initializationSettings = InitializationSettings(
      android: androidSettings,
    );

    await _localNotificationService.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onRecieveLocalNotificationSelect,
      onDidReceiveBackgroundNotificationResponse:
          onRecieveBackgroundNotificationSelect,
    );
  }

  Future<NotificationDetails> _notificationDetails(dynamic channelData) async {
    final AndroidNotificationDetails andriodNotifDetails =
        AndroidNotificationDetails(
      channelData["id"],
      channelData["name"],
      channelDescription: channelData["description"],
      importance: channelData["importance"],
      priority: channelData["priority"],
      fullScreenIntent: channelData["fullScreenIntent"],
    );

    return NotificationDetails(android: andriodNotifDetails);
  }

  Future<void> pushNotification({
    required int id,
    required String title,
    required String body,
    required ChannelType channelType,
  }) async {
    final channelData = _getChannelData(channelType);
    final notifDetails = await _notificationDetails(channelData);
    await _localNotificationService.show(id, title, body, notifDetails);
  }

  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime time,
    required ChannelType channelType,
    String? payload,
  }) async {
    final channelData = _getChannelData(channelType);
    final notifDetails = await _notificationDetails(channelData);
    await _localNotificationService.zonedSchedule(
      id,
      title,
      body,
      _nextInstanceOfTime(time),
      notifDetails,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: payload,
    );
  }

  Future<void> schedulePeriodicNotification({
    required int id,
    required String title,
    required String body,
    required DateTime time,
    required ChannelType channelType,
  }) async {
    final channelData = _getChannelData(channelType);
    final notifDetails = await _notificationDetails(channelData);
    await _localNotificationService.zonedSchedule(
      id,
      title,
      body,
      _nextInstanceOfTime(time),
      notifDetails,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> getQueuedNotifications() async {
    List<PendingNotificationRequest> queuedNotifs =
        await _localNotificationService.pendingNotificationRequests();

    print(queuedNotifs[1]);
  }

  Future<List<PendingNotificationRequest>> getQueuedTodoNotifications() async {
    List<PendingNotificationRequest> queuedNotifs =
        await _localNotificationService.pendingNotificationRequests();

    List<PendingNotificationRequest> queuedTodoNotifs = queuedNotifs
        .where((element) => element.payload!.startsWith("T"))
        .toList();

    return queuedTodoNotifs;
  }

  Future<void> cancelNotification(int id) async {
    await _localNotificationService.cancel(id);
  }

  void onRecieveLocalNotificationSelect(
    NotificationResponse notificationResponse,
  ) {
    String? payload = notificationResponse.payload;
    if (payload != null && payload.startsWith("T")) {
      payload = payload.substring(2);
      log(payload);
      goRouter.push("/todo");
    }
  }

  @pragma('vm:entry-point')
  static void onRecieveBackgroundNotificationSelect(
    NotificationResponse notificationResponse,
  ) {
    log(notificationResponse.payload.toString());
  }

  Map<String, dynamic> _getChannelData(ChannelType channelType) {
    Map<String, dynamic> cData = {};
    if (channelType == ChannelType.todo) {
      cData.addAll({
        "id": "1",
        "name": "Todo",
        "description": "Channel for Todo Notifications.",
        "importance": Importance.high,
        "priority": Priority.high,
        "fullScreenIntent": true,
      });
    } else {
      cData.addAll({
        "id": "2",
        "name": "Diary",
        "description": "Channel for Diary Notifications.",
        "importance": Importance.high,
        "priority": Priority.high,
        "fullScreenIntent": false,
      });
    }
    return cData;
  }

  tz.TZDateTime _nextInstanceOfTime(DateTime time) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime.from(time, tz.local);

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }
}
