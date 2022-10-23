import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lyf/src/routes/routing.dart';
import 'package:lyf/src/shared/contact_viewer.dart';
import 'package:share_plus/share_plus.dart';

import '../../utils/handlers/permission_handler.dart';

class InviteSettingsPage extends StatefulWidget {
  const InviteSettingsPage({Key? key}) : super(key: key);

  @override
  State<InviteSettingsPage> createState() => _InviteSettingsPageState();
}

class _InviteSettingsPageState extends State<InviteSettingsPage> {
  Widget? contactView;
  @override
  void initState() {
    super.initState();
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
                "Invite",
                style: GoogleFonts.ubuntu(
                    textStyle: TextStyle(color: Colors.white)),
              ),
            ),
            backgroundColor: Colors.transparent,
            body: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                ListTile(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 0.05 * size.width,
                    vertical: 0.020 * size.height,
                  ),
                  leading: Icon(
                    Icons.share_rounded,
                    color: Colors.white,
                    size: 35,
                  ),
                  title: Text(
                    "Share link!",
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
                        color: Colors.white.withOpacity(0.35),
                      ),
                    ),
                  ),
                  onTap: () {
                    Share.share("text");
                  },
                ),
                FutureBuilder<List<Contact>?>(
                    future: contactViewerLauncher(
                      requestContactAccess:
                          PermissionManager.requestContactAccess,
                      size: size,
                    ),
                    builder: ((context, snapshot) {
                      print(snapshot.data);
                      if (!snapshot.hasData) {
                        return SizedBox(
                          width: size.width,
                          height: size.height,
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),
                        );
                      } else {
                        return SizedBox(
                          width: size.width,
                          height: size.height,
                          child: ContactViewer(
                            size: size,
                            contacts: snapshot.data!,
                          ),
                        );
                      }
                    }))
              ],
            ),
          ),
        ),
      ],
    );
  }
}
