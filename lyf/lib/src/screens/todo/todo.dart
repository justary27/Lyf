import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lyf/src/models/todo_model.dart';
import 'package:lyf/src/routes/routing.dart';
import 'package:lyf/src/shared/todo_card.dart';
import 'package:lyf/src/utils/handlers/route_handler.dart';

import '../../state/theme/theme_state.dart';
import '../../state/todo/todo_list_state.dart';
import '../../utils/errors/todo/todo_errors.dart';

class TodoPage extends ConsumerStatefulWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TodoPageState();
}

class _TodoPageState extends ConsumerState<TodoPage> {
  final GlobalKey<SliverAnimatedListState> _diaryKey =
      GlobalKey<SliverAnimatedListState>();

  void _refresh({bool? forceRefresh}) {
    try {
      ref.read(todoListNotifier).value;
      if (forceRefresh != null && forceRefresh) {
        ref.read(todoListNotifier.notifier).refresh();
      }
    } on TodoException catch (e) {
      ref.read(todoListNotifier.notifier).refresh();
    }
  }

  @override
  void initState() {
    super.initState();
    _refresh();
    // getTodos(todoClient);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    var theme = ref.read(themeNotifier.notifier).getCurrentState();

    return Stack(
      children: [
        Container(
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: theme.gradientColors,
            ),
          ),
        ),
        SizedBox(
          height: size.height,
          width: size.width,
          child: Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                goRouter.push(RouteHandler.createTodo);
              },
              backgroundColor: Theme.of(context).primaryColor.withOpacity(
                    0.35,
                  ),
              child: Icon(
                Icons.add,
                color: Theme.of(context).iconTheme.color,
              ),
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
                      goRouter.pop();
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ),
                  expandedHeight: 0.3 * size.height,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      foregroundDecoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.15),
                      ),
                      child: ColorFiltered(
                        colorFilter: ColorFilter.mode(
                          Colors.black.withBlue(10),
                          BlendMode.saturation,
                        ),
                        child: Image.asset(
                          "assets/images/todo.jpg",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: Text(
                      "Your TODOs",
                      style: Theme.of(context).textTheme.headline3,
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
                          // return SliverAnimatedList(
                          //   key: _diaryKey,
                          //   initialItemCount: todoList.length,
                          //   itemBuilder: (context, index, animation) {
                          //     return Padding(
                          //       padding: EdgeInsets.symmetric(
                          //           horizontal: 0.05 * size.width,
                          //           vertical: 0.015 * size.height),
                          //       child: TodoCard(
                          //         parentContext: context,
                          //         pageCode: "/todoPage",
                          //         size: size,
                          //         todo: todoList[index],
                          //       ),
                          //     );
                          //   },
                          // );
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
                        return SliverFillRemaining(
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Theme.of(context).primaryColor,
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
    );
  }
}
