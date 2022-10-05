import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lyf/src/routes/routing.dart';
import 'package:lyf/src/state/theme/theme_state.dart';

import '../global/functions.dart';
import '../global/variables.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    initRouteProvider();
  }

  Future<void> initRouteProvider() async {
    try {
      creds = await getCredentials();
      await login(creds);
      print(loginState);
      if (loginState) {
        goRouter.push("/");
      } else {
        goRouter.push("/login");
      }
    } catch (e) {
      print(e);
      goRouter.push("/login");
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            end: Alignment.bottomRight,
            colors: ref
                .read(themeNotifier.notifier)
                .getCurrentState()
                .gradientColors
                .reversed
                .toList(),
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 0.075 * size.height,
                ),
                child: SvgPicture.asset(
                  "assets/images/lyf.svg",
                  width: 0.5 * size.width,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Text(
                "Lyf",
                style: Theme.of(context).textTheme.headline2,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: 0.075 * size.height,
                ),
                child: const CircularProgressIndicator.adaptive(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
