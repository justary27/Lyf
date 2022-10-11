import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Heart extends StatefulWidget {
  final Size size;
  const Heart({
    Key? key,
    required this.size,
  }) : super(key: key);

  @override
  State<Heart> createState() => _HeartState();
}

class _HeartState extends State<Heart> {
  late Timer _timer;
  @override
  void initState() {
    startTimer();
    super.initState();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = widget.size;
    return Icon(
      FontAwesomeIcons.heart,
      size: 0.2 * size.height * (1 + sin(DateTime.now().second / 15)),
      color: Theme.of(context).primaryColor.withOpacity(0.75),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
