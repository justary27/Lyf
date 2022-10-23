import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lyf/src/utils/handlers/route_handler.dart';

import '../../models/todo_model.dart';
import '../snackbars/delete_snack.dart';
import '../../routes/routing.dart';
import '../../state/todo/todo_list_state.dart';

/// The generic card used for displaying all the todo cards.
class TodoCard extends ConsumerStatefulWidget {
  /// The context used by the parent widget.
  final BuildContext parentContext;

  /// The code that determines UI layout of card.
  final String pageCode;

  final Size size;

  /// The todo instance the card will use.
  final Todo? todo;

  // /// Helper delete method corresponding to pageCode=="/todoPage"
  // final void Function(http.Client deleteTodoClient, Todo todo)? deleteTodo;

  /// Helper method to notify edit flag change corresponding
  /// to the pageCode == "/todo/view"
  final void Function(bool flag)? notifyflagChange;

  /// Helper method to notify a change in the [todo]'s description, only for
  /// the pageCode == "/todo/view" && "/todo/add"
  final void Function(String newDescription)? notifyDescriptionChange;

  /// Helper method to notify a change in the [todo]'s createdAt property, only
  /// for the pageCode == "/todo/view"
  final void Function(DateTime newDate)? notifyDateChange;

  // Constructor

  const TodoCard({
    Key? key,
    required this.parentContext,
    required this.pageCode,
    required this.size,
    required this.todo,
    this.notifyflagChange,
    this.notifyDescriptionChange,
    this.notifyDateChange,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TodoCardState();
}

class _TodoCardState extends ConsumerState<TodoCard> {
  late TextEditingController _descriptionController;
  late ValueNotifier<DateTime> _dateController;

  // tasks

  /// Class method to call the actual delete helper method for the todo.
  void _deleteTodo(Todo todo) {
    if (widget.pageCode == "/todo/view") {
      ref.read(todoListNotifier.notifier).removeTodo(todo);
      Navigator.of(context).pop();
      // RouteManager.navigateToTodo(widget.parentContext);

      // late int statusCode;
      // try {
      //   statusCode = await Todo.deleteTodo(
      //     deleteTodoClient: deleteTodoClient,
      //     todo: todo,
      //   );
      //   if (statusCode == 200) {
      //   } else {
      //     SnackBar snackBar = const SnackBar(
      //       content: Text("Something went wrong"),
      //     );
      //     ScaffoldMessenger.of(widget.parentContext).showSnackBar(snackBar);
      //   }
      // } catch (e) {
      //   print(e);
      // }
    } else {
      ref.read(todoListNotifier.notifier).removeTodo(todo);

      // widget.deleteTodo!(deleteTodoClient, todo);
    }
  }

  // Card component generating functions.

  /// Generates the card's body corresponding to the todo route.
  List<Widget> buildCardBody({
    required Size size,
  }) {
    if (widget.pageCode == "/todo/view") {
      return [
        Container(
          padding: EdgeInsets.fromLTRB(
              0, 0.025 * size.height, 0.0085 * size.width, 0.025 * size.height),
        ),
        TextFormField(
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
          onChanged: (value) {
            if (_descriptionController.text != widget.todo!.description) {
              widget.notifyflagChange!(true);
              widget.notifyDescriptionChange!(_descriptionController.text);
            } else {
              widget.notifyflagChange!(false);
            }
          },
        ),
      ];
    } else {
      return [
        Container(
          height: 0.075 * size.height,
          alignment: Alignment.bottomLeft,
          child: Text(
            widget.todo!.title,
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(
              0, 0.025 * size.height, 0.0085 * size.width, 0.025 * size.height),
          height: 0.225 * size.height,
          child: Text(
            widget.todo!.todoDescription,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      ];
    }
  }

  /// Generates the card's buttons corresponding to the todo route.
  Widget buildCardButtons({
    required Size size,
  }) {
    if (widget.pageCode == "/todo/view") {
      return Row(
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
                  if (value != null) {
                    widget.notifyflagChange!(true);
                    _dateController.value = value;
                    widget.notifyDateChange!(value);
                  } else {
                    widget.notifyflagChange!(false);
                    _dateController.value = widget.todo!.todoCreatedAt;
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
              "${_dateController.value.day}/${_dateController.value.month}/${_dateController.value.year}",
              style: GoogleFonts.ubuntu(
                textStyle: const TextStyle(color: Colors.white),
              ),
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  SnackBar snackBar = deleteSnack(
                    parentContext: widget.parentContext,
                    size: size,
                    item: widget.todo!,
                    performDeleteTask: _deleteTodo,
                  );
                  ScaffoldMessenger.of(widget.parentContext)
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
              //     "Set Reminder",
              //     style: GoogleFonts.ubuntu(),
              //   ),
              // )
            ],
          ),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "${widget.todo!.createdAt.day}/${widget.todo!.createdAt.month}/${widget.todo!.createdAt.year}",
            style: GoogleFonts.ubuntu(
              textStyle: const TextStyle(color: Colors.white),
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  SnackBar snackBar = deleteSnack(
                    parentContext: widget.parentContext,
                    size: size,
                    item: widget.todo!,
                    performDeleteTask: _deleteTodo,
                  );
                  ScaffoldMessenger.of(widget.parentContext)
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
                onPressed: () {
                  late TimeOfDay selectedTime;
                  late DateTime selectedDate;
                  // dateTimePicker(
                  //     parentContext: context);
                  // // showTimePicker(
                  // //   context: context,
                  // //   initialTime: TimeOfDay.now(),
                  // // );
                },
                child: Text(
                  "Set Reminder",
                  style: GoogleFonts.ubuntu(),
                ),
              )
            ],
          ),
        ],
      );
    }
  }

  /// Generates the Card contents with a basic skeleton.
  Widget buildCardContents({
    required Size size,
  }) {
    List<Widget>? cardContents;
    if (widget.todo != null) {
      cardContents = buildCardBody(size: size);
      cardContents.add(buildCardButtons(
        size: size,
      ));
    }
    if (widget.pageCode == "/todo/view") {
      return SizedBox(
        width: 0.9 * size.width,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 0.05 * size.width,
            vertical: 0.01 * size.height,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: cardContents!,
          ),
        ),
      );
    } else if (widget.pageCode == "/todo/add") {
      return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 0.05 * size.width, vertical: 0.01 * size.height),
        child: TextFormField(
          controller: _descriptionController,
          style: GoogleFonts.aBeeZee(
            textStyle: TextStyle(
              color: Colors.white.withOpacity(0.5),
            ),
          ),
          cursorColor: Colors.white.withOpacity(0.5),
          decoration: InputDecoration(
            border: InputBorder.none,
          ),
          maxLines: null,
          onTap: () {
            if (_descriptionController.text == "Description") {
              _descriptionController.selection = TextSelection(
                baseOffset: 0,
                extentOffset: _descriptionController.value.text.length,
              );
            }
          },
          onChanged: (value) {
            widget.notifyDescriptionChange!(value);
          },
        ),
      );
    } else {
      return InkWell(
        onTap: () {
          goRouter.push(
            RouteHandler.viewTodo(
              widget.todo!.id!,
            ),
            extra: widget.todo!,
          );
        },
        child: SizedBox(
          // height: 0.4 * size.height,
          width: 0.2 * size.width,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 0.05 * size.width,
              vertical: 0.01 * size.height,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: cardContents!,
            ),
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    _descriptionController = TextEditingController();
    if (widget.todo != null) {
      _descriptionController.text = widget.todo!.description;
      _dateController = ValueNotifier<DateTime>(widget.todo!.createdAt);
    } else {
      _descriptionController.text = "Description";
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = widget.size;
    Todo? todo = widget.todo;
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Theme.of(context).cardColor,
      child: buildCardContents(
        size: size,
      ),
    );
  }

  @override
  void dispose() {
    _descriptionController.dispose();

    super.dispose();
  }
}
