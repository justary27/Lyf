import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lyf/src/constants/invite_constants.dart';
import 'package:lyf/src/routes/routing.dart';
import 'package:lyf/src/shared/contact_viewer.dart';
import 'package:lyf/src/state/settings/contacts_state.dart';
import 'package:share_plus/share_plus.dart';

import '../../state/theme/theme_state.dart';
import '../../utils/errors/services/service_errors.dart';

class InviteSettingsScreen extends ConsumerStatefulWidget {
  const InviteSettingsScreen({super.key});

  @override
  ConsumerState<InviteSettingsScreen> createState() =>
      _InviteSettingsScreenState();
}

class _InviteSettingsScreenState extends ConsumerState<InviteSettingsScreen> {
  Widget? contactView;
  late TextEditingController _contactFinder;

  void _refresh({bool? forceRefresh}) {
    try {
      ref.read(contactNotifier).value;
      if (forceRefresh != null && forceRefresh) {
        ref.read(contactNotifier.notifier).getContacts();
      }
    } on ServiceException {
      ref.read(contactNotifier.notifier).getContacts();
    }
  }

  @override
  void initState() {
    super.initState();
    _refresh();
    _contactFinder = TextEditingController();
    _contactFinder.addListener(
      () {
        ref.read(contactNotifier.notifier).searchContact(
              _contactFinder.text,
            );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    var theme = ref.read(themeNotifier);

    return WillPopScope(
      onWillPop: () async {
        ref.read(contactNotifier.notifier).setToInitState();
        return true;
      },
      child: Stack(
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
            child: const CustomPaint(),
          ),
          SizedBox(
            height: size.height,
            width: size.width,
            child: Scaffold(
              appBar: AppBar(
                // shadowColor: Colors.transparent,
                backgroundColor: Colors.transparent,
                leading: IconButton(
                  onPressed: () {
                    ref.read(contactNotifier.notifier).setToInitState();
                    goRouter.pop();
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Theme.of(context).iconTheme.color,
                  ),
                ),
                title: Text(
                  AppLocalizations.of(context)!.invite,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ),
              backgroundColor: Colors.transparent,
              body: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 0.05 * size.width,
                      vertical: 0.020 * size.height,
                    ),
                    leading: Icon(
                      Icons.share_rounded,
                      color: Theme.of(context).iconTheme.color,
                      size: 35,
                    ),
                    title: Text(
                      AppLocalizations.of(context)!.shareLink,
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    subtitle: Text(
                      AppLocalizations.of(context)!.shareLinkDesc,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    tileColor: Colors.transparent,
                    onTap: () {
                      Share.share(inviteShareBody);
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 0.020 * size.height,
                      horizontal: 0.05 * size.width,
                    ),
                    child: SizedBox(
                      height: 50,
                      child: TextField(
                        controller: _contactFinder,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.bodyLarge,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.search_rounded,
                            color: Theme.of(context).iconTheme.color,
                          ),
                          hintText: AppLocalizations.of(context)!.searchPeople,
                          hintStyle: Theme.of(context).textTheme.bodyLarge,
                          filled: true,
                          fillColor: Colors.transparent,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: BorderSide(
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.25),
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.45),
                              width: 1.0,
                            ),
                          ),
                        ),
                        cursorColor: Colors.white,
                      ),
                    ),
                  ),
                  Consumer(
                    builder: ((context, ref, child) {
                      final contactState = ref.watch(contactNotifier);
                      return contactState.when(
                        data: ((contacts) {
                          return ContactViewer(
                            size: size,
                            themeColors: theme.gradientColors,
                            contacts: contacts,
                          );
                        }),
                        error: ((error, stackTrace) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 0.05 * size.width,
                              vertical: 0.01 * size.height,
                            ),
                            child: Container(
                              width: size.width,
                              height: 0.75 * size.height,
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
                                  "Unable to retrieve your Contacts.",
                                ),
                              ),
                            ),
                          );
                        }),
                        loading: (() {
                          return SizedBox(
                            width: size.width,
                            height: size.height,
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _contactFinder.dispose();
    super.dispose();
  }
}
