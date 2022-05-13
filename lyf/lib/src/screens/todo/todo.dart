import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lyf/src/global/globals.dart';
import 'package:lyf/src/models/todo_model.dart';
import 'package:lyf/src/routes/routing.dart';
import 'package:http/http.dart' as http;
import 'package:lyf/src/services/http.dart';
import 'package:lyf/src/shared/datetime_picker.dart';
import 'package:lyf/src/shared/todo_card.dart';

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

  void deleteTodo(http.Client deleteTodoClient, Todo todo) async {
    late int statusCode;
    try {
      statusCode =
          await Todo.deleteTodo(deleteTodoClient: todoClient, todo: todo);
      if (statusCode == 200) {
        getTodos(deleteTodoClient);
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
                        child: TodoCard(
                          parentContext: context,
                          pageCode: "/todoPage",
                          size: size,
                          todo: todos[index],
                          deleteTodo: deleteTodo,
                        ),
                      ),
                      childCount: todos.length,
                    ),
                  ),
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
    todoClient.close();
    deleteTodoClient.close();
    super.dispose();
  }
}
