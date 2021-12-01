import 'package:flutter/material.dart';
import 'package:lyf/src/screens/diary/diary.dart';
import 'package:lyf/src/screens/drawer.dart';
import 'package:lyf/src/screens/home.dart';
import 'package:lyf/src/screens/todo/todo.dart';
import 'package:lyf/src/screens/todo/view_todo.dart';

class RouteManager {
  static const String homePage = "/";
  static const String drawerPage = "/drawer";
  static const String todoPage = "/todo";
  static const String diaryPage = "/diary";
  static const String viewTodoPage = "/todo/view";
  static String currentRoute = "/home";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homePage:
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const Home(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = Offset(1.0, 0);
              const end = Offset.zero;
              const curve = Curves.ease;

              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 750));
      case drawerPage:
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const SideDrawer(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = Offset(-1.0, 0);
              const end = Offset.zero;
              const curve = Curves.ease;

              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 750));
      case todoPage:
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const TodoPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = 0.0;
              const end = 1.0;
              const curve = Curves.ease;

              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

              return FadeTransition(
                opacity: animation.drive(tween),
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 750));
      case diaryPage:
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const DiaryPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = 0.0;
              const end = 1.0;
              const curve = Curves.ease;

              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

              return FadeTransition(
                opacity: animation.drive(tween),
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 750));
      case viewTodoPage:
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const ViewTodoPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = Offset(1.0, 0);
              const end = Offset.zero;
              const curve = Curves.ease;

              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 750));
      default:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const Home(),
        );
    }
  }

  static void navigateToHome(BuildContext context) {
    Navigator.of(context).pushNamed(RouteManager.homePage);
    RouteManager.currentRoute = RouteManager.homePage;
  }

  static void navigateToDrawer(BuildContext context) {
    Navigator.of(context).pushNamed(RouteManager.drawerPage);
    RouteManager.currentRoute = "/drawer";
  }

  static void navigateToTodo(BuildContext context) {
    Navigator.of(context).pushNamed(RouteManager.todoPage);
    RouteManager.currentRoute = RouteManager.todoPage;
  }

  static void navigateToDiary(BuildContext context) {
    Navigator.of(context).pushNamed(RouteManager.diaryPage);
    RouteManager.currentRoute = RouteManager.diaryPage;
  }

  static void navigateToViewTodo(BuildContext context) {
    Navigator.of(context).pushNamed(RouteManager.viewTodoPage);
    RouteManager.currentRoute = RouteManager.viewTodoPage;
  }
}
