import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lyf/src/global/globals.dart';
import 'package:lyf/src/services/http.dart';
import 'home/drawer.dart';
import 'home/home_page.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Future.delayed(
          const Duration(seconds: 1),
        );
        if (loginState == true) {
          return false;
        } else {
          return true;
        }
      },
      child: Stack(
        children: const [
          SideDrawer(),
          HomePage(),
        ],
      ),
    );
  }
}
