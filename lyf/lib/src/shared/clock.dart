import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class Clock extends StatefulWidget {
  final Size size;
  const Clock({Key? key, required this.size}) : super(key: key);

  @override
  _ClockState createState() => _ClockState();
}

class _ClockState extends State<Clock> {
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
    return CustomPaint(
      painter: ClockPainter(size),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}

class ClockPainter extends CustomPainter {
  Size size;
  ClockPainter(this.size);
  @override
  void paint(Canvas canvas, Size size) {
    Paint framePainter = Paint()
      ..color = Colors.white.withOpacity(0.5)
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(Offset(size.width, 0.55 * size.height),
        0.25 * size.height, framePainter);

    Paint hourPainter = Paint()
      ..color = Colors.white.withOpacity(0.5)
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    double hourX;
    double hourY;
    if (6 <= DateTime.now().hour && DateTime.now().hour < 12) {
      hourX = size.width +
          0.075 *
              size.height *
              sin((DateTime.now().hour + DateTime.now().minute / 60) * pi / 6);
      hourY = 0.55 * size.height -
          0.075 *
              size.height *
              cos((DateTime.now().hour + DateTime.now().minute / 60) * pi / 6);
    } else if (18 > DateTime.now().hour && DateTime.now().hour >= 12) {
      hourX = size.width -
          0.075 *
              size.height *
              sin((DateTime.now().hour + DateTime.now().minute / 60) * pi / 6);
      hourY = 0.55 * size.height -
          0.075 *
              size.height *
              cos((DateTime.now().hour + DateTime.now().minute / 60) * pi / 6);
    } else if (18 <= DateTime.now().hour && DateTime.now().hour < 24) {
      hourX = size.width +
          0.075 *
              size.height *
              sin((DateTime.now().hour + DateTime.now().minute / 60) * pi / 6);
      hourY = 0.55 * size.height -
          0.075 *
              size.height *
              cos((DateTime.now().hour + DateTime.now().minute / 60) * pi / 6);
    } else {
      hourX = size.width -
          0.075 *
              size.height *
              sin((DateTime.now().hour + DateTime.now().minute / 60) * pi / 6);
      hourY = 0.55 * size.height -
          0.075 *
              size.height *
              cos((DateTime.now().hour + DateTime.now().minute / 60) * pi / 6);
    }
    canvas.drawLine(
      Offset(size.width, 0.55 * size.height),
      Offset(hourX, hourY),
      hourPainter,
    );

    Paint minutePainter = Paint()
      ..color = Colors.white.withOpacity(0.5)
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    double minX;
    double minY;
    if (DateTime.now().minute < 30) {
      minX = size.width -
          0.20 *
              size.height *
              sin((DateTime.now().minute + DateTime.now().second / 60) *
                  pi /
                  30);
      minY = 0.55 * size.height -
          0.20 *
              size.height *
              cos((DateTime.now().minute + DateTime.now().second / 60) *
                  pi /
                  30);
    } else {
      minX = size.width +
          0.20 *
              size.height *
              sin((DateTime.now().minute + DateTime.now().second / 60) *
                  pi /
                  30);
      minY = 0.55 * size.height -
          0.20 *
              size.height *
              cos((DateTime.now().minute + DateTime.now().second / 60) *
                  pi /
                  30);
    }
    canvas.drawLine(Offset(size.width, 0.55 * size.height), Offset(minX, minY),
        minutePainter);

    Paint secondPainter = Paint()
      ..color = Colors.white.withOpacity(0.5)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    double secX;
    double secY;
    if (DateTime.now().second < 30) {
      secX = size.width -
          0.20 * size.height * sin(DateTime.now().second * pi / 30);
      secY = 0.55 * size.height -
          0.20 * size.height * cos(DateTime.now().second * pi / 30);
    } else {
      secX = size.width +
          0.20 * size.height * sin(DateTime.now().second * pi / 30);
      secY = 0.55 * size.height -
          0.20 * size.height * cos(DateTime.now().second * pi / 30);
    }
    canvas.drawLine(Offset(size.width, 0.55 * size.height), Offset(secX, secY),
        secondPainter);
    canvas.drawCircle(
        Offset(size.width, 0.55 * size.height),
        0.01 * size.height,
        framePainter
          ..style = PaintingStyle.fill
          ..color = Colors.white);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
