import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    // TODO: implement initState
    super.initState();
    initRouteProvider();
  }

  Future<void> initRouteProvider() async {
    creds = await getCredentials();
    try {
      await login(creds);
    } catch (e) {}
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
                .gradientColors,
          ),
        ),
        child: Center(
          child: Column(
            children: [
              SvgPicture.asset(
                "assets/images/lyf.svg",
                color: Theme.of(context).primaryColor,
              ),
              const CircularProgressIndicator.adaptive(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
