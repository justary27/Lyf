import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lyf/src/constants/theme_constants.dart';
import 'package:lyf/src/routes/routing.dart';
import 'package:lyf/src/state/theme/theme_state.dart';

class ThemeSettingsPage extends ConsumerStatefulWidget {
  const ThemeSettingsPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ThemeSettingsPageState();
}

class _ThemeSettingsPageState extends ConsumerState<ThemeSettingsPage> {
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
                "Themes",
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
            backgroundColor: Colors.transparent,
            body: SizedBox(
              width: size.width,
              height: size.height,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 0.05 * size.width,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: size.width,
                      height: 0.15 * size.height,
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 0.05 * size.width,
                          vertical: 0.025 * size.height,
                        ),
                        leading: Icon(
                          Icons.mode_night_outlined,
                          color: Theme.of(context).iconTheme.color,
                          size: 35,
                        ),
                        title: Text(
                          "App Themes",
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        subtitle: Text(
                          "Choose the app's theme.",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        tileColor: Colors.transparent,
                      ),
                    ),
                    SizedBox(
                      width: size.width,
                      height: 0.70 * size.height,
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: ((context, index) {
                          return ListTile(
                            leading: Container(
                              padding: EdgeInsets.all(5),
                              width: 50,
                              decoration: BoxDecoration(
                                color: Color(
                                  themeConstants[index]['bColor'],
                                ),
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  "assets/images/lyf.svg",
                                  color: Color(
                                    themeConstants[index]['iColor'],
                                  ),
                                ),
                              ),
                            ),
                            title: Text(
                              themeConstants[index]['themeName'],
                              style: Theme.of(context).textTheme.headline3,
                            ),
                            subtitle: Text(
                              themeConstants[index]['desc'],
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                            onTap: () {
                              ref.read(themeNotifier.notifier).changeTheme(
                                    themeConstants[index]['theme'],
                                  );
                            },
                            tileColor: Colors.transparent,
                          );
                        }),
                        itemCount: 3,
                      ),
                      // child: GridView.count(
                      //   crossAxisCount: 2,
                      //   children: [
                      //     Card(
                      //       clipBehavior: Clip.antiAlias,
                      //       shape: const RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.all(
                      //           Radius.circular(12),
                      //         ),
                      //       ),
                      //       color: Colors.white.withOpacity(0.15),
                      //       child: InkWell(
                      //         onTap: () {},
                      //         child: Column(
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: [
                      //             Container(
                      //               width: 0.425 * size.width,
                      //               height: 0.10 * size.height,
                      //               color: Colors.white.withOpacity(0.35),
                      //             ),
                      //             Container(
                      //               padding: EdgeInsets.symmetric(
                      //                 horizontal: 0.025 * size.width,
                      //                 vertical: 0.0125 * size.height,
                      //               ),
                      //               width: 0.425 * size.width,
                      //               height: 0.10 * size.height,
                      //               child: Column(
                      //                 crossAxisAlignment:
                      //                     CrossAxisAlignment.start,
                      //                 children: [
                      //                   Text(
                      //                     "Lyf",
                      //                     style: Theme.of(context)
                      //                         .textTheme
                      //                         .headline3,
                      //                   ),
                      //                   Padding(
                      //                     padding: const EdgeInsets.fromLTRB(
                      //                         0, 8, 0, 0),
                      //                     child: Text(
                      //                       "The default theme of the Lyf app.",
                      //                       style: Theme.of(context)
                      //                           .textTheme
                      //                           .bodyText2,
                      //                     ),
                      //                   )
                      //                 ],
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     ),
                      //     Card(
                      //       clipBehavior: Clip.antiAlias,
                      //       shape: const RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.all(
                      //           Radius.circular(12),
                      //         ),
                      //       ),
                      //       color: Colors.white.withOpacity(0.15),
                      //       child: InkWell(
                      //         onTap: () {},
                      //         child: Column(
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: [
                      //             Container(
                      //               width: 0.425 * size.width,
                      //               height: 0.10 * size.height,
                      //               color: Colors.white.withOpacity(0.35),
                      //             ),
                      //             Container(
                      //               padding: EdgeInsets.symmetric(
                      //                 horizontal: 0.025 * size.width,
                      //                 vertical: 0.0125 * size.height,
                      //               ),
                      //               width: 0.425 * size.width,
                      //               height: 0.10 * size.height,
                      //               child: Column(
                      //                 crossAxisAlignment:
                      //                     CrossAxisAlignment.start,
                      //                 children: [
                      //                   Text(
                      //                     "Monochrome",
                      //                     style: Theme.of(context)
                      //                         .textTheme
                      //                         .headline3,
                      //                   ),
                      //                   Padding(
                      //                     padding: const EdgeInsets.fromLTRB(
                      //                         0, 8, 0, 0),
                      //                     child: Text(
                      //                       "The classic black and white theme.",
                      //                       style: Theme.of(context)
                      //                           .textTheme
                      //                           .bodyText2,
                      //                     ),
                      //                   )
                      //                 ],
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
