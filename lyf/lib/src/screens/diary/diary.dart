import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lyf/src/models/diary_model.dart';
import 'package:lyf/src/routes/routing.dart';
import 'package:lyf/src/shared/entry_card.dart';
import 'package:lyf/src/shared/snackbars/delete_snack.dart';
import 'package:lyf/src/utils/errors/diary/diary_errors.dart';
import 'package:share_plus/share_plus.dart';

import '../../state/diary/diary_list_state.dart';

class DiaryPage extends ConsumerStatefulWidget {
  const DiaryPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DiaryPageState();
}

class _DiaryPageState extends ConsumerState<DiaryPage> {
  List<DiaryEntry>? diaryEntries = [];
  bool retrieveStatus = true;

  void retrieveStatusNotifier(bool flag) {
    setState(() {
      retrieveStatus = flag;
    });
  }

  void _deleteEntry(DiaryEntry entry) {
    ref.read(diaryNotifier.notifier).removeEntry(entry);
  }

  void _refresh({bool? forceRefresh}) {
    try {
      ref.read(diaryNotifier).value;
      if (forceRefresh != null && forceRefresh) {
        ref.read(diaryNotifier.notifier).refresh();
      }
    } on DiaryException catch (e) {
      ref.read(diaryNotifier.notifier).refresh();
    }
  }

  void _retrieveEntryPdf(DiaryEntry entry) {
    ref.read(diaryNotifier.notifier).retrieveEntryPdf(entry);
  }

  @override
  void initState() {
    _refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        RouteManager.navigateToHome(context);
        await Future.delayed(const Duration(microseconds: 100));
        return true;
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
            child: const CustomPaint(),
          ),
          SizedBox(
            height: size.height,
            width: size.width,
            child: Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  RouteManager.navigateToAddDiaryEntry(context);
                },
                backgroundColor: Colors.white.withOpacity(0.35),
                child: const Icon(Icons.add),
              ),
              backgroundColor: Colors.transparent,
              body: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    backgroundColor: Colors.transparent,
                    leading: IconButton(
                      onPressed: () {
                        RouteManager.navigateToHome(context);
                      },
                      icon: const Icon(Icons.arrow_back_ios),
                    ),
                    expandedHeight: 0.3 * size.height,
                    flexibleSpace: FlexibleSpaceBar(
                      background: ColorFiltered(
                        colorFilter: ColorFilter.mode(
                          Colors.black.withBlue(10),
                          BlendMode.saturation,
                        ),
                        child: Image.asset(
                          "assets/images/diary.jpg",
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        "Your Diary Entries",
                        style: GoogleFonts.ubuntu(
                          textStyle: Theme.of(context).textTheme.headline3,
                        ),
                      ),
                    ),
                    actions: [
                      // PopupMenuButton(
                      //   shape: const RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.all(
                      //       Radius.circular(15.0),
                      //     ),
                      //   ),
                      //   color: Colors.white,
                      //   itemBuilder: (context) {
                      //     return [
                      //       PopupMenuItem(
                      //         padding: EdgeInsets.zero,
                      //         child: ListTile(
                      //           minLeadingWidth: 25,
                      //           dense: true,
                      //           leading: Icon(
                      //             Icons.picture_as_pdf_rounded,
                      //             color: Colors.grey.shade700,
                      //           ),
                      //           title: Text(
                      //             "Save diary Pdf",
                      //             style: GoogleFonts.aBeeZee(
                      //               textStyle: TextStyle(
                      //                 color: Colors.grey.shade700,
                      //               ),
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //     ];
                      //   },
                      //   icon: const Icon(Icons.more_vert),
                      // )
                    ],
                  ),
                  Consumer(
                    builder: ((context, ref, child) {
                      final diaryState = ref.watch(diaryNotifier);
                      return diaryState.when(
                        data: ((diary) {
                          if (diary!.isEmpty) {
                            return const SliverFillRemaining(
                              child: Center(
                                child: Text(
                                  "Looks like you don't have any todos :) \n Yay!",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                          } else {
                            return SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (context, index) => Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 0.05 * size.width,
                                      vertical: 0.015 * size.height),
                                  child: Card(
                                    clipBehavior: Clip.antiAlias,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    color: Colors.white.withOpacity(0.15),
                                    child: InkWell(
                                      onTap: () {
                                        RouteManager.navigateToViewDiaryEntry(
                                            context, [
                                          diary[index],
                                          size,
                                        ]);
                                      },
                                      child: SizedBox(
                                        height: 0.4 * size.height,
                                        width: 0.2 * size.width,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 0.05 * size.width,
                                              vertical: 0.01 * size.height),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      diary[index].title,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline3,
                                                    ),
                                                    IconButton(
                                                      onPressed: () {
                                                        Share.share(
                                                            "${diary[index].entryTitle}\n\n${diary[index].entryDescription}\n\nDated:${diary[index].entryCreatedAt.day}/${diary[index].entryCreatedAt.month}/${diary[index].entryCreatedAt.year}");
                                                      },
                                                      icon: const Icon(
                                                        Icons.share_rounded,
                                                        color: Colors.white,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                height: 0.075 * size.height,
                                                alignment: Alignment.bottomLeft,
                                              ),
                                              Container(
                                                padding: EdgeInsets.fromLTRB(
                                                  0,
                                                  0.025 * size.height,
                                                  0.0085 * size.width,
                                                  0.025 * size.height,
                                                ),
                                                height: 0.225 * size.height,
                                                child: Text(
                                                  diary[index].description,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1,
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "${diary[index].entryCreatedAt.day}/${diary[index].entryCreatedAt.month}/${diary[index].entryCreatedAt.year}",
                                                    style: GoogleFonts.ubuntu(
                                                      textStyle:
                                                          const TextStyle(
                                                              color:
                                                                  Colors.white),
                                                    ),
                                                  ),
                                                  ButtonBar(
                                                    alignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      TextButton(
                                                        onPressed: () {
                                                          SnackBar snackBar =
                                                              deleteSnack(
                                                            parentContext:
                                                                context,
                                                            size: size,
                                                            item: diary[index],
                                                            performDeleteTask:
                                                                _deleteEntry,
                                                          );
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                                  snackBar);
                                                        },
                                                        child: Text(
                                                          "Delete",
                                                          style: GoogleFonts
                                                              .ubuntu(
                                                            textStyle:
                                                                TextStyle(
                                                              color: Colors.red,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      TextButton(
                                                        onPressed: () async {
                                                          _retrieveEntryPdf(
                                                              diary[index]);
                                                        },
                                                        child: Text(
                                                          "Save as Pdf",
                                                          style: GoogleFonts
                                                              .ubuntu(),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                childCount: diary.length,
                              ),
                            );
                          }
                        }),
                        error: (Object error, StackTrace? stackTrace) {
                          return const SliverFillRemaining(
                            child: Center(
                              child: Text("Unable to retrieve your Diary."),
                            ),
                          );
                        },
                        loading: () {
                          return const SliverFillRemaining(
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                          );
                        },
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
