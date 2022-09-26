import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lyf/src/routes/routing.dart';

import '../../state/theme/theme_state.dart';

class SideDrawer extends ConsumerStatefulWidget {
  const SideDrawer({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SideDrawerState();
}

class _SideDrawerState extends ConsumerState<SideDrawer> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    var theme = ref.read(themeNotifier.notifier).getCurrentState();

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
              colors: theme.gradientColors,
            ),
          ),
          child: CustomPaint(
            painter: SidePainter(context),
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
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Padding(
                            //   padding: EdgeInsets.all(8.0),
                            //   child: Text(
                            //     "Aryan",
                            //     style: Theme.of(context).textTheme.headline4,
                            //   ),
                            // ),
                            Material(
                              shape: CircleBorder(),
                              clipBehavior: Clip.hardEdge,
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  RouteManager.navigateToProfilePicture(
                                      context);
                                },
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundColor:
                                      Colors.white.withOpacity(0.15),
                                  backgroundImage:
                                      AssetImage("assets/images/diary.jpg"),
                                ),
                                // child: Ink.image(image: AssetImage("assets/images/diary.jpg"),),
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          splashColor: Colors.white.withOpacity(0.2),
                          onPressed: () {
                            RouteManager.navigateToSettings(context);
                          },
                          icon: const Icon(
                            Icons.settings,
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
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        ListTile(
                          focusColor: Colors.white.withOpacity(0.15),
                          hoverColor: Colors.white.withOpacity(0.15),
                          title: Text(
                            "TODOs",
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          leading: SvgPicture.asset(
                            "assets/images/todo.svg",
                            color: Theme.of(context).iconTheme.color,
                            height: 25,
                          ),
                          onTap: () {
                            RouteManager.navigateToTodo(context);
                          },
                        ),
                        ListTile(
                          focusColor: Colors.white.withOpacity(0.15),
                          hoverColor: Colors.white.withOpacity(0.15),
                          leading: SvgPicture.asset(
                            "assets/images/diary.svg",
                            color: Theme.of(context).iconTheme.color,
                            height: 25,
                          ),
                          title: Text(
                            "Diary Entries",
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          onTap: () {
                            RouteManager.navigateToDiary(context);
                          },
                        ),
                        // ListTile(
                        //   // focusColor: Colors.black.withOpacity(0.5),
                        //   // hoverColor: Colors.black.withOpacity(0.5),
                        //   // tileColor: Colors.white.withOpacity(0.15),
                        //   leading: SvgPicture.asset(
                        //     "assets/images/statHealth.svg",
                        //     height: 25,
                        //   ),
                        //   title: Text(
                        //     "StatHealth",
                        //     style: Theme.of(context).textTheme.headline4,
                        //   ),
                        //   onTap: () {},
                        // ),
                        // ListTile(
                        //   focusColor: Colors.white.withOpacity(0.15),
                        //   hoverColor: Colors.white.withOpacity(0.15),
                        //   leading: const Icon(
                        //     Icons.note_add,
                        //     color: Colors.white,
                        //   ),
                        //   title: Text(
                        //     "TODO",
                        //     style: Theme.of(context).textTheme.headline4,
                        //   ),
                        //   onTap: () {},
                        // ),
                      ],
                    ),
                  ),
                ),
                // Container(
                //   height: 0.10 * size.height,
                // ),
                // SvgPicture.asset(
                //   "assets/images/lyf.svg",
                //   width: 40,
                //   color: Colors.white.withOpacity(0.35),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SidePainter extends CustomPainter {
  final BuildContext context;

  SidePainter(this.context);

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    Paint paint = Paint()
      ..color = Theme.of(context).primaryColor.withOpacity(0.6)
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    path.moveTo(0.7 * size.width, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0.4 * size.width, size.height);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
