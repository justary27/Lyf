import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lyf/src/constants/notification_constants.dart';
import 'package:lyf/src/global/variables.dart';
import 'package:lyf/src/routes/routing.dart';
import 'package:lyf/src/services/lyf_settings.dart';
import 'package:lyf/src/state/todo/todo_reminder_state.dart';

import '../../state/theme/theme_state.dart';

class NotificationSettingsScreen extends ConsumerStatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends ConsumerState<NotificationSettingsScreen> {
  TimeOfDay? notifTime;

  Future<void> _displayUpcomingTodoReminders(
      final Size size, final theme) async {
    ref.read(todoReminderNotifier.notifier).refresh();
    showModalBottomSheet(
      context: context,
      builder: ((context) {
        return Container(
          width: size.width,
          height: 0.5 * size.height,
          padding: EdgeInsets.symmetric(horizontal: 0.05 * size.width),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: theme.gradientColors,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(
                  endIndent: 0.4 * size.width,
                  indent: 0.4 * size.width,
                  thickness: 2,
                  color: Theme.of(context).primaryColor,
                ),
                SizedBox(height: 0.025 * size.height),
                Text(
                  "Upcoming TODO reminders",
                  style: Theme.of(context).textTheme.headline3,
                ),
                const SizedBox(height: 16),
                Consumer(
                  builder: ((context, ref, child) {
                    final contactState = ref.watch(todoReminderNotifier);
                    return contactState.when(
                      data: ((contacts) {
                        return SizedBox(
                          height: 0.4 * size.height,
                          child: ListView.builder(
                            itemCount: contacts!.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(
                                  contacts[index].title!,
                                  style: Theme.of(context).textTheme.headline4,
                                ),
                                subtitle: Text(
                                  contacts[index].body!,
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                trailing: TextButton(
                                  onPressed: () async {
                                    ref
                                        .read(todoReminderNotifier.notifier)
                                        .cancelReminder(contacts[index]);
                                  },
                                  child: const Text("Cancel"),
                                ),
                              );
                            },
                          ),
                        );
                      }),
                      error: ((error, stackTrace) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 0.05 * size.width,
                            vertical: 0.01 * size.height,
                          ),
                          child: Container(
                            height: 0.4 * size.height,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Theme.of(context).splashColor,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(13),
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                "Unable to retrieve your reminders!",
                              ),
                            ),
                          ),
                        );
                      }),
                      loading: (() {
                        return SizedBox(
                          height: 0.4 * size.height,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }),
                    );
                  }),
                ),

