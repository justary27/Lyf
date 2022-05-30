import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lyf/src/models/todo_model.dart';
import 'package:lyf/src/routes/routing.dart';
import 'package:lyf/src/shared/todo_card.dart';

import '../../state/todo/todo_list_state.dart';

class TodoPage extends ConsumerStatefulWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TodoPageState();
}

class _TodoPageState extends ConsumerState<TodoPage> {
  void _retrieve() {
    if (ref.read(todoListNotifier).value != null) {
      ref.read(todoListNotifier.notifier).retrieveTodoList();
    }
  }

  void _refresh() {
    if (ref.read(todoListNotifier).value != null) {
      ref.read(todoListNotifier.notifier).refresh();
    }
  }

  @override
  void initState() {
    super.initState();
    _retrieve();
    // getTodos(todoClient);
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
                  Consumer(
                    builder: ((context, ref, child) {
                      final todoState = ref.watch(todoListNotifier);
                      return todoState.when(
                        data: (List<Todo>? todoList) {
                          if (todoList!.isEmpty) {
                            return const SliverFillRemaining(
                              child: Center(
                                child: Text(
                                  "Looks like you don't have any todos :) \n Yay!",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                          } else {
                            return SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (context, index) => Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 0.05 * size.width,
                                      vertical: 0.015 * size.height),
                                  child: TodoCard(
                                    parentContext: context,
                                    pageCode: "/todoPage",
                                    size: size,
                                    todo: todoList[index],
                                  ),
                                ),
                                childCount: todoList.length,
                              ),
                            );
                          }
                        },
                        error: (Object error, StackTrace? stackTrace) {
                          return const SliverFillRemaining(
                            child: Center(
                              child: Text("Unable to retrieve your Todo List."),
                            ),
                          );
                        },
                        loading: () {
                          return const SliverFillRemaining(
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                          );
                        },
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
