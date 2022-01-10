import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lyf/src/global/globals.dart';
import 'package:lyf/src/routes/routing.dart';
import 'package:lyf/src/services/http.dart';
import 'package:http/http.dart' as http;

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({Key? key}) : super(key: key);

  @override
  _AddTodoPageState createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  late http.Client createTodoClient;

  @override
  void initState() {
    _titleController.text = "Untitled";
    _descriptionController.text = "Description";
    createTodoClient = http.Client();
    super.initState();
  }

  void createTodo(http.Client createTodoClient, String title,
      String description, DateTime datetime) async {
    http.Response response;
    try {
      response = await createTodoClient.post(
        Uri.parse(ApiEndpoints.createTodo(currentUser.userID)),
        body: {
          '_userId': currentUser.userID,
          '_title': title,
          '_description': description,
          '_created_on': datetime.toIso8601String(),
        },
        headers: currentUser.authHeader(),
      );
      if (response.statusCode == 200) {
        SnackBar snackBar = const SnackBar(
          content: Text("Entry created successfully!"),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              backgroundColor: Colors.white.withOpacity(0.35),
              child: const Icon(Icons.attachment),
            ),
            backgroundColor: Colors.transparent,
            body: CustomScrollView(slivers: [
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
                      createTodo(createTodoClient, _titleController.text,
                          _descriptionController.text, DateTime.now());
                    },
                    icon: Icon(
                      Icons.check_box_rounded,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.more_vert,
                      color: Colors.white,
                    ),
                  ),
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
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 0.05 * size.width,
                                vertical: 0.01 * size.height),
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
    createTodoClient.close();
    super.dispose();
  }
}