                // SizedBox(
                //   height: 0.4 * size.height,
                //   child: ListView.builder(
                //     itemCount: queuedTodoNotifs.length,
                //     itemBuilder: (context, index) {
                //       return ListTile(
                //         title: Text(
                //           queuedTodoNotifs[index].title!,
                //           style: Theme.of(context).textTheme.headline4,
                //         ),
                //         subtitle: Text(
                //           queuedTodoNotifs[index].body!,
                //           style: Theme.of(context).textTheme.bodyText1,
                //         ),
                //         trailing: TextButton(
                //           onPressed: () async {
                //             await LyfService.notificationService
                //                 .cancelNotification(queuedTodoNotifs[index].id);
                //           },
                //           child: const Text("Cancel"),
                //         ),
                //       );
                //     },
                //   ),
                // ),
              ],
            ),
          ),
        );
      }),
    );

    return;
  }

  void _togglePreference(bool value) async {
    diaryNotifPref = value;
    await LyfService.notificationService.setDiaryNotificationPreference(value);
    if (value) {
      await LyfService.notificationService.schedulePeriodicNotification(
        id: diaryNotifDataConstant["id"],
        title: diaryNotifDataConstant["title"],
        body: diaryNotifDataConstant["body"],
        channelType: diaryNotifDataConstant["channelType"],
        time: diaryNotifTime,
      );
    } else {
      LyfService.notificationService.cancelNotification(
        diaryNotifDataConstant["id"],
      );
    }
    setState(() {});
  }

  void _updateReminderTime() async {
    if (notifTime != null) {
      DateTime dNotifTime = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        notifTime!.hour,
        notifTime!.minute,
      );

      diaryNotifTime = dNotifTime;

      await LyfService.notificationService.setDiaryNotificationTimePreference(
        diaryNotifTime,
      );

      await LyfService.notificationService.cancelNotification(
        diaryNotifDataConstant["id"],
      );
      await LyfService.notificationService.schedulePeriodicNotification(
        id: diaryNotifDataConstant["id"],
        title: diaryNotifDataConstant["title"],
        body: diaryNotifDataConstant["body"],
        channelType: diaryNotifDataConstant["channelType"],
        time: diaryNotifTime,
      );

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    var theme = ref.watch(themeNotifier);

    return Stack(
      children: [
        Container(
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: theme.gradientColors,
            ),
          ),
        ),
        SizedBox(
          height: size.height,
          width: size.width,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              leading: IconButton(
                onPressed: () {
                  goRouter.pop();
                },
                icon: const Icon(Icons.arrow_back_ios),
                color: Theme.of(context).iconTheme.color,
              ),
              title: Text(
                AppLocalizations.of(context)!.notifications,
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
            backgroundColor: Colors.transparent,
            body: Builder(builder: (context) {
              return ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 0.05 * size.width,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ListTile(
                          tileColor: Colors.transparent,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 0.05 * size.width,
                            vertical: 0.025 * size.height,
                          ),
                          leading: SvgPicture.asset(
                            "assets/images/todo.svg",
                            colorFilter: ColorFilter.mode(
                              Theme.of(context).iconTheme.color!,
                              BlendMode.srcIn,
                            ),
                          ),
                          title: Text(
                            "Todo Reminders",
                            style: Theme.of(context).textTheme.headline2,
                          ),
                          subtitle: Text(
                            "Change the way that Lyf reminds you of your TODOs!",
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          isThreeLine: true,
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 0.05 * size.width,
                            vertical: 0.025 * size.height,
                          ),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                          ),
                          title: Text(
                            "Cancel all reminders",
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          subtitle: Text(
                            "This will cancel all the pending TODO reminders!",
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                        ListTile(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 0.05 * size.width,
                            vertical: 0.0125 * size.height,
                          ),
                          title: Text(
                            "Upcoming Reminders",
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          subtitle: Text(
                            "See the upcoming reminders.",
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          onTap: () async {
                            await _displayUpcomingTodoReminders(size, theme);
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      0.05 * size.width,
                      0,
                      0.05 * size.width,
                      0.05 * size.height,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ListTile(
                          tileColor: Colors.transparent,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 0.05 * size.width,
                            vertical: 0.025 * size.height,
                          ),
                          leading: SvgPicture.asset(
                            "assets/images/diary.svg",
                            colorFilter: ColorFilter.mode(
                              Theme.of(context).iconTheme.color!,
                              BlendMode.srcIn,
                            ),
                          ),
                          title: Text(
                            "Diary Reminders",
                            style: Theme.of(context).textTheme.headline2,
                          ),
                          subtitle: Text(
                            "Change the way that Lyf reminds you to write your diary!",
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          isThreeLine: true,
                        ),
                        SwitchListTile(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 0.05 * size.width,
                            vertical: 0.025 * size.height,
                          ),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                          ),
                          dense: true,
                          title: Text(
                            "Daily Reminders",
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          subtitle: Text(
                            diaryNotifPref ? "ON" : "OFF",
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          onChanged: (bool value) {
                            _togglePreference(value);
                          },
                          value: diaryNotifPref,
                        ),
                        Stack(
                          children: [
                            SizedBox(
                              height: 0.1 * size.height,
                              child: ListTile(
                                enabled: diaryNotifPref,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(12),
                                    bottomRight: Radius.circular(12),
                                  ),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 0.05 * size.width,
                                  vertical: 0.0125 * size.height,
                                ),
                                title: Text(
                                  "Remind At",
                                  style: Theme.of(context).textTheme.headline4,
                                ),
                                subtitle: Text(
                                  "Remind you at?",
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                                trailing: TextButton(
                                  onPressed: diaryNotifPref
                                      ? () async {
                                          notifTime = await showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now(),
                                          );
                                          _updateReminderTime();
                                        }
                                      : null,
                                  child: Text(
                                    "${diaryNotifTime.hour}:${diaryNotifTime.minute}",
                                  ),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: !diaryNotifPref,
                              child: Container(
                                width: 0.9 * size.width,
                                height: 0.1 * size.height,
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.3),
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(12),
                                    bottomRight: Radius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ],
    );
  }
}
