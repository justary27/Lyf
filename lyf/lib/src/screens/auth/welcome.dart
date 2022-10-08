import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lyf/src/routes/routing.dart';
import 'package:lyf/src/shared/lyf.dart';
import 'package:lyf/src/utils/handlers/route_handler.dart';

import '../../state/theme/theme_state.dart';

class WelcomePage extends ConsumerStatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WelcomePageState();
}

class _WelcomePageState extends ConsumerState<WelcomePage> {
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
              colors: ref
                  .read(themeNotifier.notifier)
                  .getCurrentState()
                  .gradientColors,
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 0.1 * size.height,
                width: size.width,
              ),
              SizedBox(
                height: 0.9 * size.height,
                width: size.width,
                child: Lyf(parentContext: context),
              ),
            ],
          ),
        ),
        Material(
          color: Colors.transparent,
          child: Column(
            children: [
              SizedBox(
                height: 0.1 * size.height,
                width: size.width,
              ),
              SizedBox(
                width: size.width,
                height: 0.9 * size.height,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Material(
                        color: Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/images/lyf.svg",
                              width: 40,
                              color: Colors.white,
                            ),
                            Text(
                              "Lyf",
                              style: GoogleFonts.caveat(
                                textStyle: const TextStyle(
                                  fontSize: 60,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 0.25 * size.height,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: SizedBox(
                          width: 0.75 * size.width,
                          height: 50,
                          child: TextButton(
                            onPressed: () {
                              goRouter.push(RouteHandler.signup);
                            },
                            child: Text(
                              "Sign Up",
                              style: GoogleFonts.ubuntu(
                                textStyle: TextStyle(
                                    color: Colors.grey.shade700, fontSize: 20),
                              ),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: SizedBox(
                          width: 0.75 * size.width,
                          height: 50,
                          child: TextButton(
                            onPressed: () {
                              goRouter.push(RouteHandler.login);
                            },
                            child: Text(
                              "Log In",
                              style: GoogleFonts.ubuntu(
                                textStyle: TextStyle(
                                    color: Colors.grey.shade700, fontSize: 20),
                              ),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                          ),
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
    );
  }
}
