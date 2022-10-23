import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lyf/src/routes/routing.dart';

class NotifactionSettingsPage extends StatefulWidget {
  const NotifactionSettingsPage({Key? key}) : super(key: key);

  @override
  State<NotifactionSettingsPage> createState() =>
      _NotifactionSettingsPageState();
}

class _NotifactionSettingsPageState extends State<NotifactionSettingsPage> {
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
            appBar: AppBar(
              // shadowColor: Colors.transparent,
              backgroundColor: Colors.transparent,
              leading: IconButton(
                onPressed: () {
                  goRouter.pop();
                },
                icon: Icon(Icons.arrow_back_ios),
              ),
              title: Text(
                "Notifications",
                style: GoogleFonts.ubuntu(
                    textStyle: TextStyle(color: Colors.white)),
              ),
            ),
            backgroundColor: Colors.transparent,
            body: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 0.05 * size.width,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 0.05 * size.width,
                          vertical: 0.025 * size.height,
                        ),
                        leading: Icon(
                          Icons.info_outline_rounded,
                          color: Colors.white,
                          size: 35,
                        ),
                        title: Text(
                          "Account info",
                          style: GoogleFonts.ubuntu(
                            textStyle: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        subtitle: Text(
                          "Basic account related settings.",
                          style: GoogleFonts.aBeeZee(
                              textStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.35))),
                        ),
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 0.05 * size.width,
                          vertical: 0.025 * size.height,
                        ),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                        ),
                        tileColor: Colors.white.withOpacity(0.15),
                        title: Text(
                          "Username",
                          style: GoogleFonts.ubuntu(
                            textStyle: TextStyle(
                              fontSize: 17.5,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        subtitle: Text(
                          "justary27",
                          style: GoogleFonts.aBeeZee(
                              textStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.35))),
                        ),
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 0.05 * size.width,
                        ),
                        tileColor: Colors.white.withOpacity(0.15),
                        onTap: () {},
                        title: Text(
                          "Change Email",
                          style: GoogleFonts.ubuntu(
                            textStyle: TextStyle(
                              fontSize: 17.5,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        subtitle: Text(
                          "Change the email linked with your account.",
                          style: GoogleFonts.aBeeZee(
                              textStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.35))),
                        ),
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 0.05 * size.width,
                        ),
                        tileColor: Colors.white.withOpacity(0.15),
                        onTap: () {},
                        title: Text(
                          "Change Password",
                          style: GoogleFonts.ubuntu(
                            textStyle: TextStyle(
                              fontSize: 17.5,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        subtitle: Text(
                          "Change your current password.",
                          style: GoogleFonts.aBeeZee(
                              textStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.35))),
                        ),
                      ),
                      ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12),
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 0.05 * size.width,
                          vertical: 0.0125 * size.height,
                        ),
                        tileColor: Colors.white.withOpacity(0.15),
                        title: Text(
                          "Usage",
                          style: GoogleFonts.ubuntu(
                            textStyle: TextStyle(
                              fontSize: 17.5,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        isThreeLine: true,
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "A visual representation of your daily usage.",
                              style: GoogleFonts.aBeeZee(
                                  textStyle: TextStyle(
                                      color: Colors.white.withOpacity(0.35))),
                            ),
                            Card(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
