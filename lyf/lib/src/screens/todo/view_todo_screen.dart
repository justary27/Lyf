import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lyf/src/global/variables.dart';
import 'package:lyf/src/models/todo_model.dart';
import 'package:lyf/src/routes/routing.dart';
import 'package:lyf/src/shared/snackbars/unsaved_snack.dart';
import 'package:lyf/src/shared/widgets/todo_card.dart';
import 'package:lyf/src/state/todo/todo_list_state.dart';

import '../../state/theme/theme_state.dart';

class ViewTodoScreen extends ConsumerStatefulWidget {
  final Todo todo;
  const ViewTodoScreen({super.key, required this.todo});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ViewTodoScreenState();
}

class _ViewTodoScreenState extends ConsumerState<ViewTodoScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late DateTime _dateController;
  late ValueNotifier<bool> isChanged;

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
    _titleController.text = widget.todo.todoTitle;
    _descriptionController.text = widget.todo.todoDescription;
    _dateController = widget.todo.todoCreatedAt;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    var theme = ref.watch(themeNotifier);

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
                colors: theme.gradientColors,
              ),
            ),
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

                        goRouter.pop();
                      },
                      icon: const Icon(Icons.arrow_back_ios),
                    ),
                    expandedHeight: 0.3 * size.height,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Container(
                        foregroundDecoration: BoxDecoration(
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.15),
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

    super.dispose();
  }
}
