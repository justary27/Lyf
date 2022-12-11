import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../services/lyf_settings.dart';

final todoReminderNotifier = StateNotifierProvider<TodoReminderNotifier,
    AsyncValue<List<PendingNotificationRequest>?>>((ref) {
  return TodoReminderNotifier(ref.read);
});

class TodoReminderNotifier
    extends StateNotifier<AsyncValue<List<PendingNotificationRequest>?>> {
  final Reader read;
  AsyncValue<List<PendingNotificationRequest>?>? previousState;

  TodoReminderNotifier(
    this.read, [
    AsyncValue<List<PendingNotificationRequest>?>? previousState,
  ]) : super(previousState ?? const AsyncValue.loading()) {
    _retrieveReminders();
  }

  Future<void> _retrieveReminders() async {
    try {
      List<PendingNotificationRequest> reminders =
          await LyfService.notificationService.getQueuedTodoNotifications();
      print(reminders);
      state = AsyncValue.data(reminders);
    } catch (e) {
      handleException(e);
    }
  }

  Future<void> refresh() async {
    try {
      List<PendingNotificationRequest> reminders =
          await LyfService.notificationService.getQueuedTodoNotifications();
      state = AsyncValue.data(reminders);
    } catch (e) {
      handleException(e);
    }
  }

  Future<void> cancelReminder(PendingNotificationRequest reminder) async {
    _cacheState();
    state = state.whenData(
      (reminderList) =>
          reminderList!.where((element) => element != reminder).toList(),
    );
    try {
      await LyfService.notificationService.cancelNotification(reminder.id);
    } catch (e) {
      handleException(e);
    }
  }

  void _cacheState() {
    previousState = state;
  }

  void _resetState() {
    if (previousState != null) {
      state = previousState!;
      previousState = null;
    }
  }

  void handleException(Object e) {
    _resetState();
  }
}
