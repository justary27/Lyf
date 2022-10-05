import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lyf/src/global/variables.dart';
import 'package:lyf/src/routes/routing.dart';
import 'package:lyf/src/screens/home/drawer.dart';
import 'package:lyf/src/shared/clock.dart';
import 'package:lyf/src/shared/greet.dart';
import 'package:lyf/src/state/theme/theme_state.dart';
import 'package:lyf/src/utils/handlers/route_handler.dart';
import 'dart:async';
import 'package:rxdart/rxdart.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
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
    // var theme = ref.read(themeNotifier.notifier).getCurrentState();
    return StreamBuilder<bool>(
        initialData: true,
        stream: isSidebarOpenedStream,
        builder: (context, snapshot) {
          String? swipeDirection;
          return AnimatedPositioned(
            left: snapshot.data == true ? 0 : size.width * 0.6,
            // right: isSideBarOpenedAsync.data == false ? 0 : size.width - 45,
            duration: _animationDuration,
            child: GestureDetector(
              onPanUpdate: (dragDetails) {
                swipeDirection = dragDetails.delta.dx < 2 ? 'left' : 'right';
              },
              onPanEnd: (dragDetails) {
                if (swipeDirection == null) {
                  return;
                }
                if (swipeDirection == 'left') {
                  openBar();
                }
                if (swipeDirection == 'right') {
                  closeBar();
                }
              },
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
                            colors: ref
                                .read(themeNotifier.notifier)
                                .getCurrentState()
                                .gradientColors,
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
                                    vertical: 0.075 * size.height),
                                width: size.width,
                                child: Container(
                                  width: 0.725 * size.width,
                                  // color: Colors.white,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      // IconButton(
                                      //     onPressed: () {
                                      //       openBar();
                                      //     },
                                      //     color: Colors.white,
                                      //     icon: Icon(Icons.menu_rounded)),
                                      Greetings(username: currentUser.username),
                                    ],
                                  ),
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
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(12),
                                        ),
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          goRouter.push(RouteHandler.todo);
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.all(20.0),
                                              child: SvgPicture.asset(
                                                "assets/images/todo.svg",
                                                color: Theme.of(context)
                                                    .iconTheme
                                                    .color,
                                              ),
                                            ),
                                            Text(
                                              "Todo",
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
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(12),
                                        ),
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          goRouter.push(RouteHandler.diary);
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.all(20.0),
                                              child: SvgPicture.asset(
                                                "assets/images/diary.svg",
                                                color: Theme.of(context)
                                                    .iconTheme
                                                    .color,
                                              ),
                                            ),
                                            Text(
                                              "Diary",
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
                                      color: Theme.of(context)
                                          .cardColor
                                          .withOpacity(0.5),
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(12),
                                        ),
                                      ),
                                      // child: Consumer(
                                      //   builder: ((context, ref, child) {
                                      //     final todosState =
                                      //         ref.watch(todosNotifierProvider);
                                      //     return Container();
                                      //   }),
                                      child: InkWell(
                                        onTap: () {},
                                        // child: Column(
                                        //   mainAxisAlignment:
                                        //       MainAxisAlignment.center,
                                        //   crossAxisAlignment:
                                        //       CrossAxisAlignment.center,
                                        //   children: [
                                        //     Padding(
                                        //       padding: EdgeInsets.all(20.0),
                                        //       child: SvgPicture.asset(
                                        //           "assets/images/statHealth.svg"),
                                        //     ),
                                        //     Text(
                                        //       "StatHealth",
                                        //       style: Theme.of(context)
                                        //           .textTheme
                                        //           .headline5,
                                        //     ),
                                        //   ],
                                        // ),
                                      ),
                                    ),
                                    // ),
                                    Card(
                                      clipBehavior: Clip.antiAlias,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(12),
                                        ),
                                      ),
                                      child: InkWell(
                                        onTap: () async {},
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
