import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lyf/src/global/globals.dart';
import 'package:lyf/src/models/user_model.dart';
import 'package:lyf/src/routes/routing.dart';
import 'package:lyf/src/services/firebase/auth_service.dart';
import 'package:lyf/src/services/http.dart';
import 'package:lyf/src/services/user.dart';
import 'package:lyf/src/shared/lyf.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late http.Client logInClient;
  late http.Client profileClient;

  @override
  void initState() {
    logInClient = http.Client();
    profileClient = http.Client();
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
                                      fontSize: 60, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                        LoginForm(
                          size: size,
                          logInClient: logInClient,
                          profileClient: profileClient,
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
    logInClient.close();
    profileClient.close();
    super.dispose();
  }
}

class LoginForm extends StatefulWidget {
  final http.Client logInClient;
  final http.Client profileClient;
  final Size size;
  final BuildContext parentContext;
  const LoginForm(
      {Key? key,
      required this.size,
      required this.logInClient,
      required this.profileClient,
      required this.parentContext})
      : super(key: key);

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

  void getProfileData() async {
    var data = await widget.profileClient.get(
      Uri.parse(ApiEndpoints.getUserData(currentUser.userId)),
      headers: currentUser.authHeader(),
    );
    try {
      var dataValues = json.decode(data.body);
      print(dataValues);
      currentUser.username = dataValues['username'];
      UserCredentials.setUsername(currentUser.username);
    } catch (e) {
      print(e);
    }
  }

  void logIn(http.Client logInClient, String email, String password) async {
    SnackBar snackBar = const SnackBar(
      content: Text("Logging in ..."),
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
      await LyfUser.logIn(logInClient, creds);
      await FireAuth.logIn(creds: creds!);
      print(loginState);
      if (loginState == false) {
        ScaffoldMessenger.of(widget.parentContext).showSnackBar(eSnackBar);
      } else {
        RouteManager.navigateToHome(context);
      }
    } catch (e) {
      loginState = false;
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
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    logIn(widget.logInClient, emailController.text,
                        passwordController.text);
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
