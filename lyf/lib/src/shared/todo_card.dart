import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lyf/src/models/todo_model.dart';
import 'package:lyf/src/shared/snackbars/delete_snack.dart';
import 'package:http/http.dart' as http;
import '../routes/routing.dart';

/// The generic card used for displaying all the todo cards.
class TodoCard extends StatefulWidget {
  /// The context used by the parent widget.
  final BuildContext parentContext;

  /// The code that determines UI layout of card.
  final pageCode;

  final Size size;

  /// The todo instance the card will use.
  final Todo? todo;

  /// Helper delete method corresponding to pageCode=="/todoPage"
  final void Function(http.Client deleteTodoClient, Todo todo)? deleteTodo;

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
    this.deleteTodo,
    this.notifyflagChange,
    this.notifyDescriptionChange,
    this.notifyDateChange,
  }) : super(key: key);

  @override
  State<TodoCard> createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  late TextEditingController _descriptionController;
  late ValueNotifier<DateTime> _dateController;
  late http.Client? _deleteTodoClient;

  // tasks

  /// Class method to call the actual delete helper method for the todo.
  void deleteTodo(http.Client deleteTodoClient, Todo todo) async {
    if (widget.pageCode == "/todo/view") {
      late int statusCode;
      try {
        statusCode = await Todo.deleteTodo(
          deleteTodoClient: deleteTodoClient,
          todo: todo,
        );
        if (statusCode == 200) {
          RouteManager.navigateToTodo(widget.parentContext);
        } else {
          SnackBar snackBar = const SnackBar(
            content: Text("Something went wrong"),
          );
          ScaffoldMessenger.of(widget.parentContext).showSnackBar(snackBar);
        }
      } catch (e) {
        print(e);
      }
    } else {
      widget.deleteTodo!(deleteTodoClient, todo);
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
          child: Text(
            widget.todo!.title,
            style: Theme.of(context).textTheme.headline3,
          ),
          height: 0.075 * size.height,
          alignment: Alignment.bottomLeft,
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
                    deleteItemClient: _deleteTodoClient,
                    performDeleteTask: deleteTodo,
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
                    deleteItemClient: _deleteTodoClient,
                    performDeleteTask: deleteTodo,
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
          onChanged: (value) {
            widget.notifyDescriptionChange!(value);
          },
        ),
      );
    } else {
      return InkWell(
        onTap: () {
          RouteManager.navigateToViewTodo(widget.parentContext, widget.todo!);
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

    _deleteTodoClient = http.Client();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = widget.size;
    Todo? todo = widget.todo;
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.white.withOpacity(0.15),
      child: buildCardContents(
        size: size,
      ),
    );
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _deleteTodoClient!.close();

    super.dispose();
  }
}
