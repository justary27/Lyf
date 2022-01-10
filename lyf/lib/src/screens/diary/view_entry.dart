import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lyf/src/global/globals.dart';
import 'package:lyf/src/models/diary_model.dart';
import 'package:lyf/src/routes/routing.dart';
import 'package:http/http.dart' as http;
import 'package:lyf/src/services/http.dart';

class ViewDiaryEntryPage extends StatefulWidget {
  final DiaryEntry entry;
  const ViewDiaryEntryPage({Key? key, required this.entry}) : super(key: key);

  @override
  _ViewDiaryEntryPageState createState() => _ViewDiaryEntryPageState();
}

class _ViewDiaryEntryPageState extends State<ViewDiaryEntryPage> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late http.Client updateEntryClient;
  late http.Client deleteEntryClient;
  late DateTime dateController;
  late ValueNotifier<bool> isChanged;

  @override
  void initState() {
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    isChanged = ValueNotifier(false);
    updateEntryClient = http.Client();
    _titleController.text = widget.entry.entryTitle;
    _descriptionController.text = widget.entry.description;
    deleteEntryClient = http.Client();
    dateController = widget.entry.entryCreatedAt;
    super.initState();
  }

  void updateEntry(http.Client updateEntryClient, String title,
      String description, DateTime datetime) async {
    http.Response response;
    try {
      response = await updateEntryClient.put(
        Uri.parse(
          ApiEndpoints.updateEntry(currentUser.userID, widget.entry.entryId),
        ),
        body: {
          '_userId': currentUser.userID,
          '_title': title,
          '_description': description,
          '_created_on': datetime.toIso8601String(),
        },
        headers: currentUser.authHeader(),
      );
      if (response.statusCode == 200) {
        SnackBar snackBar = const SnackBar(
          content: Text("Entry updated successfully!"),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        RouteManager.navigateToDiary(context);
      } else {
        print(response.body);
        SnackBar snackBar = const SnackBar(
          content: Text("Something went wrong"),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } catch (e) {
      print(e);
    }
  }

  void deleteEntry(http.Client deleteEntryClient, String entryId) async {
    http.Response response;
    try {
      response = await http.delete(
        Uri.parse(ApiEndpoints.deleteEntry(currentUser.userID, entryId)),
        headers: currentUser.authHeader(),
      );
      if (response.statusCode == 200) {
        RouteManager.navigateToDiary(context);
      } else {
        print(response.body);
        SnackBar snackBar = const SnackBar(
          content: Text("Something went wrong"),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        if (isChanged.value == true) {
          SnackBar snackBar = SnackBar(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            duration: const Duration(seconds: 5),
            backgroundColor: Colors.grey.shade700,
            content: Container(
              alignment: Alignment.center,
              height: 0.170 * size.height,
              padding: EdgeInsets.fromLTRB(
                0,
                0.0125 * size.height,
                0,
                0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      0,
                      0,
                      0,
                      0.0175 * size.height,
                    ),
                    child: Text(
                      "Do you want to go back without updating entry?",
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
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6.0),
                                  side: const BorderSide(
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                            onPressed: () {
                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar();
                              Navigator.of(context).pop();
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
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
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
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                            },
                            child: Text(
                              "No",
                              style: GoogleFonts.aBeeZee(
                                textStyle: TextStyle(
                                    color: Colors.white, fontSize: 20),
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

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          await Future.delayed(
            const Duration(seconds: 1),
          );
          return false;
        } else {
          return true;
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
            child: const CustomPaint(),
          ),
          SizedBox(
            height: size.height,
            width: size.width,
            child: Scaffold(
              drawer: Container(
                width: 0.2 * size.width,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomLeft,
                  colors: [
                    Colors.grey.shade500,
                    Colors.grey.shade800,
                  ],
                )),
                child: Drawer(
                  backgroundColor: Colors.transparent,
                  child: Container(
                    height: size.height,
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.location_on_outlined,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Location",
                            )
                          ],
                        ),
                        Column(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.image,
                                color: Colors.white,
                              ),
                            ),
                            Text("Images"),
                          ],
                        ),
                        Column(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.audiotrack_outlined,
                                color: Colors.white,
                              ),
                            ),
                            Text("Audio"),
                          ],
                        ),
                        Column(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.color_lens_rounded,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Doodle",
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              drawerEnableOpenDragGesture: false,
              floatingActionButton: Builder(builder: (context) {
                return FloatingActionButton(
                  tooltip: "Add attachment",
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                    // showBottomSheet(
                    //     context: context,
                    //     builder: (context) => Container(
                    //           width: size.width * 0.8,
                    //           height: 0.1 * size.height,
                    //         ));
                  },
                  backgroundColor: Colors.white.withOpacity(0.35),
                  child: const Icon(Icons.attachment),
                );
              }),
              backgroundColor: Colors.transparent,
              body: CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    SliverAppBar(
                      pinned: true,
                      backgroundColor: Colors.transparent,
                      leading: IconButton(
                        onPressed: () {
                          RouteManager.navigateToDiary(context);
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
                        title: SizedBox(
                          width: 0.5 * size.width,
                          child: TextFormField(
                            controller: _titleController,
                            style: GoogleFonts.ubuntu(
                              textStyle: const TextStyle(color: Colors.white),
                            ),
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              filled: true,
                              border: InputBorder.none,
                              fillColor: Colors.white.withOpacity(0.35),
                            ),
                            onChanged: (value) {
                              if (_titleController.text != widget.entry.title) {
                                isChanged.value = true;
                              } else {
                                isChanged.value = false;
                              }
                            },
                          ),
                        ),
                      ),
                      actions: [
                        ValueListenableBuilder(
                            valueListenable: isChanged,
                            builder: (context, value, child) {
                              return Visibility(
                                visible: isChanged.value,
                                child: IconButton(
                                  onPressed: () {
                                    print(_titleController.text);
                                    if (isChanged.value == true) {
                                      updateEntry(
                                        updateEntryClient,
                                        _titleController.text,
                                        _descriptionController.text,
                                        dateController,
                                      );
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.check_box_rounded,
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            }),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.more_vert,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SliverFillRemaining(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 0.05 * size.width,
                                  vertical: 0.015 * size.height),
                              child: Card(
                                clipBehavior: Clip.antiAlias,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                color: Colors.white.withOpacity(0.15),
                                child: SizedBox(
                                  width: 0.9 * size.width,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 0.05 * size.width,
                                        vertical: 0.01 * size.height),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.fromLTRB(
                                            0,
                                            0.025 * size.height,
                                            0.0085 * size.width,
                                            0.025 * size.height,
                                          ),
                                          // child: Text(
                                          //   widget.entry.entryDescription,
                                          //   style: GoogleFonts.aBeeZee(
                                          //     textStyle: TextStyle(
                                          //       color:
                                          //           Colors.white.withOpacity(0.5),
                                          //     ),
                                          //   ),
                                          // ),
                                          child: TextFormField(
                                            controller: _descriptionController,
                                            style: GoogleFonts.aBeeZee(
                                              textStyle: TextStyle(
                                                color: Colors.white
                                                    .withOpacity(0.5),
                                              ),
                                            ),
                                            cursorColor:
                                                Colors.white.withOpacity(0.5),
                                            decoration: InputDecoration(
                                              filled: false,
                                              border: InputBorder.none,
                                            ),
                                            maxLines: null,
                                            onChanged: (value) {
                                              if (_descriptionController.text !=
                                                  widget.entry.description) {
                                                isChanged.value = true;
                                              } else {
                                                isChanged.value = false;
                                              }
                                            },
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            TextButton(
                                              onPressed: () {
                                                showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime(2000),
                                                  lastDate: DateTime.now().add(
                                                    const Duration(days: 7),
                                                  ),
                                                  builder:
                                                      (BuildContext context,
                                                          Widget? child) {
                                                    return Theme(
                                                      data: Theme.of(context),
                                                      child: child!,
                                                    );
                                                  },
                                                ).then((value) {
                                                  setState(() {
                                                    if (value != null) {
                                                      dateController = value;
                                                      isChanged.value = true;
                                                    } else {
                                                      dateController = widget
                                                          .entry.entryCreatedAt;
                                                    }
                                                  });
                                                });
                                                //                                   showDatePicker(
                                                //   context: context,
                                                //   initialDate: DateTime.now(),
                                                //   firstDate: DateTime(1970),
                                                //   builder: (BuildContext context, Widget child) {
                                                //     return Theme(
                                                //       data: ThemeData.dark().copyWith(
                                                //         colorScheme: ColorScheme.dark(
                                                //             primary: Colors.deepPurple,
                                                //             onPrimary: Colors.white,
                                                //             surface: Colors.pink,
                                                //             onSurface: Colors.yellow,
                                                //             ),
                                                //         dialogBackgroundColor:Colors.blue[900],
                                                //       ),
                                                //       child: child,
                                                //     );
                                                //   },
                                                // );
                                              },
                                              child: Text(
                                                "${dateController.day}/${dateController.month}/${dateController.year}",
                                                style: GoogleFonts.ubuntu(
                                                  textStyle: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                            ButtonBar(
                                              alignment: MainAxisAlignment.end,
                                              children: [
                                                TextButton(
                                                  onPressed: () {
                                                    SnackBar snackBar =
                                                        SnackBar(
                                                      shape:
                                                          const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  10),
                                                          topRight:
                                                              Radius.circular(
                                                                  10),
                                                        ),
                                                      ),
                                                      duration: const Duration(
                                                        seconds: 5,
                                                      ),
                                                      backgroundColor:
                                                          Colors.grey.shade700,
                                                      content: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        height:
                                                            0.170 * size.height,
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                          0,
                                                          0.0125 * size.height,
                                                          0,
                                                          0,
                                                        ),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .fromLTRB(
                                                                0,
                                                                0,
                                                                0,
                                                                0.0175 *
                                                                    size.height,
                                                              ),
                                                              child: Text(
                                                                "Are you sure you want to delete the entry ${widget.entry.entryTitle}?",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    GoogleFonts
                                                                        .ubuntu(
                                                                  textStyle:
                                                                      const TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        20,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: ButtonBar(
                                                                alignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  SizedBox(
                                                                    width: size
                                                                            .width *
                                                                        0.40,
                                                                    child:
                                                                        TextButton(
                                                                      style:
                                                                          ButtonStyle(
                                                                        shape: MaterialStateProperty.all<
                                                                            RoundedRectangleBorder>(
                                                                          RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(6.0),
                                                                            side:
                                                                                const BorderSide(
                                                                              color: Colors.red,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      onPressed:
                                                                          () {
                                                                        ScaffoldMessenger.of(
                                                                            context)
                                                                          ..hideCurrentSnackBar();
                                                                        deleteEntry(
                                                                            deleteEntryClient,
                                                                            widget.entry.entryId);
                                                                      },
                                                                      child:
                                                                          Text(
                                                                        "Yes",
                                                                        style: GoogleFonts
                                                                            .aBeeZee(
                                                                          textStyle:
                                                                              const TextStyle(
                                                                            color:
                                                                                Colors.red,
                                                                            fontSize:
                                                                                20,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: size
                                                                            .width *
                                                                        0.40,
                                                                    child:
                                                                        TextButton(
                                                                      style:
                                                                          ButtonStyle(
                                                                        shape: MaterialStateProperty.all<
                                                                            RoundedRectangleBorder>(
                                                                          RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(
                                                                              6.0,
                                                                            ),
                                                                            side:
                                                                                BorderSide(
                                                                              color: Colors.white,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      onPressed:
                                                                          () {
                                                                        ScaffoldMessenger.of(context)
                                                                            .hideCurrentSnackBar();
                                                                      },
                                                                      child:
                                                                          Text(
                                                                        "No",
                                                                        style: GoogleFonts
                                                                            .aBeeZee(
                                                                          textStyle: TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 20),
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
                                                        .showSnackBar(snackBar);
                                                  },
                                                  child: Text(
                                                    "Delete",
                                                    style: GoogleFonts.ubuntu(
                                                      textStyle: TextStyle(
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () {},
                                                  child: Text(
                                                    "Save as PDF",
                                                    style: GoogleFonts.ubuntu(),
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
                          ],
                        ),
                      ),
                    )
                  ]),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    updateEntryClient.close();
    deleteEntryClient.close();
    super.dispose();
  }
}
