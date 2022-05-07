import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lyf/src/global/globals.dart';
import 'package:lyf/src/models/todo_model.dart';
import 'package:lyf/src/routes/routing.dart';
import 'package:http/http.dart' as http;
import 'package:lyf/src/services/http.dart';

class ViewTodoPage extends StatefulWidget {
  final Todo todo;
  const ViewTodoPage({Key? key, required this.todo}) : super(key: key);

  @override
  _ViewTodoPageState createState() => _ViewTodoPageState();
}

class _ViewTodoPageState extends State<ViewTodoPage> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late http.Client updateTodoClient;
  late http.Client deleteTodoClient;
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

  void deleteTodo(http.Client deleteTodoClient, Todo todo) async {
    late int statusCode;
    try {
      statusCode =
          await Todo.deleteTodo(deleteTodoClient: deleteTodoClient, todo: todo);
      if (statusCode == 200) {
        RouteManager.navigateToTodo(context);
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

  @override
  void initState() {
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    isChanged = ValueNotifier(false);
    updateTodoClient = http.Client();
    deleteTodoClient = http.Client();
    _titleController.text = widget.todo.todoTitle;
    _descriptionController.text = widget.todo.todoDescription;
    super.initState();
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
                      onPressed: () {
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
                                        widget.todo.createdAt,
                                        false,
                                        null);
                                    updateTodo(updateTodoClient, updatedTodo);
                                  }
                                },
                                icon: const Icon(
                                  Icons.check_box_rounded,
                                  color: Colors.white,
                                ),
                              ),
                            );
                          }),
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
                                              color:
                                                  Colors.white.withOpacity(0.5),
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
                                                widget.todo.description) {
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
                                                builder: (BuildContext context,
                                                    Widget? child) {
                                                  return Theme(
                                                    data: Theme.of(context),
                                                    child: child!,
                                                  );
                                                },
                                              ).then((value) {
                                                setState(() {
                                                  if (value != null) {
                                                    // dateController = value;
                                                    isChanged.value = true;
                                                  } else {
                                                    // dateController = widget
                                                    //     .entry.entryCreatedAt;
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
                                              "24/12/2021",
                                              // "${dateController.day}/${dateController.month}/${dateController.year}",
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
                                                  SnackBar snackBar = SnackBar(
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
                                                            padding: EdgeInsets
                                                                .fromLTRB(
                                                              0,
                                                              0,
                                                              0,
                                                              0.0175 *
                                                                  size.height,
                                                            ),
                                                            child: Text(
                                                              "Are you sure you want to delete the entry ${widget.todo.todoTitle}?",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: GoogleFonts
                                                                  .ubuntu(
                                                                textStyle:
                                                                    const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 20,
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
                                                                  width:
                                                                      size.width *
                                                                          0.40,
                                                                  child:
                                                                      TextButton(
                                                                    style:
                                                                        ButtonStyle(
                                                                      shape: MaterialStateProperty
                                                                          .all<
                                                                              RoundedRectangleBorder>(
                                                                        RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(6.0),
                                                                          side:
                                                                              const BorderSide(
                                                                            color:
                                                                                Colors.red,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      ScaffoldMessenger.of(
                                                                          context)
                                                                        ..hideCurrentSnackBar();
                                                                      deleteTodo(
                                                                          deleteTodoClient,
                                                                          widget
                                                                              .todo);
                                                                    },
                                                                    child: Text(
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
                                                                  width:
                                                                      size.width *
                                                                          0.40,
                                                                  child:
                                                                      TextButton(
                                                                    style:
                                                                        ButtonStyle(
                                                                      shape: MaterialStateProperty
                                                                          .all<
                                                                              RoundedRectangleBorder>(
                                                                        RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(
                                                                            6.0,
                                                                          ),
                                                                          side:
                                                                              BorderSide(
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      ScaffoldMessenger.of(
                                                                              context)
                                                                          .hideCurrentSnackBar();
                                                                    },
                                                                    child: Text(
                                                                      "No",
                                                                      style: GoogleFonts
                                                                          .aBeeZee(
                                                                        textStyle: TextStyle(
                                                                            color:
                                                                                Colors.white,
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
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    updateTodoClient.close();
    deleteTodoClient.close();
    super.dispose();
  }
}
