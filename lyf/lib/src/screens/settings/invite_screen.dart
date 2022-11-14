import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lyf/src/constants/invite_constants.dart';
import 'package:lyf/src/routes/routing.dart';
import 'package:lyf/src/shared/contact_viewer.dart';
import 'package:lyf/src/state/settings/contacts_state.dart';
import 'package:share_plus/share_plus.dart';

import '../../state/theme/theme_state.dart';

class InviteSettingsScreen extends ConsumerStatefulWidget {
  const InviteSettingsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<InviteSettingsScreen> createState() =>
      _InviteSettingsScreenState();
}

class _InviteSettingsScreenState extends ConsumerState<InviteSettingsScreen> {
  Widget? contactView;
  late TextEditingController _contactFinder;

  @override
  void initState() {
    super.initState();
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
    var theme = ref.read(themeNotifier.notifier).getCurrentState();

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
                  goRouter.pop();
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
              title: Text(
                "Invite",
                style: Theme.of(context).textTheme.headline3,
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
                    "Share link!",
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  subtitle: Text(
                    "Click to share invite link!",
                    style: Theme.of(context).textTheme.bodyText1,
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
                      style: Theme.of(context).textTheme.bodyText1,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search_rounded,
                          color: Theme.of(context).iconTheme.color,
                        ),
                        hintText: "Search People...",
                        hintStyle: Theme.of(context).textTheme.bodyText1,
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
                        return const SliverFillRemaining(
                          child: Center(
                            child: Text("Unable to retrieve your Contacts."),
                          ),
                        );
                      }),
                      loading: (() {
                        return SizedBox(
                          width: size.width,
                          height: size.height,
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
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
    );
  }

  @override
  void dispose() {
    _contactFinder.dispose();
    super.dispose();
  }
}
