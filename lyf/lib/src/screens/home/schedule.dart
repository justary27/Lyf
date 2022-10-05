import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lyf/src/routes/routing.dart';

class ScheduleSideDrawer extends StatefulWidget {
  const ScheduleSideDrawer({Key? key}) : super(key: key);

  @override
  _ScheduleSideDrawerState createState() => _ScheduleSideDrawerState();
}

class _ScheduleSideDrawerState extends State<ScheduleSideDrawer> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onHorizontalDragEnd: (dragDetails) {
        if (dragDetails.primaryVelocity! < 0) {}
      },
      child: Material(
        color: Colors.transparent,
        child: Container(
          height: size.height,
          width: 0.6 * size.width,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.grey.shade700,
              Colors.grey.shade800,
              Colors.grey.shade900,
            ],
          )),
          child: CustomPaint(
            painter: ScheduleSidePainter(),
            child: Column(
              children: [
                Container(
                  height: 0.4 * size.height,
                  width: 0.6 * size.width,
                  alignment: Alignment.center,
                  child: Material(
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const CircleAvatar(
                          radius: 50,
                        ),
                        IconButton(
                          splashColor: Colors.white.withOpacity(0.2),
                          onPressed: () {
                            // RouteManager.navigateToSettings(context);
                          },
                          icon: const Icon(
                            Icons.settings,
                            color: Colors.white,
                            size: 35,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 0.4 * size.height,
                  width: 0.6 * size.width,
                  alignment: Alignment.center,
                  child: Material(
                    color: Colors.transparent,
                    child: ListView(
                      children: [
                        ListTile(
                          focusColor: Colors.white.withOpacity(0.15),
                          hoverColor: Colors.white.withOpacity(0.15),
                          title: Text(
                            "TODOs",
                            style: GoogleFonts.ubuntu(
                              textStyle: const TextStyle(color: Colors.white),
                            ),
                          ),
                          leading: const Icon(
                            Icons.note_add,
                            color: Colors.white,
                          ),
                          onTap: () {
                            // RouteManager.navigateToTodo(context);
                          },
                        ),
                        ListTile(
                          focusColor: Colors.white.withOpacity(0.15),
                          hoverColor: Colors.white.withOpacity(0.15),
                          leading: const Icon(
                            Icons.note,
                            color: Colors.white,
                          ),
                          title: Text(
                            "Diary Entries",
                            style: GoogleFonts.ubuntu(
                              textStyle: const TextStyle(color: Colors.white),
                            ),
                          ),
                          onTap: () {
                            // RouteManager.navigateToDiary(context);
                          },
                        ),
                        ListTile(
                          // focusColor: Colors.black.withOpacity(0.5),
                          // hoverColor: Colors.black.withOpacity(0.5),
                          // tileColor: Colors.white.withOpacity(0.15),
                          leading: const Icon(
                            Icons.note_add,
                            color: Colors.white,
                          ),
                          title: Text(
                            "TODO",
                            style: GoogleFonts.ubuntu(
                              textStyle: const TextStyle(color: Colors.white),
                            ),
                          ),
                          onTap: () {},
                        ),
                        ListTile(
                          focusColor: Colors.white.withOpacity(0.15),
                          hoverColor: Colors.white.withOpacity(0.15),
                          leading: const Icon(
                            Icons.note_add,
                            color: Colors.white,
                          ),
                          title: Text(
                            "TODO",
                            style: GoogleFonts.ubuntu(
                              textStyle: const TextStyle(color: Colors.white),
                            ),
                          ),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ScheduleSidePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    Paint paint = Paint()
      ..color = Colors.white.withOpacity(0.5)
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    path.moveTo(0.3 * size.width, 0);
    path.lineTo(0, 0);
    path.lineTo(0, size.height);
    path.lineTo(0.6 * size.width, size.height);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
