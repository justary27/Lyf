import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lyf/src/global/variables.dart';
import 'package:lyf/src/models/todo_model.dart';
import 'package:lyf/src/routes/routing.dart';
import 'package:http/http.dart' as http;
import 'package:lyf/src/services/http.dart';
import 'package:lyf/src/shared/snackbars/unsaved_snack.dart';
import 'package:lyf/src/shared/todo_card.dart';
import 'package:lyf/src/state/todo/todo_list_state.dart';

class ViewTodoPage extends ConsumerStatefulWidget {
  final Todo todo;
  const ViewTodoPage({Key? key, required this.todo}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ViewTodoPageState();
}

class _ViewTodoPageState extends ConsumerState<ViewTodoPage> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late DateTime _dateController;

  late http.Client updateTodoClient;
  late ValueNotifier<bool> isChanged;
  void updateTodo(http.Client updateTodoClient, Todo todo) async {
    http.Response response;
    late int statusCode;
    try {
      statusCode = await Todo.updateTodo(
        updateTodoClient: updateTodoClient,
        todo: todo,
      );
      if (statusCode == 200) {
        SnackBar snackBar = const SnackBar(
          content: Text("Todo updated successfully!"),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.of(context).pushNamedAndRemoveUntil(
          RouteManager.todoPage,
          ModalRoute.withName(RouteManager.todoPage),
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

  void _updateTodo(Todo todo) {
    ref.read(todoListNotifier.notifier).editTodo(todo);
    Navigator.of(context).pop();
  }

  void changeFlag(bool flag) {
    setState(() {
      if (flag) {
        isChanged.value = flag;
      } else {
        isChanged.value = flag;
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
      _dateController = newDate;
    });
  }

  @override
  void initState() {
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    isChanged = ValueNotifier(false);
    updateTodoClient = http.Client();
    _titleController.text = widget.todo.todoTitle;
    _descriptionController.text = widget.todo.todoDescription;
    _dateController = widget.todo.todoCreatedAt;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        if (isChanged.value == true) {
          SnackBar snackBar = unsavedSnack(
            parentContext: context,
            size: size,
            item: widget.todo,
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
              // floatingActionButton: FloatingActionButton(
              //   onPressed: () {},
              //   backgroundColor: Colors.white.withOpacity(0.35),
              //   child: const Icon(Icons.attachment),
              // ),
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
                            item: widget.todo,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          await Future.delayed(
                            const Duration(seconds: 1),
                          );
                        } else {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();

                          Navigator.of(context).pop();
                          return;
                        }

                        RouteManager.navigateToTodo(context);
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
                          "assets/images/todo.jpg",
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
                            if (_titleController.text != widget.todo.title) {
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
                                  Todo updatedTodo = Todo(
                                      widget.todo.id,
                                      _titleController.text,
                                      _descriptionController.text,
                                      _dateController,
                                      false,
                                      null);
                                  _updateTodo(updatedTodo);
                                  // updateTodo(updateTodoClient, updatedTodo);
                                }
                              },
                              icon: const Icon(
                                Icons.check_box_rounded,
                                color: Colors.white,
                              ),
                            ),
                          );
                        },
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
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 0.05 * size.width,
                                vertical: 0.015 * size.height),
                            child: TodoCard(
                              parentContext: context,
                              pageCode: "/todo/view",
                              size: size,
                              todo: widget.todo,
                              notifyflagChange: changeFlag,
                              notifyDescriptionChange: changeDescription,
                              notifyDateChange: changeDate,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
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
    _titleController.dispose();
    _descriptionController.dispose();
    updateTodoClient.close();

    super.dispose();
  }
}
