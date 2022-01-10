import 'package:flutter/material.dart';
import 'package:svg_path_parser/svg_path_parser.dart';

class Lyf extends StatefulWidget {
  const Lyf({Key? key}) : super(key: key);

  @override
  _LyfState createState() => _LyfState();
}

class _LyfState extends State<Lyf> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: LyfPainter(),
    );
  }
}

class LyfPainter extends CustomPainter {
  // final Size size;

  // LyfPainter(this.size);
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.white.withOpacity(0.10)
      ..strokeWidth = 3;
    Path path = parseSvgPath(
        "M290.012 696.897C67.6776 798.283 -22.1569 542.007 12.0545 477.324M290.012 696.897C182.537 647.362 121.744 601.471 12.0545 477.324M290.012 696.897C506.232 671.075 575.303 556.848 607.678 177.905M290.012 696.897C290.73 657.075 287.897 624.184 281.137 597.091M290.012 696.897C440.405 513.448 507.866 398.285 607.678 177.905M12.0545 477.324C103.986 475.889 170.412 481.52 215.236 505.97M607.678 177.905C481.091 258.683 397.184 320.661 343.978 372.628C339.149 377.344 334.573 381.978 330.241 386.536M281.137 597.091C270.128 552.967 248.703 524.224 215.236 505.97M281.137 597.091C253.321 525.971 252.307 468.536 330.241 386.536M281.137 11C65.7545 330.89 127.662 467.309 215.236 505.97M281.137 11C240.409 236.912 206.241 346.974 257.284 539.533M281.137 11C399.095 272.485 350.399 367.991 330.241 386.536");

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
