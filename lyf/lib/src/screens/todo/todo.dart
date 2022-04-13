import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lyf/src/global/globals.dart';
import 'package:lyf/src/models/todo_model.dart';
import 'package:lyf/src/routes/routing.dart';
import 'package:http/http.dart' as http;
import 'package:lyf/src/services/http.dart';
import 'package:lyf/src/shared/datetime_picker.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  late http.Client todoClient;
  late http.Client deleteTodoClient;
  List<Todo> todos = [];
  bool retrieveStatus = true;

  getTodos(http.Client client) async {
    List<Todo> todoList = [];
    var tOdOs = await client.get(
      Uri.parse(ApiEndpoints.getAllTodos(currentUser.userId)),
      headers: currentUser.authHeader(),
    );
    try {
      jsonDecode(tOdOs.body).forEach((element) {
        Todo todo = Todo.fromJson(element);
        todoList.add(todo);
      });
      setState(() {
        todos = todoList;
        retrieveStatus = true;
      });
    } catch (e) {
      print(e);
      setState(() {
        retrieveStatus = false;
      });
    }
  }

  void deleteTodo(
      http.Client deleteTodoClient, http.Client todoClient, Todo todo) async {
    late int statusCode;
    try {
      statusCode =
          await Todo.deleteTodo(deleteTodoClient: todoClient, todo: todo);
      if (statusCode == 200) {
        getTodos(todoClient);
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
    super.initState();
    todoClient = http.Client();
    deleteTodoClient = http.Client();

    getTodos(todoClient);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        RouteManager.navigateToHome(context);
        await Future.delayed(const Duration(microseconds: 100));
        return true;
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
              ),
            ),
            child: CustomPaint(),
          ),
          SizedBox(
            height: size.height,
            width: size.width,
            child: Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  RouteManager.navigateToAddTodo(context);
                },
                backgroundColor: Colors.white.withOpacity(0.35),
                child: Icon(Icons.add),
              ),
              backgroundColor: Colors.transparent,
              body: CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    SliverAppBar(
                      pinned: true,
                      backgroundColor: Colors.transparent,
                      leading: IconButton(
                        onPressed: () {
                          RouteManager.navigateToHome(context);
                        },
                        icon: Icon(Icons.arrow_back_ios),
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
                        title: Text(
                          "Your TODOs",
                          style: GoogleFonts.ubuntu(
                            textStyle: Theme.of(context).textTheme.headline3,
                          ),
                        ),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 0.05 * size.width,
                              vertical: 0.015 * size.height),
                          child: Card(
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            color: Colors.white.withOpacity(0.15),
                            child: InkWell(
                              onTap: () {
                                RouteManager.navigateToViewTodo(
                                    context, todos[index]);
                              },
                              child: SizedBox(
                                height: 0.4 * size.height,
                                width: 0.2 * size.width,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 0.05 * size.width,
                                      vertical: 0.01 * size.height),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Text(
                                          todos[index].title,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline3,
                                        ),
                                        height: 0.075 * size.height,
                                        alignment: Alignment.bottomLeft,
                                      ),
                                      Container(
                                        padding: EdgeInsets.fromLTRB(
                                          0,
                                          0.025 * size.height,
                                          0.0085 * size.width,
                                          0.025 * size.height,
                                        ),
                                        height: 0.225 * size.height,
                                        child: Text(
                                          todos[index].todoDescription,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
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
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                          0,
                                                          0,
                                                          0,
                                                          0.0175 * size.height,
                                                        ),
                                                        child: Text(
                                                          "Are you sure you want to delete the entry ${todos[index].todoTitle}?",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: GoogleFonts
                                                              .ubuntu(
                                                            textStyle:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.white,
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
                                                              child: TextButton(
                                                                style:
                                                                    ButtonStyle(
                                                                  shape: MaterialStateProperty
                                                                      .all<
                                                                          RoundedRectangleBorder>(
                                                                    RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              6.0),
                                                                      side:
                                                                          const BorderSide(
                                                                        color: Colors
                                                                            .red,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                onPressed: () {
                                                                  ScaffoldMessenger
                                                                      .of(context)
                                                                    ..hideCurrentSnackBar();
                                                                  deleteTodo(
                                                                      deleteTodoClient,
                                                                      todoClient,
                                                                      todos[
                                                                          index]);
                                                                },
                                                                child: Text(
                                                                  "Yes",
                                                                  style: GoogleFonts
                                                                      .aBeeZee(
                                                                    textStyle:
                                                                        const TextStyle(
                                                                      color: Colors
                                                                          .red,
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
                                                              child: TextButton(
                                                                style:
                                                                    ButtonStyle(
                                                                  shape: MaterialStateProperty
                                                                      .all<
                                                                          RoundedRectangleBorder>(
                                                                    RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .circular(
                                                                        6.0,
                                                                      ),
                                                                      side:
                                                                          BorderSide(
                                                                        color: Colors
                                                                            .white,
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
                                                                  style: GoogleFonts
                                                                      .aBeeZee(
                                                                    textStyle: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            20),
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
                                          //   onPressed: () {
                                          //     late TimeOfDay selectedTime;
                                          //     late DateTime selectedDate;
                                          //     dateTimePicker(
                                          //         parentContext: context);
                                          //     // showTimePicker(
                                          //     //   context: context,
                                          //     //   initialTime: TimeOfDay.now(),
                                          //     // );
                                          //   },
                                          //   child: Text(
                                          //     "Set Reminder",
                                          //     style: GoogleFonts.ubuntu(),
                                          //   ),
                                          // )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        childCount: todos.length,
                      ),
                    ),
                  ]),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    todoClient.close();
    deleteTodoClient.close();
    super.dispose();
  }
}
