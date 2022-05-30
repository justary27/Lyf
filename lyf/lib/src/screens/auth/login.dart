import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lyf/src/global/globals.dart';
import 'package:lyf/src/models/user_model.dart';
import 'package:lyf/src/routes/routing.dart';
import 'package:lyf/src/services/firebase/auth_service.dart';
import 'package:lyf/src/services/user.dart';
import 'package:lyf/src/shared/lyf.dart';

import '../../utils/api/user_api.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
              colors: [
                Colors.grey.shade700,
                Colors.grey.shade900,
                Colors.black
              ],
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 0.1 * size.height,
                width: size.width,
              ),
              SizedBox(
                height: 0.9 * size.height,
                width: size.width,
                child: const Lyf(),
              ),
            ],
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 0.1 * size.height,
                  width: size.width,
                ),
                SizedBox(
                  width: size.width,
                  height: 0.9 * size.height,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Material(
                          color: Colors.transparent,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                "assets/images/lyf.svg",
                                width: 40,
                                color: Colors.white,
                              ),
                              Text(
                                "Lyf",
                                style: GoogleFonts.caveat(
                                  textStyle: TextStyle(
                                    fontSize: 60,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        LoginForm(
                          size: size,
                          parentContext: context,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class LoginForm extends StatefulWidget {
  final Size size;
  final BuildContext parentContext;
  const LoginForm({
    Key? key,
    required this.size,
    required this.parentContext,
  }) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  Future<void> logIn(String email, String password) async {
    SnackBar snackBar = SnackBar(
      padding: EdgeInsets.zero,
      dismissDirection: DismissDirection.startToEnd,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.white,
      duration: const Duration(seconds: 20),
      content: ListTile(
        leading: Transform.scale(
          scale: 0.5,
          child: CircularProgressIndicator(
            color: Colors.grey.shade700,
          ),
        ),
        title: Text(
          "Logging in ...",
          style: GoogleFonts.aBeeZee(
            textStyle: TextStyle(
              color: Colors.grey.shade700,
            ),
          ),
        ),
      ),
      // content: Text("Logging in ..."),
    );
    SnackBar eSnackBar = const SnackBar(
      content: Text("Invalid credentials, try again with correct ones!"),
    );

    ScaffoldMessenger.of(widget.parentContext).showSnackBar(snackBar);
    try {
      creds = {
        'email': email,
        'password': password,
      };
      LyfUser? authenticatedUser = await UserApiClient.logIn(creds!);
      if (authenticatedUser != null) {
        currentUser = authenticatedUser;
        UserCredentials.setCredentials(
          currentUser.email,
          currentUser.password,
          currentUser.userName,
        );
        await FireAuth.logIn(creds: creds!);
        loginState = true;
      }
      if (loginState == false) {
        ScaffoldMessenger.of(widget.parentContext).hideCurrentSnackBar();
        ScaffoldMessenger.of(widget.parentContext).showSnackBar(eSnackBar);
      } else {
        ScaffoldMessenger.of(widget.parentContext).hideCurrentSnackBar();
        RouteManager.navigateToHome(context);
      }
    } catch (e) {
      loginState = false;
      ScaffoldMessenger.of(widget.parentContext).hideCurrentSnackBar();
      ScaffoldMessenger.of(widget.parentContext).showSnackBar(eSnackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = widget.size;
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Container(
            width: 0.75 * size.width,
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 8.0),
                  child: Text("Email"),
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "This field is required";
                    } else {
                      if (!value.contains('@')) {
                        return "Please enter a valid email.";
                      }
                    }
                  },
                  style: GoogleFonts.ubuntu(
                    textStyle: const TextStyle(color: Colors.white),
                  ),
                  controller: emailController,
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    focusColor: Colors.white,
                    hoverColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.white.withOpacity(0.5), width: 1.0),
                    ),
                    fillColor: Colors.white.withOpacity(0.35),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 0.75 * size.width,
            padding: EdgeInsets.symmetric(
              vertical: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 8.0),
                  child: Text("Password"),
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "This field is required";
                    }
                  },
                  style: GoogleFonts.ubuntu(
                    textStyle: const TextStyle(color: Colors.white),
                  ),
                  obscureText: true,
                  controller: passwordController,
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.white.withOpacity(0.5), width: 1.0),
                    ),
                    fillColor: Colors.white.withOpacity(0.35),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: SizedBox(
              width: 0.75 * size.width,
              height: 50,
              child: TextButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await logIn(emailController.text, passwordController.text);
                  }
                },
                child: Text(
                  "Log In",
                  style: GoogleFonts.ubuntu(
                    textStyle:
                        TextStyle(color: Colors.grey.shade700, fontSize: 20),
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don't have an account?",
              ),
              TextButton(
                onPressed: () {
                  RouteManager.navigateToSignUp(context);
                },
                child: Text("Sign Up"),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }
}
