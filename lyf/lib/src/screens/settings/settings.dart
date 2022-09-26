import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lyf/src/global/variables.dart';
import 'package:lyf/src/routes/routing.dart';

import '../../state/theme/theme_state.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
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
              shadowColor: Colors.transparent,
              backgroundColor: Colors.transparent,
              leading: IconButton(
                onPressed: () {
                  RouteManager.navigateToHome(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
            ),
            backgroundColor: Colors.transparent,
            body: ListView(
              physics: const BouncingScrollPhysics(),
              clipBehavior: Clip.antiAlias,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 0.25 * size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Hero(
                        tag: 'pfp',
                        child: Material(
                          shape: CircleBorder(),
                          clipBehavior: Clip.hardEdge,
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              RouteManager.navigateToProfilePicture(context);
                            },
                            child: CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.white.withOpacity(0.15),
                              backgroundImage:
                                  AssetImage("assets/images/diary.jpg"),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 0.025 * size.height),
                        child: Text(
                          currentUser.userName,
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 0.05 * size.width),
                  // height: 0.50 * size.height,
                  child: Column(
                    // clipBehavior: Clip.antiAlias,
                    children: [
                      ListTile(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                        ),
                        tileColor: Theme.of(context).listTileTheme.tileColor,
                        leading: Icon(
                          Icons.manage_accounts_outlined,
                          color: Theme.of(context).iconTheme.color,
                        ),
                        onTap: () {
                          RouteManager.navigateToAccountSettings(context);
                        },
                        title: Text(
                          "Account",
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        subtitle: Text(
                          "Account info, security, activity.",
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ),
                      // ListTile(
                      //   tileColor: Colors.white.withOpacity(0.15),
                      //   leading: Icon(
                      //     Icons.stacked_bar_chart_outlined,
                      //     color: Colors.white,
                      //   ),
                      //   onTap: () {},
                      //   title: Text(
                      //     "Data",
                      //     style: Theme.of(context).textTheme.headline4,
                      //   ),
                      //   subtitle: Text(
                      //     "Invite a friend",
                      //     style: Theme.of(context).textTheme.bodyText1,
                      //   ),
                      // ),
                      // ListTile(
                      //   tileColor: Colors.white.withOpacity(0.15),
                      //   leading: Icon(
                      //     Icons.access_alarm,
                      //     color: Colors.white,
                      //   ),
                      //   onTap: () {
                      //     RouteManager.navigateToNotificationSettings(context);
                      //   },
                      //   title: Text(
                      //     "Notifications",
                      //     style: Theme.of(context).textTheme.headline4,
                      //   ),
                      //   subtitle: Text(
                      //     "Invite a friend",
                      //     style: Theme.of(context).textTheme.bodyText1,
                      //   ),
                      // ),
                      // ListTile(
                      //   tileColor: Colors.white.withOpacity(0.15),
                      //   leading: Icon(
                      //     // Icons.language_rounded,
                      //     FontAwesomeIcons.language,
                      //     color: Colors.white,
                      //   ),
                      //   onTap: () {
                      //     RouteManager.navigateToThemeSettings(context);
                      //   },
                      //   title: Text(
                      //     "Language",
                      //     style: Theme.of(context).textTheme.headline4,
                      //   ),
                      //   subtitle: Text(
                      //     "Change the app's language.",
                      //     style: Theme.of(context).textTheme.bodyText1,
                      //   ),
                      // ),
                      // ListTile(
                      //   tileColor: Colors.white.withOpacity(0.15),
                      //   leading: Icon(
                      //     Icons.help_outline_rounded,
                      //     color: Colors.white,
                      //   ),
                      //   onTap: () {},
                      //   title: Text(
                      //     "Help Center",
                      //     style: Theme.of(context).textTheme.headline4,
                      //   ),
                      //   subtitle: Text(
                      //     "Invite a friend",
                      //     style: Theme.of(context).textTheme.bodyText1,
                      //   ),
                      // ),
                      // ListTile(
                      //   tileColor: Colors.white.withOpacity(0.15),
                      //   leading: Stack(
                      //     children: [
                      //       Icon(
                      //         FontAwesomeIcons.rupeeSign,
                      //         color: Colors.white,
                      //       ),
                      //     ],
                      //   ),
                      //   onTap: () {
                      //     RouteManager.navigateToThemeSettings(context);
                      //   },
                      //   title: Text(
                      //     "Billing & payments",
                      //     style: Theme.of(context).textTheme.headline4,
                      //   ),
                      //   subtitle: Text(
                      //     "Change the app's theme.",
                      //     style: Theme.of(context).textTheme.bodyText1,
                      //   ),
                      // ),
                      // ListTile(
                      //   tileColor: Colors.white.withOpacity(0.15),
                      //   leading: Icon(
                      //     Icons.access_alarm,
                      //     color: Colors.white,
                      //   ),
                      //   onTap: () {
                      //     RouteManager.navigateToInviteSettings(context);
                      //   },
                      //   title: Text(
                      //     "Invite",
                      //     style: Theme.of(context).textTheme.headline4,
                      //   ),
                      //   subtitle: Text(
                      //     "Invite a friend",
                      //     style: Theme.of(context).textTheme.bodyText1,
                      //   ),
                      // ),
                      ListTile(
                        tileColor: Theme.of(context).listTileTheme.tileColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12),
                          ),
                        ),
                        leading: Icon(
                          Icons.dark_mode_outlined,
                          color: Theme.of(context).iconTheme.color,
                        ),
                        onTap: () {
                          RouteManager.navigateToThemeSettings(context);
                        },
                        title: Text(
                          "Themes",
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        subtitle: Text(
                          "Change the app's theme.",
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 0.50 * size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Crafted by",
                          style: GoogleFonts.caveat(
                            textStyle: TextStyle(
                              fontSize: 15,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 0.05 * size.height,
                        alignment: Alignment.bottomCenter,
                        child: SvgPicture.asset(
                          "assets/images/InCognoS_labs.svg",
                          width: 40,
                          color: Theme.of(context).iconTheme.color,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
