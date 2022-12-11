import 'package:flutter/material.dart';
import 'drawer.dart';
import 'home_screen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: const [
        SideDrawer(),
        HomeScreen(),
      ],
    );
  }
}
