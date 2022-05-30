import 'dart:developer';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lyf/src/models/diary_model.dart';
import 'package:lyf/src/utils/errors/firestorage_exceptions.dart';
import 'package:lyf/src/utils/handlers/permission_handler.dart';
import 'package:lyf/src/routes/routing.dart';
import 'package:http/http.dart' as http;
import 'package:lyf/src/services/firebase/storage.dart';
import 'package:lyf/src/shared/audio_viewer.dart';
import 'package:lyf/src/shared/entry_card.dart';
import 'package:lyf/src/shared/image_viewer.dart';
import 'package:lyf/src/shared/snackbars/fileupload_snack.dart';
import 'package:lyf/src/shared/snackbars/unsaved_snack.dart';

import '../../state/diary/diary_list_state.dart';

class ViewDiaryEntryPage extends ConsumerStatefulWidget {
  final DiaryEntry entry;
  final Size size;
  const ViewDiaryEntryPage({
    Key? key,
    required this.entry,
    required this.size,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ViewDiaryEntryPageState();
}

class _ViewDiaryEntryPageState extends ConsumerState<ViewDiaryEntryPage> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late http.Client updateEntryClient;
  late DateTime dateController;
  List<String>? imageAttachmentLinks;
  late ValueNotifier<bool> isChanged;
  late List<Widget> utilWidgets;
  PlatformFile? audioAttachment;
  List<PlatformFile?>? imageAttachments;

  void updateEntry(http.Client updateEntryClient, DiaryEntry entry) async {
    late int statusCode;
    try {
      try {
        if (imageAttachments != null || audioAttachment != null) {
          ScaffoldMessenger.of(context).showSnackBar(fileSnackBar);
          await FireStorage.diaryUploads(
            entryId: entry.entryId!,
            imageFiles: imageAttachments,
            audioFile: audioAttachment,
            notifyImageLinker: assignImageLinks,
          );
        }
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      } catch (e) {
        log(e.runtimeType.toString());
        if (e == ImageUploadException) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        } else if (e == AudioUploadException) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        }
      }
      entry.imageLinks = imageAttachmentLinks;
      statusCode = await DiaryEntry.updateEntry(
          updateEntryClient: updateEntryClient, entry: entry);
      if (statusCode == 200) {
        SnackBar snackBar = const SnackBar(
          content: Text("Entry updated successfully!"),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        FocusManager.instance.primaryFocus?.unfocus();
        Navigator.of(context).pushNamedAndRemoveUntil(
          RouteManager.diaryPage,
          ModalRoute.withName(RouteManager.diaryPage),
        );
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

  void _updateEntry(DiaryEntry updatedEntry) {
    ref.read(diaryNotifier.notifier).editEntry(updatedEntry);
    Navigator.of(context).pop();
  }

  void changeFlag(bool flag) {
    setState(() {
      // isChanged.value = flag;
      if (flag) {
        isChanged.value = flag;
      } else {
        if (utilWidgets.length > 2) {
          isChanged.value = !flag;
        } else {
          if (widget.entry.entryTitle != _titleController.text ||
              widget.entry.description != _descriptionController.text ||
              widget.entry.createdAt != dateController) {
          } else {
            isChanged.value = flag;
          }
        }
      }
    });
  }

  void changeDescription(String newDescription) {
    setState(() {
      _descriptionController.text = newDescription;
    });
  }

  void changeDate(DateTime newDate) {
    setState(() {
      dateController = newDate;
    });
  }

  void addAttachment(Widget attachment) {
    setState(() {
      utilWidgets.add(attachment);
    });
  }

  void removeAttachment(Key key) {
    Widget? attachment;
    for (Widget widget in utilWidgets) {
      if (widget.key == key) {
        attachment = widget;
        break;
      }
    }
    setState(() {
      if (attachment != null) {
        utilWidgets.remove(attachment);
      }
    });
  }

  void assignAudioAttachment(PlatformFile? audioFile) {
    setState(() {
      audioAttachment = audioFile;
    });
  }

  void assignImageLinks(List<String> imageLinkList) {
    setState(() {
      imageAttachmentLinks = imageLinkList;
    });
  }

  void assignImageAttachment(List<PlatformFile?>? imageFiles) {
    setState(() {
      imageAttachments = imageFiles;
    });
  }

  Widget? initImageWidgetProvider() {
    if (widget.entry.imageLinks.toString() != '[Null]') {
      return ImageViewer(
        removeMethod: removeAttachment,
        notifyflagChange: changeFlag,
        fileHandler: assignImageAttachment,
        size: MediaQuery.of(context).size,
        imageUrls: widget.entry.imageLinks,
      );
    } else {
      return null;
    }
  }

  @override
  void initState() {
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    isChanged = ValueNotifier(false);
    updateEntryClient = http.Client();
    _titleController.text = widget.entry.entryTitle;
    _descriptionController.text = widget.entry.description;
    dateController = widget.entry.entryCreatedAt;
    utilWidgets = [
      EntryCard(
        size: widget.size,
        parentContext: context,
        entry: widget.entry,
        notifyflagChange: changeFlag,
        notifyDescriptionChange: changeDescription,
        notifyDateChange: changeDate,
        pageCode: 0,
      )
    ];
    super.initState();
  }

  // @override
  // void didChangeDependencies() {
  //   try {
  //     Widget? widget = initImageWidgetProvider();
  //     setState(() {
  //       if (widget != null) {
  //         utilWidgets.add(widget);
  //       }
  //     });
  //     print(utilWidgets.length);
  //   } catch (e) {
  //     print(e);
  //   }
  //   // TODO: implement didChangeDependencies
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        if (isChanged.value == true) {
          SnackBar snackBar = unsavedSnack(
            parentContext: context,
            size: size,
            item: widget.entry,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          await Future.delayed(
            const Duration(seconds: 1),
          );
          return false;
        } else {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
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
                  ),
                ),
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
                              onPressed: () {
                                PermissionManager.requestLocationAccess();
                              },
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
                              onPressed: () async {
                                Widget? response = await imagePickerLauncher(
                                    requestStorageAccess:
                                        PermissionManager.requestStorageAccess,
                                    size: size,
                                    removeMethod: removeAttachment,
                                    notifyflagChange: changeFlag,
                                    fileServer: assignImageAttachment);
                                if (response != null) {
                                  addAttachment(response);
                                }
                                Navigator.of(context).pop();
                              },
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
                              onPressed: () async {
                                Widget? response = await audioPickerLauncher(
                                  requestStorageAccess:
                                      PermissionManager.requestStorageAccess,
                                  size: size,
                                  removeMethod: removeAttachment,
                                  notifyflagChange: changeFlag,
                                  fileServer: assignAudioAttachment,
                                );
                                if (response != null) {
                                  addAttachment(response);
                                }
                                Navigator.of(context).pop();
                              },
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
              body: CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    SliverAppBar(
                      pinned: true,
                      backgroundColor: Colors.transparent,
                      leading: IconButton(
                        onPressed: () async {
                          if (isChanged.value == true) {
                            SnackBar snackBar = unsavedSnack(
                              parentContext: context,
                              size: size,
                              item: widget.entry,
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            await Future.delayed(
                              const Duration(seconds: 1),
                            );
                          } else {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();

                            Navigator.of(context).pop();
                            return;
                          }
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
                                    if (isChanged.value == true) {
                                      DiaryEntry _updatedEntry = DiaryEntry(
                                        widget.entry.id,
                                        _titleController.text,
                                        _descriptionController.text,
                                        dateController,
                                        "",
                                        [
                                          "https://www.google.com",
                                          "https://www.google.com",
                                        ],
                                      );
                                      _updateEntry(_updatedEntry);
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.check_box_rounded,
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            }),
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
                        //             "Save as Pdf",
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
                    SliverFillRemaining(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: utilWidgets,
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
    super.dispose();
  }
}
