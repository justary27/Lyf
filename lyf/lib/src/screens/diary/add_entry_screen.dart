import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/diary_model.dart';
import '../../routes/routing.dart';
import '../../state/diary/diary_list_state.dart';
import '../../state/snackbar/snack_state.dart';
import '../../state/theme/theme_state.dart';
import '../../utils/enums/snack_type.dart';

class AddDiaryEntryScreen extends ConsumerStatefulWidget {
  const AddDiaryEntryScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddDiaryEntryScreenState();
}

class _AddDiaryEntryScreenState extends ConsumerState<AddDiaryEntryScreen> {
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
    ref.read(snackNotifier.notifier).sendSignal(SnackType.entryCreated);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    var theme = ref.read(themeNotifier.notifier).getCurrentState();

    return Stack(
      children: [
        Container(
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: theme.gradientColors,
            ),
          ),
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
                              color: Theme.of(context).iconTheme.color,
                            ),
                          ),
                          const Text("Location")
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.image,
                              color: Theme.of(context).iconTheme.color,
                            ),
                          ),
                          const Text("Images"),
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.audiotrack_outlined,
                              color: Theme.of(context).iconTheme.color,
                            ),
                          ),
                          const Text("Audio"),
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.color_lens_rounded,
                              color: Theme.of(context).iconTheme.color,
                            ),
                          ),
                          const Text("Doodle"),
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
                    goRouter.pop();
                  },
                  icon: const Icon(Icons.arrow_back_ios),
                ),
                expandedHeight: 0.3 * size.height,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    foregroundDecoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.15),
                    ),
                    child: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        Colors.black.withBlue(10),
                        BlendMode.saturation,
                      ),
                      child: Image.asset(
                        "assets/images/diary.jpg",
                        fit: BoxFit.cover,
                      ),
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
                        true,
                        DateTime.now(),
                        "",
                        null,
                      );
                      // createEntry(createEntryClient, entry);
                      _createEntry(entry);
                    },
                    icon: Icon(
                      Icons.check_box_rounded,
                      color: Theme.of(context).iconTheme.color,
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
