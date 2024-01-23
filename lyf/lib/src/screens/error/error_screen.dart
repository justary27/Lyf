import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../state/theme/theme_state.dart';

/// The default error screen for the app, allows custom
/// error message and cause to be shown.
class ErrorScreen extends ConsumerStatefulWidget {
  final dynamic error;
  const ErrorScreen({
    super.key,
    this.error,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends ConsumerState<ErrorScreen> {
  String buildErrorCode() {
    if (widget.error != null) {
      return widget.error.errorType;
    } else {
      return "404 Not Found!";
    }
  }

  String buildErrorMsg() {
    if (widget.error != null) {
      return widget.error.errorMsg;
    } else {
      return "Oops, looks like you have stepped away from lyf! Relax and chill out!";
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    var theme = ref.watch(themeNotifier);

    return Container(
      height: size.height,
      padding: EdgeInsets.symmetric(horizontal: 0.085 * size.width),
      width: size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: theme.gradientColors,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/images/lyf_broken.svg",
              height: 0.25 * size.height,
              colorFilter: ColorFilter.mode(
                Theme.of(context).primaryColor,
                BlendMode.srcIn,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Text(
                buildErrorCode(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
            Text(
              buildErrorMsg(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      ),
    );
  }
}
