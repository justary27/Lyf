import 'package:flutter/material.dart';
import 'package:lyf/src/global/globals.dart';

class ViewProfilePicturePage extends StatefulWidget {
  const ViewProfilePicturePage({Key? key}) : super(key: key);

  @override
  _ViewProfilePicturePageState createState() => _ViewProfilePicturePageState();
}

class _ViewProfilePicturePageState extends State<ViewProfilePicturePage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      width: size.width,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.arrow_back_ios_rounded,
            ),
            color: Colors.white,
          ),
          title: Text("${currentUser.userName}"),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.edit,
              ),
              color: Colors.white,
            ),
          ],
        ),
        extendBodyBehindAppBar: true,
        extendBody: true,
        body: Column(
          children: [
            Container(
              height: 0.25 * size.height,
              width: size.width,
              color: Colors.black,
            ),
            Stack(
              children: [
                Container(
                  height: 0.5 * size.height,
                  width: size.width,
                  color: Colors.black,
                ),
                Hero(
                  tag: 'pfp',
                  child: InteractiveViewer(
                    child: Container(
                      height: 0.5 * size.height,
                      width: size.width,
                      color: Colors.black,
                      child: Image(
                        image: AssetImage("assets/images/diary.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: 0.25 * size.height,
              width: size.width,
              color: Colors.black,
            )
          ],
        ),
      ),
    );
  }
}
