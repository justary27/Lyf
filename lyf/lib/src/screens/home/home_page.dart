import 'package:flutter/material.dart';
import 'package:lyf/src/routes/routing.dart';
import 'package:lyf/src/screens/home/drawer.dart';
import 'package:lyf/src/shared/clock.dart';
import 'package:lyf/src/shared/greet.dart';
import 'dart:async';
import 'package:rxdart/rxdart.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late StreamController<bool> isSidebarOpenedStreamController;
  late Stream<bool> isSidebarOpenedStream;
  late StreamSink<bool> isSidebarOpenedSink;
  final _animationDuration = const Duration(milliseconds: 200);

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: _animationDuration);
    isSidebarOpenedStreamController = PublishSubject<bool>();
    isSidebarOpenedStream = isSidebarOpenedStreamController.stream;
    isSidebarOpenedSink = isSidebarOpenedStreamController.sink;
  }

  void openBar() {
    final animationStatus = _animationController.status;
    final isAnimationCompleted = animationStatus == AnimationStatus.completed;

    if (!isAnimationCompleted) {
      isSidebarOpenedSink.add(true);
      _animationController.forward();
    }
  }

  void closeBar() {
    final animationStatus = _animationController.status;
    final isAnimationCompleted = animationStatus == AnimationStatus.completed;

    if (isAnimationCompleted) {
      isSidebarOpenedSink.add(false);
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return StreamBuilder<bool>(
        initialData: true,
        stream: isSidebarOpenedStream,
        builder: (context, snapshot) {
          return AnimatedPositioned(
            left: snapshot.data == true ? 0 : size.width * 0.6,
            // right: isSideBarOpenedAsync.data == false ? 0 : size.width - 45,
            duration: _animationDuration,
            child: GestureDetector(
              onHorizontalDragUpdate: (dragDetails) {
                if (dragDetails.primaryDelta! < -7.5) {
                  openBar();
                } else {
                  closeBar();
                }
              },
              // onHorizontalDragEnd: (dragDetails) {
              //   if (dragDetails.primaryVelocity! < 0) {
              //     openBar();
              //   } else {
              //     closeBar();
              //   }
              // },
              child: Stack(
                children: [
                  const SideDrawer(),
                  Stack(
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
                          ),
                        ),
                        child: Clock(
                          size: size,
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
                                height: 0.470 * size.height,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 0.1 * size.width,
                                    vertical: 0.1 * size.height),
                                width: size.width,
                                child: SizedBox(
                                  width: 0.725 * size.width,
                                  child: const Greetings(username: "Aryan"),
                                ),
                              ),
                              Container(
                                height: 0.530 * size.height,
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 0.05 * size.width,
                                ),
                                child: GridView.count(
                                  physics: const NeverScrollableScrollPhysics(),
                                  //shrinkWrap: true,
                                  crossAxisCount: 2,
                                  children: [
                                    Card(
                                      clipBehavior: Clip.antiAlias,
                                      color: Colors.white.withOpacity(0.15),
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12))),
                                      child: InkWell(
                                        onTap: () {
                                          RouteManager.navigateToTodo(context);
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
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
                                              "TODOs",
                                              // style: GoogleFonts.ubuntu(
                                              //   textStyle: const TextStyle(
                                              //     color: Colors.white,
                                              //   ),
                                              // ),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Card(
                                      clipBehavior: Clip.antiAlias,
                                      color: Colors.white.withOpacity(0.15),
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12))),
                                      child: InkWell(
                                        onTap: () {
                                          RouteManager.navigateToDiary(context);
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
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
                                              "Diary Entries",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Card(
                                      clipBehavior: Clip.antiAlias,
                                      color: Colors.white.withOpacity(0.5),
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12))),
                                      child: InkWell(
                                        onTap: () {},
                                      ),
                                    ),
                                    Card(
                                      clipBehavior: Clip.antiAlias,
                                      color: Colors.white.withOpacity(0.15),
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12))),
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
                      Visibility(
                        child: Container(
                          height: size.height,
                          width: size.width,
                          color: Colors.black.withOpacity(0.3),
                        ),
                        visible: !snapshot.data!,
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  void dispose() {
    _animationController.dispose();
    isSidebarOpenedStreamController.close();
    isSidebarOpenedSink.close();
    super.dispose();
  }
}
