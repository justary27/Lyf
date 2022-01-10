import 'package:flutter/material.dart';
import 'package:lyf/src/models/diary_model.dart';
import 'package:lyf/src/models/todo_model.dart';
import 'package:lyf/src/screens/auth/login.dart';
import 'package:lyf/src/screens/auth/signup.dart';
import 'package:lyf/src/screens/auth/welcome.dart';
import 'package:lyf/src/screens/diary/diary.dart';
import 'package:lyf/src/screens/diary/view_entry.dart';
import 'package:lyf/src/screens/diary/add_entry.dart';
import 'package:lyf/src/screens/home.dart';
import 'package:lyf/src/screens/home/view_pfp.dart';
import 'package:lyf/src/screens/settings/invite.dart';
import 'package:lyf/src/screens/settings/settings.dart';
import 'package:lyf/src/screens/settings/view_account.dart';
import 'package:lyf/src/screens/settings/view_themes.dart';
import 'package:lyf/src/screens/todo/add_todo.dart';
import 'package:lyf/src/screens/todo/todo.dart';
import 'package:lyf/src/screens/todo/view_todo.dart';
import 'package:lyf/src/screens/settings/notifications.dart';

class RouteManager {
  static const String homePage = "/home";
  static const String welcomePage = "/welcome";
  static const String signUpPage = "/signup";
  static const String loginPage = "/login";
  static const String todoPage = "/todo";
  static const String diaryPage = "/diary";
  static const String viewTodoPage = "/todo/view";
  static const String addTodoPage = "/todo/add";
  static const String viewDiaryEntryPage = "/diary/view";
  static const String addDiaryEntryPage = "/diary/add";
  static const String viewPfpPage = "/pfp";
  static const String settingsPage = "/settings";
  static const String accountSettingsPage = "/settings/account";
  static const String themeSettingsPage = "/settings/themes";
  static const String dataSettingsPage = "/settings/data";
  static const String notificationSettingsPage = "/settings/notifications";
  static const String inviteSettingsPage = "/settings/invite";

  static String currentRoute = "/home";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case welcomePage:
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const WelcomePage(),
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

