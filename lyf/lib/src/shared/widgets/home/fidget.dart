import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Fidget extends StatefulWidget {
  final Size size;
  const Fidget({
    Key? key,
    required this.size,
  }) : super(key: key);

  @override
  State<Fidget> createState() => _FidgetState();
}

class _FidgetState extends State<Fidget> {
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
    return Transform.rotate(
      angle: pi * sin(DateTime.now().second / 15),
      child: SvgPicture.asset(
        "assets/images/fidget_spinner.svg",
        height: 0.325 * size.height,
        color: Theme.of(context).primaryColor.withOpacity(0.75),
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
