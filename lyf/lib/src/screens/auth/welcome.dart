import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lyf/src/routes/routing.dart';
import 'package:lyf/src/shared/lyf.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

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
              colors: [
                Colors.grey.shade700,
                Colors.grey.shade900,
                Colors.black
              ],
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
                child: const Lyf(),
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
                                textStyle: TextStyle(
                                    fontSize: 60, color: Colors.white),
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
                              RouteManager.navigateToSignUp(context);
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
                              RouteManager.navigateToLogin(context);
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
