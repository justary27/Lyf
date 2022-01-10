import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lyf/src/routes/routing.dart';

class ThemeSettingsPage extends StatefulWidget {
  const ThemeSettingsPage({Key? key}) : super(key: key);

  @override
  _ThemeSettingsPageState createState() => _ThemeSettingsPageState();
}

class _ThemeSettingsPageState extends State<ThemeSettingsPage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.grey.shade700, Colors.grey.shade900, Colors.black],
          )),
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
                  RouteManager.navigateToSettings(context);
                },
                icon: Icon(Icons.arrow_back_ios),
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
                          color: Colors.white,
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
                      ),
                    ),
                    SizedBox(
                      width: size.width,
                      height: 0.70 * size.height,
                      child: GridView.count(
                        crossAxisCount: 2,
                        children: [
                          Card(
                            clipBehavior: Clip.antiAlias,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                            ),
                            color: Colors.white.withOpacity(0.15),
                            child: InkWell(
                              onTap: () {},
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 0.425 * size.width,
                                    height: 0.10 * size.height,
                                    color: Colors.white.withOpacity(0.35),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 0.025 * size.width,
                                      vertical: 0.0125 * size.height,
                                    ),
                                    width: 0.425 * size.width,
                                    height: 0.10 * size.height,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Lyf",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline3,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 8, 0, 0),
                                          child: Text(
                                            "The default theme of the Lyf app.",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Card(
                            clipBehavior: Clip.antiAlias,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                            ),
                            color: Colors.white.withOpacity(0.15),
                            child: InkWell(
                              onTap: () {},
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 0.425 * size.width,
                                    height: 0.10 * size.height,
                                    color: Colors.white.withOpacity(0.35),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 0.025 * size.width,
                                      vertical: 0.0125 * size.height,
                                    ),
                                    width: 0.425 * size.width,
                                    height: 0.10 * size.height,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Monochrome",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline3,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 8, 0, 0),
                                          child: Text(
                                            "The classic black and white theme.",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
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
