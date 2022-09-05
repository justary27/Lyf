import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/todo_model.dart';
import '../../routes/routing.dart';
import '../../shared/todo_card.dart';
import '../../state/todo/todo_list_state.dart';
import '../../utils/enums/snack_type.dart';
import '../../state/snackbar/snack_state.dart';

class AddTodoPage extends ConsumerStatefulWidget {
  const AddTodoPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends ConsumerState<AddTodoPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    _titleController.text = "Untitled";
    _descriptionController.text = "Description";
    super.initState();
  }

  void _createTodo(Todo todo) {
    ref.read(todoListNotifier.notifier).addTodo(todo);
    ref.read(snackNotifier.notifier).sendSignal(SnackType.todoCreated);
    Navigator.of(context).pop();
  }

  void changeDescription(String newDescription) {
    setState(() {
      _descriptionController.text = newDescription;
    });
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
                      child: TextField(
                        controller: _titleController,
                        style: GoogleFonts.ubuntu(
                          textStyle: const TextStyle(color: Colors.white),
                        ),
                        onTap: () {
                          if (_titleController.text == "Untitled") {
                            _titleController.selection = TextSelection(
                              baseOffset: 0,
                              extentOffset: _titleController.value.text.length,
                            );
                          }
                        },
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          filled: true,
                          border: InputBorder.none,
                          fillColor: Colors.white.withOpacity(0.35),
                        ),
                      ),
                    ),
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {
                        Todo todo = Todo(
                            null,
                            _titleController.text,
                            _descriptionController.text,
                            DateTime.now(),
                            false,
                            null);
                        _createTodo(todo);
                      },
                      icon: Icon(
                        Icons.check_box_rounded,
                        color: Colors.white,
                      ),
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
                            pageCode: "/todo/add",
                            parentContext: context,
                            size: size,
                            todo: null,
                            notifyDescriptionChange: changeDescription,
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
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();

    super.dispose();
  }
}
