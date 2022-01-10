import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lyf/src/global/globals.dart';
import 'package:lyf/src/routes/routing.dart';
import 'package:http/http.dart' as http;
import 'package:lyf/src/services/http.dart';

class AddDiaryEntryPage extends StatefulWidget {
  const AddDiaryEntryPage({Key? key}) : super(key: key);

  @override
  _AddDiaryEntryPageState createState() => _AddDiaryEntryPageState();
}

class _AddDiaryEntryPageState extends State<AddDiaryEntryPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  late http.Client createEntryClient;
  @override
  void initState() {
    _titleController.text = "Untitled";
    _descriptionController.text = "Description";
    createEntryClient = http.Client();
    super.initState();
  }

  void createEntry(http.Client createEntryClient, String title,
      String description, DateTime datetime) async {
    http.Response response;
    try {
      response = await createEntryClient.post(
        Uri.parse(ApiEndpoints.createEntry(currentUser.userID)),
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
        RouteManager.navigateToDiary(context);
      } else {
        print(response.body);
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
            drawerEnableOpenDragGesture: false,
            drawer: Container(
              width: 0.2 * size.width,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.grey.shade500,
                  Colors.grey.shade800,
                ],
              )),
              child: Drawer(
                backgroundColor: Colors.transparent,
                child: Container(
                  height: size.height,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.location_on_outlined,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Location",
                          )
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.image,
                              color: Colors.white,
                            ),
                          ),
                          Text("Images"),
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.audiotrack_outlined,
                              color: Colors.white,
                            ),
                          ),
                          Text("Audio"),
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.color_lens_rounded,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Doodle",
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            floatingActionButton: Builder(builder: (context) {
              return FloatingActionButton(
                tooltip: "Add attachment",
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                  // showBottomSheet(
                  //     context: context,
                  //     builder: (context) => Container(
                  //           width: size.width * 0.8,
                  //           height: 0.1 * size.height,
                  //         ));
                },
                backgroundColor: Colors.white.withOpacity(0.35),
                child: const Icon(Icons.attachment),
              );
            }),
            backgroundColor: Colors.transparent,
            body: CustomScrollView(slivers: [
              SliverAppBar(
                pinned: true,
                backgroundColor: Colors.transparent,
                leading: IconButton(
                  onPressed: () {
                    RouteManager.navigateToDiary(context);
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
                      "assets/images/diary.jpg",
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
                  // title: Text(
                  //   "Untitled",
                  //   style: GoogleFonts.ubuntu(
                  //     textStyle: const TextStyle(color: Colors.white),
                  //   ),
                  // ),
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      createEntry(createEntryClient, _titleController.text,
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
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 0.05 * size.width,
                        vertical: 0.015 * size.height),
                    child: Column(
                      children: [
                        Card(
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
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
                                filled: false,
                                border: InputBorder.none,
                              ),
                              maxLines: null,
                            ),
                          ),
                        ),
                      ],
                    ),
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
    createEntryClient.close();
    super.dispose();
  }
}
