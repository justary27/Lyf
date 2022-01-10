import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lyf/src/global/globals.dart';
import 'package:lyf/src/models/user_model.dart';
import 'package:lyf/src/routes/routing.dart';
import 'package:lyf/src/services/http.dart';
import 'package:lyf/src/shared/lyf.dart';
import 'package:http/http.dart' as http;

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late http.Client signUpClient;
  @override
  void initState() {
    signUpClient = http.Client();
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
                          client: signUpClient,
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
    signUpClient.close();
    super.dispose();
  }
}

class LoginForm extends StatefulWidget {
  final Size size;
  final http.Client client;
  final BuildContext parentContext;
  const LoginForm(
      {Key? key,
      required this.size,
      required this.client,
      required this.parentContext})
      : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController emailController;
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  late TextEditingController cpasswordController;

  @override
  void initState() {
    emailController = TextEditingController();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    cpasswordController = TextEditingController();
    super.initState();
  }

  void signUp(http.Client signUpClient, String email, String username,
      String password, String cpassword) async {
    // SnackBar snackBar = const SnackBar(
    //   content: Text("Signing up ..."),
    //   duration: Duration(seconds: 2),
    // );
    SnackBar snackBar1 = const SnackBar(
      content: Text("Invalid credentials, try again with correct ones!"),
    );

    // ScaffoldMessenger.of(widget.parentContext).showSnackBar(snackBar);
    http.Response response;
    try {
      response = await signUpClient.post(Uri.parse(ApiEndpoints.signUp), body: {
        'email': email,
        'username': username,
        'password': password,
      });
      if (response.statusCode == 400) {
        print(response.body);
        setState(() {
          loginState = false;
        });
        try {
          if (json.decode(response.body) == ApiEndpoints.signUpEmailError) {
            SnackBar snackBare = const SnackBar(
              content: Text("Email already taken, try a different one!"),
            );
            ScaffoldMessenger.of(widget.parentContext).showSnackBar(snackBare);
          } else if (response.body == ApiEndpoints.signUpUsernameError) {
            print(response.body);
            SnackBar snackBaru = const SnackBar(
              content: Text("Username already taken, try a different one!"),
            );
            ScaffoldMessenger.of(widget.parentContext).showSnackBar(snackBaru);
          }
        } catch (e) {
          print(e);
        }
      } else if (response.statusCode == 200) {
        setState(() {
          loginState = true;
          currentUser = LyfUser();
          currentUser.email = email;
          currentUser.password = password;
          Map body = json.decode(response.body);
          print(body);
          try {
            currentUser.userId = body['userId'];
            currentUser.token = body['token'];
            if (body['isActive'] == 'True') {
              currentUser.isActive = true;
            } else {
              currentUser.isActive = false;
            }
          } catch (e) {
            print(e);
          }
        });
        if (loginState == true) {
          RouteManager.navigateToHome(context);
        } else {
          ScaffoldMessenger.of(widget.parentContext).showSnackBar(snackBar1);
        }
      }
    } catch (e) {
      setState(() {
        loginState = false;
      });
      ScaffoldMessenger.of(widget.parentContext).showSnackBar(snackBar1);
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
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 8.0),
                  child: Text("Email"),
                ),
                SizedBox(
                  height: 50,
                  child: TextFormField(
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
                    cursorColor: Colors.white,
                    controller: emailController,
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
                ),
              ],
            ),
          ),
          Container(
            width: 0.75 * size.width,
            padding: EdgeInsets.symmetric(
              vertical: 7.5,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 8.0),
                  child: Text("Username"),
                ),
                SizedBox(
                  height: 50,
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "This field is required";
                      }
                    },
                    style: GoogleFonts.ubuntu(
                      textStyle: const TextStyle(color: Colors.white),
                    ),
                    cursorColor: Colors.white,
                    controller: usernameController,
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
                ),
              ],
            ),
          ),
          Container(
            width: 0.75 * size.width,
            padding: EdgeInsets.symmetric(
              vertical: 7.5,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 8.0),
                  child: Text("Password"),
                ),
                SizedBox(
                  height: 50,
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "This field is required";
                      }
                    },
                    style: GoogleFonts.ubuntu(
                      textStyle: const TextStyle(color: Colors.white),
                    ),
                    cursorColor: Colors.white,
                    controller: passwordController,
                    obscureText: true,
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
                ),
              ],
            ),
          ),
          Container(
            width: 0.75 * size.width,
            padding: EdgeInsets.symmetric(
              vertical: 7.5,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 8.0),
                  child: Text("Confirm Password"),
                ),
                SizedBox(
                  height: 50,
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "This field is required";
                      } else {
                        if (passwordController.text !=
                            cpasswordController.text) {
                          return "Passwords don't match";
                        }
                      }
                    },
                    style: GoogleFonts.ubuntu(
                      textStyle: const TextStyle(color: Colors.white),
                    ),
                    cursorColor: Colors.white,
                    controller: cpasswordController,
                    obscureText: true,
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
                    signUp(
                        widget.client,
                        emailController.text,
                        usernameController.text,
                        passwordController.text,
                        cpasswordController.text);
                  }
                },
                child: Text(
                  "Sign Up",
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
                "Already have an account?",
              ),
              TextButton(
                onPressed: () {
                  RouteManager.navigateToLogin(context);
                },
                child: Text("Log In"),
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    cpasswordController.dispose();
    super.dispose();
  }
}
