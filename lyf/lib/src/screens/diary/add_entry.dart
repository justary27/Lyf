import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lyf/src/models/diary_model.dart';
import 'package:lyf/src/routes/routing.dart';
import 'package:lyf/src/state/diary/diary_list_state.dart';

class AddDiaryEntryPage extends ConsumerStatefulWidget {
  const AddDiaryEntryPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddDiaryEntryPageState();
}

class _AddDiaryEntryPageState extends ConsumerState<AddDiaryEntryPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  @override
  void initState() {
    _titleController.text = "Untitled";
    _descriptionController.text = "Description";
    super.initState();
  }

  void _createEntry(DiaryEntry entry) {
    ref.read(diaryNotifier.notifier).addEntry(entry);
    SnackBar snackBar = const SnackBar(
      content: Text("Entry created successfully!"),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.grey.shade700, Colors.grey.shade900, Colors.black],
          )),
          child: const CustomPaint(),
        ),
        SizedBox(
          height: size.height,
          width: size.width,
          child: Scaffold(
            drawerEnableOpenDragGesture: false,
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
            // floatingActionButton: Builder(builder: (context) {
            //   return FloatingActionButton(
            //     tooltip: "Add attachment",
            //     onPressed: () {
            //       Scaffold.of(context).openDrawer();
            //       // showBottomSheet(
            //       //     context: context,
            //       //     builder: (context) => Container(
            //       //           width: size.width * 0.8,
            //       //           height: 0.1 * size.height,
            //       //         ));
            //     },
            //     backgroundColor: Colors.white.withOpacity(0.35),
            //     child: const Icon(Icons.attachment),
            //   );
            // }),
            backgroundColor: Colors.transparent,
            body: CustomScrollView(slivers: [
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
                    child: TextField(
                      controller: _titleController,
                      style: GoogleFonts.ubuntu(
                        textStyle: const TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        if (_titleController.text == "Untitled") {
                          _titleController.selection = TextSelection(
                            baseOffset: 0,
                            extentOffset: _titleController.value.text.length,
                          );
                        }
                      },
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        filled: true,
                        border: InputBorder.none,
                        fillColor: Colors.white.withOpacity(0.35),
                      ),
                    ),
                  ),
                  // title: Text(
                  //   "Untitled",
                  //   style: GoogleFonts.ubuntu(
                  //     textStyle: const TextStyle(color: Colors.white),
                  //   ),
                  // ),
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      DiaryEntry entry = DiaryEntry(
                        null,
                        _titleController.text,
                        _descriptionController.text,
                        DateTime.now(),
                        "",
                        null,
                      );
                      // createEntry(createEntryClient, entry);
                      _createEntry(entry);
                    },
                    icon: Icon(
                      Icons.check_box_rounded,
                      color: Colors.white,
                    ),
                  ),
                  // IconButton(
                  //   onPressed: () {},
                  //   icon: const Icon(
                  //     Icons.more_vert,
                  //     color: Colors.white,
                  //   ),
                  // ),
                ],
              ),
              SliverFillRemaining(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 0.05 * size.width,
                        vertical: 0.015 * size.height),
                    child: Column(
                      children: [
                        Card(
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          color: Colors.white.withOpacity(0.15),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 0.05 * size.width,
                                vertical: 0.01 * size.height),
                            child: TextFormField(
                              controller: _descriptionController,
                              style: GoogleFonts.aBeeZee(
                                textStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.5),
                                ),
                              ),
                              onTap: () {
                                if (_descriptionController.text ==
                                    "Description") {
                                  _descriptionController.selection =
                                      TextSelection(
                                    baseOffset: 0,
                                    extentOffset: _descriptionController
                                        .value.text.length,
                                  );
                                }
                              },
                              cursorColor: Colors.white.withOpacity(0.5),
                              decoration: InputDecoration(
                                filled: false,
                                border: InputBorder.none,
                              ),
                              maxLines: null,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ]),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
