import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lyf/src/models/diary_model.dart';
import 'package:http/http.dart' as http;
import 'package:lyf/src/routes/routing.dart';

/// The generic card used for displaying all the entry cards.
///
/// [size] MediaQuery.of(context).size of parent, must not be null.
/// [entry] The diary entry to be displayed, must not be null.
/// [parentContext] The context used for displaying card's snackbars, must not be null.
class EntryCard extends StatefulWidget {
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
  _EntryCardState createState() => _EntryCardState();
}

class _EntryCardState extends State<EntryCard> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late ValueNotifier<DateTime> _dateController;
  http.Client? deleteEntryClient;

  void deleteEntry(http.Client? deleteEntryClient, DiaryEntry entry) async {
    late int statusCode;
    try {
      statusCode = await DiaryEntry.deleteEntry(
          deleteEntryClient: deleteEntryClient!, entry: entry);
      if (statusCode == 200) {
        SnackBar snackBar = const SnackBar(
          content: Text("Entry deleted successfully"),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        RouteManager.navigateToDiary(context);
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

  Widget entryCard({
    required Size size,
    required BuildContext context,
    required DiaryEntry entry,
    required TextEditingController titleController,
    required TextEditingController descriptionController,
    required ValueNotifier<DateTime> dateController,
    required pageCode,
    required http.Client? deleteEntryClient,
    void Function(bool flag)? notifyflagChange,
    void Function(String newDescription)? notifyDescriptionChange,
    void Function(DateTime newDate)? notifyDateChange,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: 0.05 * size.width, vertical: 0.015 * size.height),
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: Colors.white.withOpacity(0.15),
        child: SizedBox(
          width: 0.9 * size.width,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 0.05 * size.width, vertical: 0.01 * size.height),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                              dateController.value = value;
                              notifyDateChange(value);
                              notifyflagChange(true);
                            } else {
                              dateController.value = entry.entryCreatedAt;
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
                          "${dateController.value.day}/${dateController.value.month}/${dateController.value.year}",
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
                                  SnackBar snackBar = SnackBar(
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                      ),
                                    ),
                                    duration: const Duration(
                                      seconds: 5,
                                    ),
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
                                              "Are you sure you want to delete the entry ${entry.entryTitle}?",
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
                                              alignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  width: size.width * 0.40,
                                                  child: TextButton(
                                                    style: ButtonStyle(
                                                      shape: MaterialStateProperty
                                                          .all<
                                                              RoundedRectangleBorder>(
                                                        RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      6.0),
                                                          side:
                                                              const BorderSide(
                                                            color: Colors.red,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .hideCurrentSnackBar();
                                                      deleteEntry(
                                                        deleteEntryClient,
                                                        entry,
                                                      );
                                                    },
                                                    child: Text(
                                                      "Yes",
                                                      style:
                                                          GoogleFonts.aBeeZee(
                                                        textStyle:
                                                            const TextStyle(
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
                                                      shape: MaterialStateProperty
                                                          .all<
                                                              RoundedRectangleBorder>(
                                                        RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                            6.0,
                                                          ),
                                                          side: BorderSide(
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .hideCurrentSnackBar();
                                                    },
                                                    child: Text(
                                                      "No",
                                                      style:
                                                          GoogleFonts.aBeeZee(
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
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Save as PDF",
                                  style: GoogleFonts.ubuntu(),
                                ),
                              )
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
