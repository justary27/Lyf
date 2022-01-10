import 'dart:async';
import 'package:flutter/material.dart';

class Greetings extends StatefulWidget {
  final String username;
  const Greetings({Key? key, required this.username}) : super(key: key);

  @override
  _GreetingsState createState() => _GreetingsState();
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
      greeting = "Good Morning";
    } else if (currentTime.hour >= 12 && currentTime.hour < 16) {
      greeting = "Good Afternoon";
    } else if (currentTime.hour >= 16 && currentTime.hour < 20) {
      greeting = "Good Evening";
    } else {
      greeting = "Good Night";
    }
    final String username = widget.username;
    return Text(
      "$greeting, $username",
      style: Theme.of(context).textTheme.headline1,
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
