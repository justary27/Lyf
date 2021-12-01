import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lyf/src/routes/routing.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onHorizontalDragEnd: (dragDetails) {
        if (dragDetails.primaryVelocity! > 0) {
          RouteManager.navigateToDrawer(context);
        }
      },
      child: Stack(
        children: [
          Container(
            height: size.height,
            width: size.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.grey.shade700,
                Colors.grey.shade900,
                Colors.black
              ],
            )),
            child: CustomPaint(
              painter: HomePainter(),
            ),
          ),
          Material(
            color: Colors.transparent,
            child: Container(
              height: size.height,
              width: size.width,
              decoration: const BoxDecoration(),
              child: Column(
                children: [
                  Container(
                    height: 0.5 * size.height,
                    padding: EdgeInsets.symmetric(
                        horizontal: 0.1 * size.width,
                        vertical: 0.1 * size.height),
                    width: size.width,
                    child: Text(
                      "Good Morning, Aryan",
                      style: GoogleFonts.ubuntu(
                          textStyle: const TextStyle(
                              color: Colors.white, fontSize: 50)),
                    ),
                  ),
                  Container(
                    height: 0.5 * size.height,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(
                      horizontal: 0.05 * size.width,
                    ),
                    child: GridView.count(
                      //shrinkWrap: true,
                      crossAxisCount: 2,
                      children: [
                        Card(
                          clipBehavior: Clip.antiAlias,
                          color: Colors.white.withOpacity(0.15),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                          child: InkWell(
                            onTap: () {
                              RouteManager.navigateToTodo(context);
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: Icon(
                                    Icons.note_add_outlined,
                                    size: 40,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "Add TODO",
                                  style: GoogleFonts.ubuntu(
                                      textStyle: const TextStyle(
                                    color: Colors.white,
                                  )),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          clipBehavior: Clip.antiAlias,
                          color: Colors.white.withOpacity(0.15),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                          child: InkWell(
                            onTap: () {
                              RouteManager.navigateToDiary(context);
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: Icon(
                                    Icons.note,
                                    size: 40,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "Add Diary Entry",
                                  style: GoogleFonts.ubuntu(
                                      textStyle: const TextStyle(
                                    color: Colors.white,
                                  )),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          clipBehavior: Clip.antiAlias,
                          color: Colors.white.withOpacity(0.5),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                          child: InkWell(
                            onTap: () {},
                          ),
                        ),
                        Card(
                          clipBehavior: Clip.antiAlias,
                          color: Colors.white.withOpacity(0.15),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                          child: InkWell(
                            onTap: () {},
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    Paint paint = Paint()
      ..color = Colors.white.withOpacity(0.5)
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(
        Offset(size.width, 0.55 * size.height), 0.25 * size.height, paint);
    canvas.drawCircle(Offset(size.width, 0.55 * size.height),
        0.01 * size.height, paint..style = PaintingStyle.fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
