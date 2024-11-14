import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Greetings extends StatefulWidget {
  final String username;
  const Greetings({super.key, required this.username});

  @override
  State<Greetings> createState() => _GreetingsState();
}

class _GreetingsState extends State<Greetings> {
  late String greeting;
  late DateTime currentTime;
  late Timer _timer;
  @override
  void initState() {
    currentTime = DateTime.now();
    startTimer();
    super.initState();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      setState(() {
        currentTime = DateTime.now();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (currentTime.hour >= 4 && currentTime.hour < 12) {
      greeting = AppLocalizations.of(context)!.goodMorning;
    } else if (currentTime.hour >= 12 && currentTime.hour < 16) {
      greeting = AppLocalizations.of(context)!.goodAfternoon;
    } else if (currentTime.hour >= 16 && currentTime.hour < 20) {
      greeting = AppLocalizations.of(context)!.goodEvening;
    } else {
      greeting = AppLocalizations.of(context)!.goodNight;
    }
    final String username = widget.username;
    return Text(
      "$greeting, $username",
      style: Theme.of(context).textTheme.displayLarge,
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
