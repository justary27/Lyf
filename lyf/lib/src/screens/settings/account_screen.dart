import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lyf/src/global/variables.dart';
import 'package:lyf/src/models/user_model.dart';
import 'package:lyf/src/routes/routing.dart';
import 'package:lyf/src/services/firebase/auth_service.dart';
import 'package:lyf/src/services/user.dart';
import 'package:lyf/src/utils/handlers/route_handler.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../state/theme/theme_state.dart';

class AccountSettingsScreen extends ConsumerStatefulWidget {
  const AccountSettingsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AccountSettingsScreenState();
}

class _AccountSettingsScreenState extends ConsumerState<AccountSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    var theme = ref.watch(themeNotifier);

    double _sigmaX = 0;
    double _sigmaY = 0;
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
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: _sigmaX, sigmaY: _sigmaY),
            child: Scaffold(
              appBar: AppBar(
                // shadowColor: Colors.transparent,
                backgroundColor: Colors.transparent,
                leading: IconButton(
                  onPressed: () async {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    await Future.delayed(
                      const Duration(milliseconds: 100),
                    );
                    goRouter.pop();
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Theme.of(context).iconTheme.color,
                  ),
                ),
                title: Text(
                  AppLocalizations.of(context)!.account,
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
              backgroundColor: Colors.transparent,
              body: ListView(
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
                          leading: Icon(
                            Icons.info_outline_rounded,
                            color: Theme.of(context).iconTheme.color,
                            size: 35,
                          ),
                          title: Text(
                            AppLocalizations.of(context)!.accountInfo,
                            style: Theme.of(context).textTheme.headline2,
                          ),
                          subtitle: Text(
                            AppLocalizations.of(context)!.accountInfoDesc,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 0.05 * size.width,
                            vertical: 0.025 * size.height,
                          ),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              bottomLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                            ),
                          ),
                          tileColor: Theme.of(context).listTileTheme.tileColor,
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                padding: EdgeInsets.zero,
                                dismissDirection: DismissDirection.startToEnd,
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.white,
                                content: ListTile(
                                  leading: Icon(
                                    Icons.warning_rounded,
                                    color: Colors.grey.shade700,
                                  ),
                                  title: Text(
                                    "Username can't be changed.",
                                    style: GoogleFonts.aBeeZee(
                                      textStyle: TextStyle(
                                        color: Colors.grey.shade700,
                                      ),
                                    ),
                                  ),
                                ),

                                // content: Text(
                                //   "Username can't be changed.",
                                //   style: GoogleFonts.aBeeZee(
                                //     textStyle: TextStyle(
                                //       color: Colors.black.withOpacity(0.75),
                                //     ),
                                //   ),
                                // ),
                                duration: const Duration(seconds: 1),
                              ),
                            );
                          },
                          title: Text(
                            AppLocalizations.of(context)!.username,
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          subtitle: Text(
                            currentUser.userName,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                        // ListTile(
                        //   contentPadding: EdgeInsets.symmetric(
                        //     horizontal: 0.05 * size.width,
                        //   ),
                        //   tileColor: Colors.white.withOpacity(0.15),
                        //   onTap: () {},
                        //   title: Text(
                        //     "Change Email",
                        //     style: Theme.of(context).textTheme.headline4,
                        //   ),
                        //   subtitle: Text(
                        //     "Change the email linked with your account.",
                        //     style: Theme.of(context).textTheme.bodyText1,
                        //   ),
                        // ),
                        // ListTile(
                        //   shape: RoundedRectangleBorder(
                        //     borderRadius: BorderRadius.only(
                        //       bottomLeft: Radius.circular(12),
                        //       bottomRight: Radius.circular(12),
                        //     ),
                        //   ),
                        //   contentPadding: EdgeInsets.symmetric(
                        //     horizontal: 0.05 * size.width,
                        //     vertical: 0.0125 * size.height,
                        //   ),
                        //   tileColor: Colors.white.withOpacity(0.15),
                        //   title: Text(
                        //     "Usage",
                        //     style: Theme.of(context).textTheme.headline4,
                        //   ),
                        //   isThreeLine: true,
                        //   subtitle: Column(
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: [
                        //       Text(
                        //         "A visual representation of your daily usage.",
                        //         style: Theme.of(context).textTheme.bodyText1,
                        //       ),
                        //       Card(),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  // Padding(
                  //   padding: EdgeInsets.symmetric(
                  //     horizontal: 0.05 * size.width,
                  //   ),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.center,
                  //     children: [
                  //       ListTile(
                  //         contentPadding: EdgeInsets.symmetric(
                  //           horizontal: 0.05 * size.width,
                  //           vertical: 0.025 * size.height,
                  //         ),
                  //         leading: Icon(
                  //           Icons.lock_outline_rounded,
                  //           color: Colors.white,
                  //           size: 35,
                  //         ),
                  //         title: Text(
                  //           "Security",
                  //           style: GoogleFonts.ubuntu(
                  //             textStyle: TextStyle(
                  //               fontSize: 25,
                  //               color: Colors.white,
                  //             ),
                  //           ),
                  //         ),
                  //         subtitle: Text(
                  //           "Important security related settings.",
                  //           style: Theme.of(context).textTheme.bodyText1,
                  //         ),
                  //       ),
                  //       ListTile(
                  //         shape: const RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.only(
                  //             topLeft: Radius.circular(12),
                  //             topRight: Radius.circular(12),
                  //           ),
                  //         ),
                  //         contentPadding: EdgeInsets.symmetric(
                  //           horizontal: 0.05 * size.width,
                  //           vertical: 0.025 * size.height,
                  //         ),
                  //         tileColor: Colors.white.withOpacity(0.15),
                  //         onTap: () {},
                  //         title: Text(
                  //           "Change Password",
                  //           style: Theme.of(context).textTheme.headline4,
                  //         ),
                  //         subtitle: Text(
                  //           "Change your current password.",
                  //           style: Theme.of(context).textTheme.bodyText1,
                  //         ),
                  //       ),
                  //       ListTile(
                  //         onTap: () {},
                  //         contentPadding: EdgeInsets.symmetric(
                  //           horizontal: 0.05 * size.width,
                  //         ),
                  //         tileColor: Colors.white.withOpacity(0.15),
                  //         isThreeLine: true,
                  //         title: Text(
                  //           "Biometrics",
                  //           style: Theme.of(context).textTheme.headline4,
                  //         ),
                  //         subtitle: Text(
                  //           "Change your current password.",
                  //           style: Theme.of(context).textTheme.bodyText1,
                  //         ),
                  //       ),
                  //       ListTile(
                  //         shape: const RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.only(
                  //             bottomLeft: Radius.circular(12),
                  //             bottomRight: Radius.circular(12),
                  //           ),
                  //         ),
                  //         contentPadding: EdgeInsets.symmetric(
                  //           horizontal: 0.05 * size.width,
                  //           vertical: 0.0125 * size.height,
                  //         ),
                  //         tileColor: Colors.white.withOpacity(0.15),
                  //         title: Text(
                  //           "Enable 2FA",
                  //           style: Theme.of(context).textTheme.headline4,
                  //         ),
                  //         isThreeLine: true,
                  //         subtitle: Column(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Text(
                  //               "A visual representation of your daily usage.",
                  //               style: Theme.of(context).textTheme.bodyText1,
                  //             ),
                  //             Card(),
                  //           ],
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
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
                          leading: Icon(
                            Icons.bar_chart_rounded,
                            color: Theme.of(context).iconTheme.color,
                            size: 35,
                          ),
                          title: Text(
                            AppLocalizations.of(context)!.activity,
                            style: Theme.of(context).textTheme.headline2,
                          ),
                          subtitle: Text(
                            AppLocalizations.of(context)!.activityDesc,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                        // ListTile(
                        //   contentPadding: EdgeInsets.symmetric(
                        //     horizontal: 0.05 * size.width,
                        //     vertical: 0.025 * size.height,
                        //   ),
                        //   shape: const RoundedRectangleBorder(
                        //     borderRadius: BorderRadius.only(
                        //       topLeft: Radius.circular(12),
                        //       topRight: Radius.circular(12),
                        //     ),
                        //   ),
                        //   tileColor: Colors.white.withOpacity(0.15),
                        //   onTap: () {},
                        //   title: Text(
                        //     "Request account info",
                        //     style: Theme.of(context).textTheme.headline4,
                        //   ),
                        //   subtitle: Text(
                        //     "Request all data and stats related to your account.",
                        //     style: Theme.of(context).textTheme.bodyText1,
                        //   ),
                        // ),
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 0.05 * size.width,
                            vertical: 0.0125 * size.height,
                          ),
                          tileColor: Theme.of(context).listTileTheme.tileColor,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              // bottomLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                              // bottomRight: Radius.circular(12),
                            ),
                          ),
                          title: Text(
                            AppLocalizations.of(context)!.logout,
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          isThreeLine: true,
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.logoutDesc,
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              ButtonBar(
                                alignment: MainAxisAlignment.start,
                                children: [
                                  TextButton(
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(6.0),
                                          side: BorderSide(color: Colors.red),
                                        ),
                                      ),
                                    ),
                                    onPressed: () async {
                                      goRouter.push(RouteHandler.login);
                                      int x = await FireAuth.logOut();
                                      print(x);
                                      loginState = false;
                                      currentUser = guestUser;
                                      UserCredentials.deleteCredentials();
                                      creds = null;
                                    },
                                    child: Text(
                                      AppLocalizations.of(context)!.logout,
                                      style: GoogleFonts.aBeeZee(
                                          textStyle:
                                              TextStyle(color: Colors.red)),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 0.05 * size.width,
                            vertical: 0.0125 * size.height,
                          ),
                          tileColor: Theme.of(context).listTileTheme.tileColor,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              // topLeft: Radius.circular(12),
                              bottomLeft: Radius.circular(12),
                              // topRight: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                            ),
                          ),
                          isThreeLine: true,
                          title: Text(
                            AppLocalizations.of(context)!.deactivateAccount,
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          subtitle: Column(
                            children: [
                              Text(
                                AppLocalizations.of(context)!
                                    .deactivateAccountDesc,
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              ButtonBar(
                                alignment: MainAxisAlignment.start,
                                children: [
                                  TextButton(
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(6.0),
                                          side: BorderSide(color: Colors.red),
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      TextEditingController
                                          _passwordController =
                                          TextEditingController();
                                      SnackBar confirmationSnackBar = SnackBar(
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                          ),
                                        ),
                                        duration: const Duration(seconds: 30),
                                        backgroundColor: Colors.grey.shade700,
                                        content: Container(
                                          alignment: Alignment.center,
                                          height: 0.170 * size.height,
                                          padding: EdgeInsets.fromLTRB(
                                              // 0.05 * size.width,
                                              0,
                                              0.0125 * size.height,
                                              0,
                                              // 0.05 * size.width,
                                              0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                  0,
                                                  0,
                                                  0,
                                                  0.0275 * size.height,
                                                ),
                                                child: Text(
                                                  "Type in your password to confirm.",
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.ubuntu(
                                                    textStyle: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              TextFormField(
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return "You must fill the password";
                                                  }
                                                },
                                                onFieldSubmitted:
                                                    (value) async {
                                                  if (_passwordController
                                                          .text ==
                                                      currentUser.password) {
                                                    int statusCode;
                                                    statusCode = await LyfUser
                                                        .deactivateAccount();
                                                    if (statusCode == 200) {
                                                      goRouter.push(
                                                          RouteHandler.auth);
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .clearSnackBars();
                                                      loginState = false;
                                                      currentUser = guestUser;
                                                      UserCredentials
                                                          .deleteCredentials();
                                                      creds = null;
                                                    }
                                                  }
                                                },
                                                controller: _passwordController,
                                                obscureText: true,
                                                cursorColor: Colors.white,
                                                style: GoogleFonts.ubuntu(
                                                  textStyle: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      10.0,
                                                    ),
                                                    borderSide: BorderSide(
                                                      color: Colors.white
                                                          .withOpacity(0),
                                                    ),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.white
                                                          .withOpacity(0.5),
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  fillColor: Colors.white
                                                      .withOpacity(0.35),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                      SnackBar snackBar = SnackBar(
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                          ),
                                        ),
                                        duration: const Duration(seconds: 15),
                                        backgroundColor: Colors.grey.shade700,
                                        content: Container(
                                          alignment: Alignment.center,
                                          height: 0.170 * size.height,
                                          padding: EdgeInsets.fromLTRB(
                                            0,
                                            0.0125 * size.height,
                                            0,
                                            0,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                  0,
                                                  0,
                                                  0,
                                                  0.0175 * size.height,
                                                ),
                                                child: Text(
                                                  "Are you sure you want to deactivate your account?",
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.ubuntu(
                                                    textStyle: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: ButtonBar(
                                                  alignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                      width: size.width * 0.40,
                                                      child: TextButton(
                                                        style: ButtonStyle(
                                                          shape: MaterialStateProperty
                                                              .all<
                                                                  RoundedRectangleBorder>(
                                                            RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          6.0),
                                                              side:
                                                                  const BorderSide(
                                                                color:
                                                                    Colors.red,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        onPressed: () {
                                                          ScaffoldMessenger.of(
                                                              context)
                                                            ..hideCurrentSnackBar()
                                                            ..showSnackBar(
                                                                confirmationSnackBar);
                                                        },
                                                        child: Text(
                                                          "Yes",
                                                          style: GoogleFonts
                                                              .aBeeZee(
                                                            textStyle:
                                                                const TextStyle(
                                                              color: Colors.red,
                                                              fontSize: 20,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: size.width * 0.40,
                                                      child: TextButton(
                                                        style: ButtonStyle(
                                                          shape: MaterialStateProperty
                                                              .all<
                                                                  RoundedRectangleBorder>(
                                                            RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                6.0,
                                                              ),
                                                              side: BorderSide(
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        onPressed: () {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .hideCurrentSnackBar();
                                                        },
                                                        child: Text(
                                                          "No",
                                                          style: GoogleFonts
                                                              .aBeeZee(
                                                            textStyle: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 20),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    },
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .deactivateMyAccount,
                                      style: GoogleFonts.aBeeZee(
                                          textStyle:
                                              TextStyle(color: Colors.red)),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        // ListTile(
                        //   shape: RoundedRectangleBorder(
                        //     borderRadius: BorderRadius.only(
                        //       bottomLeft: Radius.circular(12),
                        //       bottomRight: Radius.circular(12),
                        //     ),
                        //   ),
                        //   contentPadding: EdgeInsets.symmetric(
                        //     horizontal: 0.05 * size.width,
                        //     vertical: 0.0125 * size.height,
                        //   ),
                        //   tileColor: Colors.white.withOpacity(0.15),
                        //   title: Text(
                        //     "Delete Account",
                        //     style: Theme.of(context).textTheme.headline4,
                        //   ),
                        //   isThreeLine: true,
                        //   subtitle: Column(
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: [
                        //       Text(
                        //         "This will delete your account permanently.",
                        //         style: Theme.of(context).textTheme.bodyText1,
                        //       ),
                        //       ButtonBar(
                        //         alignment: MainAxisAlignment.start,
                        //         children: [
                        //           TextButton(
                        //             style: ButtonStyle(
                        //               shape: MaterialStateProperty.all<
                        //                   RoundedRectangleBorder>(
                        //                 RoundedRectangleBorder(
                        //                   borderRadius:
                        //                       BorderRadius.circular(6.0),
                        //                   side: BorderSide(color: Colors.red),
                        //                 ),
                        //               ),
                        //             ),
                        //             onPressed: () {
                        //               TextEditingController
                        //                   _passwordController =
                        //                   TextEditingController();
                        //               SnackBar confirmationSnackBar = SnackBar(
                        //                 shape: const RoundedRectangleBorder(
                        //                   borderRadius: BorderRadius.only(
                        //                     topLeft: Radius.circular(10),
                        //                     topRight: Radius.circular(10),
                        //                   ),
                        //                 ),
                        //                 duration: const Duration(seconds: 30),
                        //                 backgroundColor: Colors.grey.shade700,
                        //                 content: Container(
                        //                   alignment: Alignment.center,
                        //                   height: 0.170 * size.height,
                        //                   padding: EdgeInsets.fromLTRB(
                        //                       // 0.05 * size.width,
                        //                       0,
                        //                       0.0125 * size.height,
                        //                       0,
                        //                       // 0.05 * size.width,
                        //                       0),
                        //                   child: Column(
                        //                     crossAxisAlignment:
                        //                         CrossAxisAlignment.center,
                        //                     mainAxisAlignment:
                        //                         MainAxisAlignment.end,
                        //                     children: [
                        //                       Padding(
                        //                         padding: EdgeInsets.fromLTRB(
                        //                           // 0.05 * size.width,
                        //                           0,
                        //                           0, 0,
                        //                           // 0.05 * size.width,
                        //                           0.0275 * size.height,
                        //                         ),
                        //                         child: Text(
                        //                           "Type in your password to confirm.",
                        //                           textAlign: TextAlign.center,
                        //                           style: GoogleFonts.ubuntu(
                        //                             textStyle: const TextStyle(
                        //                               color: Colors.white,
                        //                               fontSize: 20,
                        //                             ),
                        //                           ),
                        //                         ),
                        //                       ),
                        //                       TextFormField(
                        //                         validator: (value) {
                        //                           if (value == null ||
                        //                               value.isEmpty) {
                        //                             return "You must fill the password";
                        //                           }
                        //                         },
                        //                         controller: _passwordController,
                        //                         obscureText: true,
                        //                         cursorColor: Colors.white,
                        //                         style: GoogleFonts.ubuntu(
                        //                           textStyle: const TextStyle(
                        //                               color: Colors.white),
                        //                         ),
                        //                         decoration: InputDecoration(
                        //                           filled: true,
                        //                           border: OutlineInputBorder(
                        //                             borderRadius:
                        //                                 BorderRadius.circular(
                        //                                     10.0),
                        //                             borderSide: BorderSide(
                        //                               color: Colors.white
                        //                                   .withOpacity(0),
                        //                             ),
                        //                           ),
                        //                           focusedBorder:
                        //                               OutlineInputBorder(
                        //                             borderSide: BorderSide(
                        //                                 color: Colors.white
                        //                                     .withOpacity(0.5),
                        //                                 width: 1.0),
                        //                           ),
                        //                           fillColor: Colors.white
                        //                               .withOpacity(0.35),
                        //                         ),
                        //                       )
                        //                     ],
                        //                   ),
                        //                 ),
                        //               );
                        //               SnackBar snackBar = SnackBar(
                        //                 shape: const RoundedRectangleBorder(
                        //                   borderRadius: BorderRadius.only(
                        //                     topLeft: Radius.circular(10),
                        //                     topRight: Radius.circular(10),
                        //                   ),
                        //                 ),
                        //                 duration: const Duration(seconds: 15),
                        //                 backgroundColor: Colors.grey.shade700,
                        //                 content: Container(
                        //                   alignment: Alignment.center,
                        //                   height: 0.170 * size.height,
                        //                   padding: EdgeInsets.fromLTRB(
                        //                     0,
                        //                     0.0125 * size.height,
                        //                     0,
                        //                     0,
                        //                   ),
                        //                   child: Column(
                        //                     crossAxisAlignment:
                        //                         CrossAxisAlignment.center,
                        //                     mainAxisAlignment:
                        //                         MainAxisAlignment.end,
                        //                     children: [
                        //                       Padding(
                        //                         padding: EdgeInsets.fromLTRB(
                        //                           0,
                        //                           0,
                        //                           0,
                        //                           0.0175 * size.height,
                        //                         ),
                        //                         child: Text(
                        //                           "Are you absolutely sure you want to delete your account?",
                        //                           textAlign: TextAlign.center,
                        //                           style: GoogleFonts.ubuntu(
                        //                             textStyle: const TextStyle(
                        //                               color: Colors.white,
                        //                               fontSize: 20,
                        //                             ),
                        //                           ),
                        //                         ),
                        //                       ),
                        //                       Expanded(
                        //                         child: ButtonBar(
                        //                           alignment:
                        //                               MainAxisAlignment.center,
                        //                           children: [
                        //                             SizedBox(
                        //                               width: size.width * 0.40,
                        //                               child: TextButton(
                        //                                 style: ButtonStyle(
                        //                                   shape: MaterialStateProperty
                        //                                       .all<
                        //                                           RoundedRectangleBorder>(
                        //                                     RoundedRectangleBorder(
                        //                                       borderRadius:
                        //                                           BorderRadius
                        //                                               .circular(
                        //                                                   6.0),
                        //                                       side: const BorderSide(
                        //                                           color: Colors
                        //                                               .red),
                        //                                     ),
                        //                                   ),
                        //                                 ),
                        //                                 onPressed: () {
                        //                                   ScaffoldMessenger.of(
                        //                                           context)
                        //                                       .hideCurrentSnackBar();
                        //                                   ScaffoldMessenger.of(
                        //                                           context)
                        //                                       .showSnackBar(
                        //                                           confirmationSnackBar);
                        //                                 },
                        //                                 child: Text(
                        //                                   "Yes",
                        //                                   style: GoogleFonts
                        //                                       .aBeeZee(
                        //                                     textStyle:
                        //                                         const TextStyle(
                        //                                             color: Colors
                        //                                                 .red,
                        //                                             fontSize:
                        //                                                 20),
                        //                                   ),
                        //                                 ),
                        //                               ),
                        //                             ),
                        //                 SizedBox(
                        //                   width: size.width * 0.40,
                        //                   child: TextButton(
                        //                     style: ButtonStyle(
                        //                       shape: MaterialStateProperty
                        //                           .all<
                        //                               RoundedRectangleBorder>(
                        //                         RoundedRectangleBorder(
                        //                           borderRadius:
                        //                               BorderRadius
                        //                                   .circular(
                        //                                       6.0),
                        //                           side: BorderSide(
                        //                               color: Colors
                        //                                   .white),
                        //                         ),
                        //                       ),
                        //                     ),
                        //                     onPressed: () {
                        //                       ScaffoldMessenger.of(
                        //                               context)
                        //                           .hideCurrentSnackBar();
                        //                     },
                        //                     child: Text(
                        //                       "No",
                        //                       style: GoogleFonts
                        //                           .aBeeZee(
                        //                         textStyle: TextStyle(
                        //                             color: Colors
                        //                                 .white,
                        //                             fontSize: 20),
                        //                       ),
                        //                     ),
                        //                   ),
                        //                 )
                        //               ],
                        //             ),
                        //           )
                        //         ],
                        //       ),
                        //     ),
                        //   );
                        //   ScaffoldMessenger.of(context)
                        //       .showSnackBar(snackBar);
                        // },
                        // child: Text(
                        //   "Delete my account",
                        //   style: GoogleFonts.aBeeZee(
                        //       textStyle:
                        //           TextStyle(color: Colors.red)),
                        // ),
                        // )
                        // ],
                        // ),
                        // ],
                        // ),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
