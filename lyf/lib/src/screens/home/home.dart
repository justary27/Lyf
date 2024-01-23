import 'package:flutter/material.dart';
import 'drawer.dart';
import 'home_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        SideDrawer(),
        HomeScreen(),
      ],
    );
  }
}
