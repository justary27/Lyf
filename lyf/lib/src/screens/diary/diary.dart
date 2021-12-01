import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lyf/src/routes/routing.dart';

class DiaryPage extends StatefulWidget {
  const DiaryPage({Key? key}) : super(key: key);

  @override
  _DiaryPageState createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {
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
        Container(
          height: size.height,
          width: size.width,
          child: Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              backgroundColor: Colors.white.withOpacity(0.35),
              child: const Icon(Icons.add),
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
                      "assets/images/diary.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(
                    "Your Diary Entries",
                    style: GoogleFonts.ubuntu(
                      textStyle: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                actions: [
                  PopupMenuButton(
                    itemBuilder: (context) {
                      return [
                        const PopupMenuItem(
                          child: Text("dta"),
                        ),
                      ];
                    },
                    icon: const Icon(Icons.more_vert),
                  )
                ],
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
                        onTap: () {},
                        child: Container(
                          height: 0.4 * size.height,
                          width: 0.2 * size.width,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 0.05 * size.width,
                                vertical: 0.01 * size.height),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Hello World",
                                        style: GoogleFonts.ubuntu(
                                          textStyle: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 25,
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.share_rounded,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
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
                                    "cjnd mdsfs,fslnlwsd vsd,v snfs, vsf wrf wrfwr fwwr gwgwgwr gwrgw rrgrwhwr hwhrwhwh....",
                                    style: GoogleFonts.aBeeZee(
                                      textStyle: TextStyle(
                                        color: Colors.white.withOpacity(0.5),
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
                                            "Edit",
                                            style: GoogleFonts.ubuntu(),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {},
                                          child: Text(
                                            "Save as PDF",
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
                  childCount: 4,
                ),
              ),
            ]),
          ),
        ),
      ],
    );
  }
}
