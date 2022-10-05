import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:lyf/src/utils/handlers/route_handler.dart';
import 'package:share_plus/share_plus.dart';

import '../models/diary_model.dart';
import '../routes/routing.dart';
import '../shared/snackbars/delete_snack.dart';
import '../state/diary/diary_list_state.dart';

/// The generic card used for displaying all the entry cards.
///
/// [size] MediaQuery.of(context).size of parent, must not be null.
/// [entry] The diary entry to be displayed, must not be null.
/// [parentContext] The context used for displaying card's snackbars and handling onTap events, must not be null.
class EntryCard extends ConsumerStatefulWidget {
  final Size size;
  final DiaryEntry entry;
  final BuildContext parentContext;
  final void Function(bool flag)? notifyflagChange;
  final void Function(String newDescription)? notifyDescriptionChange;
  final void Function(DateTime newDate)? notifyDateChange;
  final int pageCode;
  const EntryCard({
    Key? key,
    required this.size,
    required this.parentContext,
    required this.entry,
    required this.pageCode,
    this.notifyflagChange,
    this.notifyDescriptionChange,
    this.notifyDateChange,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EntryCardState();
}

class _EntryCardState extends ConsumerState<EntryCard> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late ValueNotifier<DateTime> _dateController;
  http.Client? deleteEntryClient;

  void _deleteEntry(DiaryEntry entry) {
    ref.read(diaryNotifier.notifier).removeEntry(entry);
    Navigator.of(context).pop();
  }

  Widget titleWidget({
    required pageCode,
    required DiaryEntry entry,
  }) {
    if (pageCode == 0) {
      return const SizedBox(width: 0, height: 0);
    } else if (pageCode == 1) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            entry.title,
            style: Theme.of(context).textTheme.headline3,
          ),
          IconButton(
            onPressed: () {
              Share.share(
                  "${entry.entryTitle}\n\n${entry.entryDescription}\n\nDated:${entry.entryCreatedAt.day}/${entry.entryCreatedAt.month}/${entry.entryCreatedAt.year}");
            },
            icon: const Icon(
              Icons.share_rounded,
              color: Colors.white,
            ),
          )
        ],
      );
    } else {
      return const SizedBox(width: 0, height: 0);
    }
  }

  Widget descriptionWidget({
    required pageCode,
    required DiaryEntry entry,
    TextEditingController? titleController,
    TextEditingController? descriptionController,
    ValueNotifier<DateTime>? dateController,
    void Function(bool flag)? notifyflagChange,
    void Function(String newDescription)? notifyDescriptionChange,
    void Function(DateTime newDate)? notifyDateChange,
  }) {
    if (pageCode == 0) {
      return TextFormField(
        controller: _descriptionController,
        style: GoogleFonts.aBeeZee(
          textStyle: TextStyle(
            color: Colors.white.withOpacity(0.5),
          ),
        ),
        cursorColor: Colors.white.withOpacity(0.5),
        decoration: InputDecoration(
          filled: false,
          border: InputBorder.none,
        ),
        maxLines: null,
        onChanged: (notifyflagChange != null && notifyDescriptionChange != null)
            ? (value) {
                if (_descriptionController.text != entry.description) {
                  notifyDescriptionChange(_descriptionController.text);
                  notifyflagChange(true);
                } else {
                  notifyDescriptionChange(entry.description);
                  notifyflagChange(false);
                }
              }
            : null,
      );
    } else if (pageCode == 1) {
      return Text(
        entry.entryDescription,
        style: Theme.of(context).textTheme.bodyText1,
      );
    } else {
      return Text(
        "entry.entryDescription",
        style: Theme.of(context).textTheme.bodyText1,
      );
    }
  }

  Widget entryCard({
    required Size size,
    required BuildContext context,
    required DiaryEntry entry,
    required pageCode,
    required http.Client? deleteEntryClient,
    TextEditingController? titleController,
    TextEditingController? descriptionController,
    ValueNotifier<DateTime>? dateController,
    void Function(bool flag)? notifyflagChange,
    void Function(String newDescription)? notifyDescriptionChange,
    void Function(DateTime newDate)? notifyDateChange,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.015 * size.height),
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: Colors.white.withOpacity(0.15),
        child: InkWell(
          onTap: () {
            if (pageCode == 1) {
              goRouter.push(
                RouteHandler.viewDiary(
                  entry.entryId!,
                ),
                extra: [entry, size],
              );
            }
          },
          child: SizedBox(
            width: 0.9 * size.width,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 0.05 * size.width, vertical: 0.015 * size.height),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  titleWidget(pageCode: pageCode, entry: entry),
                  Container(
                    padding: EdgeInsets.fromLTRB(
                      0,
                      0.025 * size.height,
                      0.0085 * size.width,
                      0.025 * size.height,
                    ),
                    child: TextFormField(
                      controller: _descriptionController,
                      style: GoogleFonts.aBeeZee(
                        textStyle: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                        ),
                      ),
                      cursorColor: Colors.white.withOpacity(0.5),
                      decoration: InputDecoration(
                        filled: false,
                        border: InputBorder.none,
                      ),
                      maxLines: null,
                      onChanged: (notifyflagChange != null &&
                              notifyDescriptionChange != null)
                          ? (value) {
                              if (_descriptionController.text !=
                                  entry.description) {
                                notifyDescriptionChange(
                                    _descriptionController.text);
                                notifyflagChange(true);
                              } else {
                                notifyDescriptionChange(entry.description);
                                notifyflagChange(false);
                              }
                            }
                          : null,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            builder: (BuildContext context, Widget? child) {
                              return Theme(
                                data: Theme.of(context),
                                child: child!,
                              );
                            },
                          ).then((value) {
                            setState(() {
                              if (value != null &&
                                  notifyflagChange != null &&
                                  notifyDateChange != null) {
                                dateController!.value = value;
                                notifyDateChange(value);
                                notifyflagChange(true);
                              } else {
                                dateController!.value = entry.entryCreatedAt;
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
                        child: ValueListenableBuilder(
                          valueListenable: _dateController,
                          builder: (context, value, child) => Text(
                            "${dateController!.value.day}/${dateController.value.month}/${dateController.value.year}",
                            style: GoogleFonts.ubuntu(
                              textStyle: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      (pageCode == 0 || pageCode == 1)
                          ? ButtonBar(
                              alignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    SnackBar snackBar = deleteSnack(
                                      parentContext: widget.parentContext,
                                      size: size,
                                      item: entry,
                                      performDeleteTask: _deleteEntry,
                                    );
                                    ScaffoldMessenger.of(context)
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
                                // TextButton(
                                //   onPressed: () {},
                                //   child: Text(
                                //     "Save as PDF",
                                //     style: GoogleFonts.ubuntu(),
                                //   ),
                                // )
                              ],
                            )
                          : Container(),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _titleController.text = widget.entry.entryTitle;
    _descriptionController.text = widget.entry.description;
    _dateController = ValueNotifier<DateTime>(widget.entry.createdAt);
    (widget.pageCode == 1 || widget.pageCode == 0)
        ? deleteEntryClient = http.Client()
        : deleteEntryClient = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return entryCard(
      size: widget.size,
      context: widget.parentContext,
      entry: widget.entry,
      titleController: _titleController,
      descriptionController: _descriptionController,
      dateController: _dateController,
      notifyflagChange: widget.notifyflagChange,
      pageCode: widget.pageCode,
      deleteEntryClient: deleteEntryClient,
      notifyDescriptionChange: widget.notifyDescriptionChange,
      notifyDateChange: widget.notifyDateChange,
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
