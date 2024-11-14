import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../global/functions.dart';
import '../global/variables.dart';
import '../routes/routing.dart';
import '../state/theme/theme_state.dart';
import '../utils/handlers/route_handler.dart';

/// The App's first screen. This is shown after first
/// pixel is painted by flutter. Navigates the user
/// according to their [loginState].
class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initRouteProvider();
  }

  /// Provides the initial route for the app.
  Future<void> _initRouteProvider() async {
    try {
      await login(creds);
      if (loginState) {
        goRouter.replace(RouteHandler.home);
      } else {
        goRouter.replace(RouteHandler.login);
      }
    } catch (e) {
      print(e);
      goRouter.replace(RouteHandler.login);
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
            colors: ref.read(themeNotifier).gradientColors.reversed.toList(),
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
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).primaryColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              Text(
                "Lyf",
                style: Theme.of(context).textTheme.displayMedium,
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
}
