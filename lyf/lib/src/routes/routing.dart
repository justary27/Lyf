import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lyf/src/models/diary_model.dart';
import 'package:lyf/src/models/todo_model.dart';
import 'package:lyf/src/screens/error/error_screen.dart';
import 'package:lyf/src/screens/settings/language_screen.dart';
import 'package:lyf/src/shared/viewers/web_viewer.dart';
import 'package:lyf/src/utils/helpers/screen_helper.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/signup_screen.dart';
import '../screens/auth/auth_screen.dart';
import '../screens/diary/diary.dart';
import '../screens/diary/view_entry.dart';
import '../screens/diary/add_entry.dart';
import '../screens/home/home.dart';
import '../screens/home/view_pfp.dart';
import '../screens/settings/invite.dart';
import '../screens/settings/settings.dart';
import '../screens/settings/account_screen.dart';
import '../screens/settings/view_themes.dart';
import '../screens/todo/add_todo_screen.dart';
import '../screens/todo/todo_screen.dart';
import '../screens/todo/view_todo_screen.dart';
import '../screens/settings/notifications.dart';
import '../screens/splash.dart';

var goRouter = GoRouter(
  initialLocation: "/splash",
  routes: [
    GoRoute(
      path: "/splash",
      pageBuilder: (context, pageBuilder) {
        return const MaterialPage(
          child: SplashScreen(),
        );
      },
    ),
    GoRoute(
      path: "/auth",
      pageBuilder: (context, pageBuilder) {
        return CustomTransitionPage(
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
          child: const AuthScreen(),
        );
      },
    ),
    GoRoute(
      path: "/login",
      pageBuilder: (context, pageBuilder) {
        return CustomTransitionPage(
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
          child: const LoginScreen(),
        );
      },
    ),
    GoRoute(
      path: "/signup",
      pageBuilder: (context, pageBuilder) {
        return CustomTransitionPage(
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
          child: const SignUpScreen(),
        );
      },
    ),
    GoRoute(
      path: "/",
      pageBuilder: (context, pageBuilder) {
        return CustomTransitionPage(
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
          child: const Home(),
        );
      },
    ),
    GoRoute(
      path: "/todo",
      pageBuilder: (context, pageBuilder) {
        return CustomTransitionPage(
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
          child: const TodoScreen(),
        );
      },
      routes: [
        GoRoute(
          path: "add",
          pageBuilder: (context, pageBuilder) {
            return CustomTransitionPage(
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
              transitionDuration: const Duration(milliseconds: 750),
              child: const AddTodoScreen(),
            );
          },
        ),
        GoRoute(
          path: ":id",
          pageBuilder: (context, pageBuilder) {
            return CustomTransitionPage(
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
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
              child: ViewTodoScreen(
                todo: pageBuilder.extra as Todo,
              ),
            );
          },
        ),
      ],
    ),
    GoRoute(
      path: "/diary",
      pageBuilder: (context, pageBuilder) {
        return CustomTransitionPage(
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
          child: const DiaryPage(),
        );
      },
      routes: [
        GoRoute(
          path: "add",
          pageBuilder: (context, pageBuilder) {
            return CustomTransitionPage(
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
              transitionDuration: const Duration(milliseconds: 750),
              child: const AddDiaryEntryPage(),
            );
          },
        ),
        GoRoute(
          path: ":id",
          pageBuilder: (context, pageBuilder) {
            return CustomTransitionPage(
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
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
              child: ViewDiaryEntryPage(
                entry: pageBuilder.extra as DiaryEntry,
                size: logicalScreenSize,
              ),
            );
          },
        ),
      ],
    ),
    GoRoute(
      path: "/avatar",
      pageBuilder: (context, pageBuilder) {
        return CustomTransitionPage(
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
          child: const ViewProfilePicturePage(),
        );
      },
    ),
    GoRoute(
      path: "/settings",
      pageBuilder: (context, pageBuilder) {
        return CustomTransitionPage(
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
          child: const SettingsPage(),
        );
      },
      routes: [
        GoRoute(
          path: "account",
          pageBuilder: (context, pageBuilder) {
            return CustomTransitionPage(
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
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
              child: const AccountSettingsPage(),
            );
          },
        ),
        GoRoute(
          path: "data",
          pageBuilder: (context, pageBuilder) {
            return CustomTransitionPage(
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
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
              child: const AccountSettingsPage(),
            );
          },
        ),
        GoRoute(
          path: "help",
          pageBuilder: (context, pageBuilder) {
            return CustomTransitionPage(
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
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
              child: WebViewer(initialUrl: pageBuilder.extra as String),
            );
          },
        ),
        GoRoute(
          path: "notification",
          pageBuilder: (context, pageBuilder) {
            return CustomTransitionPage(
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
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
              child: const NotifactionSettingsPage(),
            );
          },
        ),
        GoRoute(
          path: "themes",
          pageBuilder: (context, pageBuilder) {
            return CustomTransitionPage(
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
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
              child: const ThemeSettingsPage(),
            );
          },
        ),
        GoRoute(
          path: "language",
          pageBuilder: (context, pageBuilder) {
            return CustomTransitionPage(
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
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
              child: const LanguageSettingsScreen(),
            );
          },
        ),
        GoRoute(
          path: "invite",
          pageBuilder: (context, pageBuilder) {
            return CustomTransitionPage(
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
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
              child: const InviteSettingsPage(),
            );
          },
        ),
      ],
    ),
  ],
  errorPageBuilder: (context, pageBuilder) {
    return CustomTransitionPage(
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
      child: const ErrorScreen(),
    );
  },
);
