import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lyf/src/global/globals.dart';
import 'package:lyf/src/models/diary_model.dart';
import 'package:lyf/src/routes/routing.dart';
import 'package:http/http.dart' as http;
import 'package:lyf/src/services/http.dart';
import 'package:share_plus/share_plus.dart';

class DiaryPage extends StatefulWidget {
  const DiaryPage({Key? key}) : super(key: key);

  @override
  _DiaryPageState createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {
  late http.Client diaryClient;
  late http.Client deleteEntryClient;
  late Future<List<DiaryEntry?>?> _getEntries;

  List<DiaryEntry> diaryEntries = [];
  bool retrieveStatus = true;

  getEntries(http.Client client) async {
    List<DiaryEntry> diary = [];
    var entries = await client.get(
      Uri.parse(ApiEndpoints.getAllEntries(currentUser.userId)),
      headers: currentUser.authHeader(),
    );
    try {
      json.decode(entries.body).forEach((element) {
        DiaryEntry entry = DiaryEntry.fromJson(element);
        diary.add(entry);
      });
      setState(() {
        diaryEntries = diary;
        retrieveStatus = true;
      });
    } catch (e) {
      print(e);
      setState(() {
        retrieveStatus = false;
      });
    }
  }

  void deleteEntry(http.Client deleteEntryClient, http.Client diaryClient,
      DiaryEntry entry) async {
    late int statusCode;
    try {
      statusCode = await DiaryEntry.deleteEntry(
          deleteEntryClient: deleteEntryClient, entry: entry);
      if (statusCode == 200) {
        getEntries(diaryClient);
      } else {
        SnackBar snackBar = const SnackBar(
          content: Text("Something went wrong"),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } catch (e) {
      print(e);
    }
  }

  void retrieveStatusNotifier(bool flag) {
    setState(() {
      retrieveStatus = flag;
    });
  }

  @override
  void initState() {
    diaryClient = http.Client();
    deleteEntryClient = http.Client();
    _getEntries = DiaryEntry.getEntries(
        getEntryClient: diaryClient,
        retrieveStatusNotifier: retrieveStatusNotifier);
    getEntries(diaryClient);
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
                        PopupMenuButton(
                          color: Colors.white,
                          itemBuilder: (context) {
                            return [
                              const PopupMenuItem(
                                child: Text("Save all as PDF"),
                              ),
                            ];
                          },
                          icon: const Icon(Icons.more_vert),
                        )
                      ],
                    ),
                    // (retrieveStatus)
                    //     ? SliverList(
                    //         delegate: SliverChildBuilderDelegate(
                    //           (context, index) => Padding(
                    //             padding: EdgeInsets.symmetric(
                    //                 horizontal: 0.05 * size.width,
                    //                 vertical: 0.015 * size.height),
                    //             child: Card(
                    //               clipBehavior: Clip.antiAlias,
                    //               shape: RoundedRectangleBorder(
                    //                   borderRadius: BorderRadius.circular(12)),
                    //               color: Colors.white.withOpacity(0.15),
                    //               child: InkWell(
                    //                 onTap: () {
                    //                   RouteManager.navigateToViewDiaryEntry(
                    //                       context, [
                    //                     diaryEntries[index],
                    //                     size,
                    //                   ]);
                    //                 },
                    //                 child: SizedBox(
                    //                   height: 0.4 * size.height,
                    //                   width: 0.2 * size.width,
                    //                   child: Padding(
                    //                     padding: EdgeInsets.symmetric(
                    //                         horizontal: 0.05 * size.width,
                    //                         vertical: 0.01 * size.height),
                    //                     child: Column(
                    //                       crossAxisAlignment:
                    //                           CrossAxisAlignment.start,
                    //                       children: [
                    //                         Container(
                    //                           child: Row(
                    //                             mainAxisAlignment:
                    //                                 MainAxisAlignment
                    //                                     .spaceBetween,
                    //                             children: [
                    //                               Text(
                    //                                 diaryEntries[index].title,
                    //                                 style: Theme.of(context)
                    //                                     .textTheme
                    //                                     .headline3,
                    //                               ),
                    //                               IconButton(
                    //                                 onPressed: () {
                    //                                   Share.share(
                    //                                       "${diaryEntries[index].entryTitle}\n\n${diaryEntries[index].entryDescription}\n\nDated:${diaryEntries[index].entryCreatedAt.day}/${diaryEntries[index].entryCreatedAt.month}/${diaryEntries[index].entryCreatedAt.year}");
                    //                                 },
                    //                                 icon: const Icon(
                    //                                   Icons.share_rounded,
                    //                                   color: Colors.white,
                    //                                 ),
                    //                               )
                    //                             ],
                    //                           ),
                    //                           height: 0.075 * size.height,
                    //                           alignment: Alignment.bottomLeft,
                    //                         ),
                    //                         Container(
                    //                           padding: EdgeInsets.fromLTRB(
                    //                             0,
                    //                             0.025 * size.height,
                    //                             0.0085 * size.width,
                    //                             0.025 * size.height,
                    //                           ),
                    //                           height: 0.225 * size.height,
                    //                           child: Text(
                    //                             diaryEntries[index].description,
                    //                             // "cjnd mdsfs,fslnlwsd vsd,v snfs, vsf wrf wrfwr fwwr gwgwgwr gwrgw rrgrwhwr hwhrwhwh....",
                    //                             style: Theme.of(context)
                    //                                 .textTheme
                    //                                 .bodyText1,
                    //                           ),
                    //                         ),
                    //                         Row(
                    //                           mainAxisAlignment:
                    //                               MainAxisAlignment
                    //                                   .spaceBetween,
                    //                           children: [
                    //                             Text(
                    //                               "${diaryEntries[index].entryCreatedAt.day}/${diaryEntries[index].entryCreatedAt.month}/${diaryEntries[index].entryCreatedAt.year}",
                    //                               style: GoogleFonts.ubuntu(
                    //                                 textStyle: const TextStyle(
                    //                                     color: Colors.white),
                    //                               ),
                    //                             ),
                    //                             ButtonBar(
                    //                               alignment:
                    //                                   MainAxisAlignment.end,
                    //                               children: [
                    //                                 TextButton(
                    //                                   onPressed: () {
                    //                                     SnackBar snackBar =
                    //                                         SnackBar(
                    //                                       shape:
                    //                                           const RoundedRectangleBorder(
                    //                                         borderRadius:
                    //                                             BorderRadius
                    //                                                 .only(
                    //                                           topLeft: Radius
                    //                                               .circular(10),
                    //                                           topRight: Radius
                    //                                               .circular(10),
                    //                                         ),
                    //                                       ),
                    //                                       duration:
                    //                                           const Duration(
                    //                                         seconds: 5,
                    //                                       ),
                    //                                       backgroundColor:
                    //                                           Colors.grey
                    //                                               .shade700,
                    //                                       content: Container(
                    //                                         alignment: Alignment
                    //                                             .center,
                    //                                         height: 0.170 *
                    //                                             size.height,
                    //                                         padding: EdgeInsets
                    //                                             .fromLTRB(
                    //                                           0,
                    //                                           0.0125 *
                    //                                               size.height,
                    //                                           0,
                    //                                           0,
                    //                                         ),
                    //                                         child: Column(
                    //                                           crossAxisAlignment:
                    //                                               CrossAxisAlignment
                    //                                                   .center,
                    //                                           mainAxisAlignment:
                    //                                               MainAxisAlignment
                    //                                                   .end,
                    //                                           children: [
                    //                                             Padding(
                    //                                               padding:
                    //                                                   EdgeInsets
                    //                                                       .fromLTRB(
                    //                                                 0,
                    //                                                 0,
                    //                                                 0,
                    //                                                 0.0175 *
                    //                                                     size.height,
                    //                                               ),
                    //                                               child: Text(
                    //                                                 "Are you sure you want to delete the entry ${diaryEntries[index].entryTitle}?",
                    //                                                 textAlign:
                    //                                                     TextAlign
                    //                                                         .center,
                    //                                                 style: GoogleFonts
                    //                                                     .ubuntu(
                    //                                                   textStyle:
                    //                                                       const TextStyle(
                    //                                                     color: Colors
                    //                                                         .white,
                    //                                                     fontSize:
                    //                                                         20,
                    //                                                   ),
                    //                                                 ),
                    //                                               ),
                    //                                             ),
                    //                                             Expanded(
                    //                                               child:
                    //                                                   ButtonBar(
                    //                                                 alignment:
                    //                                                     MainAxisAlignment
                    //                                                         .center,
                    //                                                 children: [
                    //                                                   SizedBox(
                    //                                                     width: size.width *
                    //                                                         0.40,
                    //                                                     child:
                    //                                                         TextButton(
                    //                                                       style:
                    //                                                           ButtonStyle(
                    //                                                         shape:
                    //                                                             MaterialStateProperty.all<RoundedRectangleBorder>(
                    //                                                           RoundedRectangleBorder(
                    //                                                             borderRadius: BorderRadius.circular(6.0),
                    //                                                             side: const BorderSide(
                    //                                                               color: Colors.red,
                    //                                                             ),
                    //                                                           ),
                    //                                                         ),
                    //                                                       ),
                    //                                                       onPressed:
                    //                                                           () {
                    //                                                         ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    //                                                         deleteEntry(
                    //                                                           deleteEntryClient,
                    //                                                           diaryClient,
                    //                                                           diaryEntries[index],
                    //                                                         );
                    //                                                       },
                    //                                                       child:
                    //                                                           Text(
                    //                                                         "Yes",
                    //                                                         style:
                    //                                                             GoogleFonts.aBeeZee(
                    //                                                           textStyle: const TextStyle(
                    //                                                             color: Colors.red,
                    //                                                             fontSize: 20,
                    //                                                           ),
                    //                                                         ),
                    //                                                       ),
                    //                                                     ),
                    //                                                   ),
                    //                                                   SizedBox(
                    //                                                     width: size.width *
                    //                                                         0.40,
                    //                                                     child:
                    //                                                         TextButton(
                    //                                                       style:
                    //                                                           ButtonStyle(
                    //                                                         shape:
                    //                                                             MaterialStateProperty.all<RoundedRectangleBorder>(
                    //                                                           RoundedRectangleBorder(
                    //                                                             borderRadius: BorderRadius.circular(
                    //                                                               6.0,
                    //                                                             ),
                    //                                                             side: BorderSide(
                    //                                                               color: Colors.white,
                    //                                                             ),
                    //                                                           ),
                    //                                                         ),
                    //                                                       ),
                    //                                                       onPressed:
                    //                                                           () {
                    //                                                         ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    //                                                       },
                    //                                                       child:
                    //                                                           Text(
                    //                                                         "No",
                    //                                                         style:
                    //                                                             GoogleFonts.aBeeZee(
                    //                                                           textStyle: TextStyle(color: Colors.white, fontSize: 20),
                    //                                                         ),
                    //                                                       ),
                    //                                                     ),
                    //                                                   )
                    //                                                 ],
                    //                                               ),
                    //                                             )
                    //                                           ],
                    //                                         ),
                    //                                       ),
                    //                                     );
                    //                                     ScaffoldMessenger.of(
                    //                                             context)
                    //                                         .showSnackBar(
                    //                                             snackBar);
                    //                                   },
                    //                                   child: Text(
                    //                                     "Delete",
                    //                                     style:
                    //                                         GoogleFonts.ubuntu(
                    //                                       textStyle: TextStyle(
                    //                                         color: Colors.red,
                    //                                       ),
                    //                                     ),
                    //                                   ),
                    //                                 ),
                    //                                 TextButton(
                    //                                   onPressed: () {},
                    //                                   child: Text(
                    //                                     "Save as PDF",
                    //                                     style: GoogleFonts
                    //                                         .ubuntu(),
                    //                                   ),
                    //                                 )
                    //                               ],
                    //                             ),
                    //                           ],
                    //                         )
                    //                       ],
                    //                     ),
                    //                   ),
                    //                 ),
                    //               ),
                    //             ),
                    //           ),
                    //           childCount: diaryEntries.length,
                    //         ),
                    //       )
                    //     : SliverFillRemaining(
                    //         child: Center(
                    //           child: Column(
                    //             mainAxisAlignment: MainAxisAlignment.center,
                    //             crossAxisAlignment: CrossAxisAlignment.center,
                    //             children: [
                    //               Icon(
                    //                 Icons.warning_amber_rounded,
                    //                 color: Colors.white,
                    //                 size: 40,
                    //               ),
                    //               Text("Unable to retrieve your diary."),
                    //             ],
                    //           ),
                    //         ),
                    //       ),
                    FutureBuilder<List<DiaryEntry?>?>(
                        future: _getEntries,
                        builder: (context, snapshot) {
                          print(snapshot.data);
                          if (snapshot.hasData) {
                            return (retrieveStatus)
                                ? (snapshot.data!.isNotEmpty)
                                    ? SliverList(
                                        delegate: SliverChildBuilderDelegate(
                                          (context, index) => Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 0.05 * size.width,
                                                vertical: 0.015 * size.height),
                                            child: Card(
                                              clipBehavior: Clip.antiAlias,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                              color: Colors.white
                                                  .withOpacity(0.15),
                                              child: InkWell(
                                                onTap: () {
                                                  RouteManager
                                                      .navigateToViewDiaryEntry(
                                                          context, [
                                                    diaryEntries[index],
                                                    size,
                                                  ]);
                                                },
                                                child: SizedBox(
                                                  height: 0.4 * size.height,
                                                  width: 0.2 * size.width,
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 0.05 *
                                                                size.width,
                                                            vertical: 0.01 *
                                                                size.height),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                diaryEntries[
                                                                        index]
                                                                    .title,
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .headline3,
                                                              ),
                                                              IconButton(
                                                                onPressed: () {
                                                                  Share.share(
                                                                      "${diaryEntries[index].entryTitle}\n\n${diaryEntries[index].entryDescription}\n\nDated:${diaryEntries[index].entryCreatedAt.day}/${diaryEntries[index].entryCreatedAt.month}/${diaryEntries[index].entryCreatedAt.year}");
                                                                },
                                                                icon:
                                                                    const Icon(
                                                                  Icons
                                                                      .share_rounded,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          height: 0.075 *
                                                              size.height,
                                                          alignment: Alignment
                                                              .bottomLeft,
                                                        ),
                                                        Container(
                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                            0,
                                                            0.025 * size.height,
                                                            0.0085 * size.width,
                                                            0.025 * size.height,
                                                          ),
                                                          height: 0.225 *
                                                              size.height,
                                                          child: Text(
                                                            diaryEntries[index]
                                                                .description,
                                                            style: Theme.of(
                                                                    context)
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
                                                              "${diaryEntries[index].entryCreatedAt.day}/${diaryEntries[index].entryCreatedAt.month}/${diaryEntries[index].entryCreatedAt.year}",
                                                              style: GoogleFonts
                                                                  .ubuntu(
                                                                textStyle: const TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            ),
                                                            ButtonBar(
                                                              alignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children: [
                                                                TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    SnackBar
                                                                        snackBar =
                                                                        SnackBar(
                                                                      shape:
                                                                          const RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.only(
                                                                          topLeft:
                                                                              Radius.circular(10),
                                                                          topRight:
                                                                              Radius.circular(10),
                                                                        ),
                                                                      ),
                                                                      duration:
                                                                          const Duration(
                                                                        seconds:
                                                                            5,
                                                                      ),
                                                                      backgroundColor: Colors
                                                                          .grey
                                                                          .shade700,
                                                                      content:
                                                                          Container(
                                                                        alignment:
                                                                            Alignment.center,
                                                                        height: 0.170 *
                                                                            size.height,
                                                                        padding:
                                                                            EdgeInsets.fromLTRB(
                                                                          0,
                                                                          0.0125 *
                                                                              size.height,
                                                                          0,
                                                                          0,
                                                                        ),
                                                                        child:
                                                                            Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.end,
                                                                          children: [
                                                                            Padding(
                                                                              padding: EdgeInsets.fromLTRB(
                                                                                0,
                                                                                0,
                                                                                0,
                                                                                0.0175 * size.height,
                                                                              ),
                                                                              child: Text(
                                                                                "Are you sure you want to delete the entry ${diaryEntries[index].entryTitle}?",
                                                                                textAlign: TextAlign.center,
                                                                                style: GoogleFonts.ubuntu(
                                                                                  textStyle: const TextStyle(
                                                                                    color: Colors.white,
                                                                                    fontSize: 20,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              child: ButtonBar(
                                                                                alignment: MainAxisAlignment.center,
                                                                                children: [
                                                                                  SizedBox(
                                                                                    width: size.width * 0.40,
                                                                                    child: TextButton(
                                                                                      style: ButtonStyle(
                                                                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                                                          RoundedRectangleBorder(
                                                                                            borderRadius: BorderRadius.circular(6.0),
                                                                                            side: const BorderSide(
                                                                                              color: Colors.red,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      onPressed: () {
                                                                                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                                                                        deleteEntry(
                                                                                          deleteEntryClient,
                                                                                          diaryClient,
                                                                                          diaryEntries[index],
                                                                                        );
                                                                                      },
                                                                                      child: Text(
                                                                                        "Yes",
                                                                                        style: GoogleFonts.aBeeZee(
                                                                                          textStyle: const TextStyle(
                                                                                            color: Colors.red,
                                                                                            fontSize: 20,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    width: size.width * 0.40,
                                                                                    child: TextButton(
                                                                                      style: ButtonStyle(
                                                                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                                                          RoundedRectangleBorder(
                                                                                            borderRadius: BorderRadius.circular(
                                                                                              6.0,
                                                                                            ),
                                                                                            side: BorderSide(
                                                                                              color: Colors.white,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      onPressed: () {
                                                                                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                                                                      },
                                                                                      child: Text(
                                                                                        "No",
                                                                                        style: GoogleFonts.aBeeZee(
                                                                                          textStyle: TextStyle(color: Colors.white, fontSize: 20),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ),
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
                                                                        color: Colors
                                                                            .red,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                TextButton(
                                                                  onPressed:
                                                                      () {},
                                                                  child: Text(
                                                                    "Save as PDF",
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
                                          childCount: diaryEntries.length,
                                        ),
                                      )
                                    : SliverFillRemaining(
                                        child: Center(
                                          child: Text(
                                            "Looks like you don't have any entries :( \n Make one!",
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      )
                                : SliverFillRemaining(
                                    child: Center(
                                      child: Text(
                                          "Unable to retrieve your diary."),
                                    ),
                                  );
                          } else {
                            return const SliverFillRemaining(
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                            );
                          }
                        })
                  ]),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    diaryClient.close();
    deleteEntryClient.close();
    super.dispose();
  }
}