      case signUpPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const SignUpPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
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
          transitionDuration: const Duration(milliseconds: 750),
        );

      case loginPage:
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const LoginPage(),
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

      case homePage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const Home(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween = Tween(begin: begin, end: end).chain(
              CurveTween(curve: curve),
            );

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 750),
        );
      case todoPage:
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const TodoPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = 0.0;
              const end = 1.0;
              const curve = Curves.ease;

              var tween = Tween(begin: begin, end: end).chain(
                CurveTween(curve: curve),
              );

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
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = 0.0;
            const end = 1.0;
            const curve = Curves.ease;

            var tween = Tween(begin: begin, end: end).chain(
              CurveTween(curve: curve),
            );

            return FadeTransition(
              opacity: animation.drive(tween),
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 750),
        );
      case viewTodoPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            if (arguments is Todo) {
              return ViewTodoPage(todo: arguments);
            }
            return Home();
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween = Tween(begin: begin, end: end).chain(
              CurveTween(curve: curve),
            );

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 750),
        );
      case viewPfpPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const ViewProfilePicturePage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween = Tween(begin: begin, end: end).chain(
              CurveTween(curve: curve),
            );

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 750),
        );
      case settingsPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const SettingsPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(-1.0, 0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween = Tween(begin: begin, end: end).chain(
              CurveTween(curve: curve),
            );

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 750),
        );
      case accountSettingsPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const AccountSettingsPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween = Tween(begin: begin, end: end).chain(
              CurveTween(curve: curve),
            );

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 750),
        );
      case themeSettingsPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const ThemeSettingsPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween = Tween(begin: begin, end: end).chain(
              CurveTween(curve: curve),
            );

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 750),
        );
      case notificationSettingsPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const NotifactionSettingsPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween = Tween(begin: begin, end: end).chain(
              CurveTween(curve: curve),
            );

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 750),
        );
      case inviteSettingsPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const InviteSettingsPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween = Tween(begin: begin, end: end).chain(
              CurveTween(curve: curve),
            );

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 750),
        );

      case viewDiaryEntryPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            if (arguments is DiaryEntry) {
              return ViewDiaryEntryPage(entry: arguments);
            }
            return Home();
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween = Tween(begin: begin, end: end).chain(
              CurveTween(curve: curve),
            );

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 750),
        );
      case addDiaryEntryPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const AddDiaryEntryPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = 0.0;
            const end = 1.0;
            const curve = Curves.ease;

            var tween = Tween(begin: begin, end: end).chain(
              CurveTween(curve: curve),
            );

            return FadeTransition(
              opacity: animation.drive(tween),
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 750),
        );
      case addTodoPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const AddTodoPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = 0.0;
            const end = 1.0;
            const curve = Curves.ease;

            var tween = Tween(begin: begin, end: end).chain(
              CurveTween(curve: curve),
            );

            return FadeTransition(
              opacity: animation.drive(tween),
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 750),
        );

      default:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const Home(),
        );
    }
  }

  static void navigateToWelcome(BuildContext context) {
    Navigator.of(context).pushNamed(RouteManager.welcomePage);
    RouteManager.currentRoute = RouteManager.welcomePage;
  }

  static void navigateToSignUp(BuildContext context) {
    Navigator.of(context).pushNamed(RouteManager.signUpPage);
    RouteManager.currentRoute = RouteManager.signUpPage;
  }

  static void navigateToLogin(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      RouteManager.loginPage,
      ModalRoute.withName('/welcome'),
    );
    RouteManager.currentRoute = RouteManager.loginPage;
  }

  static void navigateToHome(BuildContext context) {
    Navigator.of(context).pushNamed(RouteManager.homePage);
    RouteManager.currentRoute = RouteManager.homePage;
  }

  static void navigateToTodo(BuildContext context) {
    Navigator.of(context).pushNamed(RouteManager.todoPage);
    RouteManager.currentRoute = RouteManager.todoPage;
  }

  static void navigateToDiary(BuildContext context) {
    Navigator.of(context).pushNamed(RouteManager.diaryPage);
    RouteManager.currentRoute = RouteManager.diaryPage;
  }

  static void navigateToViewTodo(BuildContext context, Todo todo) {
    Navigator.of(context).pushNamed(RouteManager.viewTodoPage, arguments: todo);
    RouteManager.currentRoute = RouteManager.viewTodoPage;
  }

  static void navigateToViewDiaryEntry(BuildContext context, DiaryEntry entry) {
    Navigator.of(context)
        .pushNamed(RouteManager.viewDiaryEntryPage, arguments: entry);
    RouteManager.currentRoute = RouteManager.viewDiaryEntryPage;
  }

  static void navigateToAddDiaryEntry(BuildContext context) {
    Navigator.of(context).pushNamed(RouteManager.addDiaryEntryPage);
    RouteManager.currentRoute = RouteManager.addDiaryEntryPage;
  }

  static void navigateToAddTodo(BuildContext context) {
    Navigator.of(context).pushNamed(RouteManager.addTodoPage);
    RouteManager.currentRoute = RouteManager.addTodoPage;
  }

  static void navigateToProfilePicture(BuildContext context) {
    Navigator.of(context).pushNamed(RouteManager.viewPfpPage);
    RouteManager.currentRoute = RouteManager.viewPfpPage;
  }

  static void navigateToSettings(BuildContext context) {
    Navigator.of(context).pushNamed(RouteManager.settingsPage);
    RouteManager.currentRoute = RouteManager.settingsPage;
  }

  static void navigateToAccountSettings(BuildContext context) {
    Navigator.of(context).pushNamed(RouteManager.accountSettingsPage);
    RouteManager.currentRoute = RouteManager.accountSettingsPage;
  }

  static void navigateToThemeSettings(BuildContext context) {
    Navigator.of(context).pushNamed(RouteManager.themeSettingsPage);
    RouteManager.currentRoute = RouteManager.themeSettingsPage;
  }

  static void navigateToNotificationSettings(BuildContext context) {
    Navigator.of(context).pushNamed(RouteManager.notificationSettingsPage);
    RouteManager.currentRoute = RouteManager.notificationSettingsPage;
  }

  static void navigateToInviteSettings(BuildContext context) {
    Navigator.of(context).pushNamed(RouteManager.inviteSettingsPage);
    RouteManager.currentRoute = RouteManager.inviteSettingsPage;
  }
}
