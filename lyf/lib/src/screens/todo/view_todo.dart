import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lyf/src/routes/routing.dart';

class ViewTodoPage extends StatefulWidget {
  const ViewTodoPage({Key? key}) : super(key: key);

  @override
  _ViewTodoPageState createState() => _ViewTodoPageState();
}

class _ViewTodoPageState extends State<ViewTodoPage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final TextEditingController _titleController = TextEditingController();
    final TextEditingController _descriptionController =
        TextEditingController();
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
        Container(
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
                    RouteManager.navigateToHome(context);
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
                  title: Text(
                    "Hello World",
                    style: GoogleFonts.ubuntu(
                      textStyle: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                actions: [
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
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              width: 0.9 * size.width,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 0.05 * size.width,
                                    vertical: 0.01 * size.height),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.fromLTRB(
                                        0,
                                        0.025 * size.height,
                                        0.0085 * size.width,
                                        0.025 * size.height,
                                      ),
                                      child: Text(
                                        "cjnd mdsfs,fslnlwsd vsd,v snfs, vsf wrf wrfwr fwwr gwgwgwr gwrgw rrgrwhwr hwhrwhwh.... cjnd mdsfs,fslnlwsd vsd,v snfs, vsf wrf wrfwr fwwr gwgwgwr gwrgw rrgrwhwr hwhrwhwh",
                                        style: GoogleFonts.aBeeZee(
                                          textStyle: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.5),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "24/12/2021",
                                          style: GoogleFonts.ubuntu(
                                            textStyle: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        ),
                                        ButtonBar(
                                          alignment: MainAxisAlignment.end,
                                          children: [
                                            TextButton(
                                              onPressed: () {},
                                              child: Text(
                                                "Set Reminder",
                                                style: GoogleFonts.ubuntu(),
                                              ),
                                            )
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
}
