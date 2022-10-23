import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lyf/src/global/variables.dart';
import 'package:lyf/src/models/user_model.dart';
import 'package:lyf/src/routes/routing.dart';
import 'package:lyf/src/services/firebase/auth_service.dart';
import 'package:lyf/src/shared/lyf.dart';
import 'package:lyf/src/utils/handlers/route_handler.dart';

import '../../services/user.dart';
import '../../state/theme/theme_state.dart';
import '../../utils/api/user_api.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
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
              colors: ref
                  .read(themeNotifier.notifier)
                  .getCurrentState()
                  .gradientColors,
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
                child: Lyf(parentContext: context),
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
                                  textStyle: const TextStyle(
                                    fontSize: 60,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SignUpForm(
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

class SignUpForm extends StatefulWidget {
  final Size size;
  final BuildContext parentContext;
  const SignUpForm({Key? key, required this.size, required this.parentContext})
      : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
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

  Future<void> signUp(
      String email, String username, String password, String cpassword) async {
    // SnackBar snackBar = const SnackBar(
    //   content: Text("Signing up ..."),
    //   duration: Duration(seconds: 2),
    // );
    SnackBar snackBar1 = const SnackBar(
      content: Text("Invalid credentials, try again with correct ones!"),
    );
    // ScaffoldMessenger.of(widget.parentContext).showSnackBar(snackBar);
    try {
      Map<String, String> signUpCreds = {
        'email': email,
        'username': username,
        'password': password,
      };
      LyfUser? authenticatedNewUser = await UserApiClient.signUp(signUpCreds);
      if (authenticatedNewUser != null) {
        currentUser = authenticatedNewUser;
        UserCredentials.setCredentials(
          currentUser.email,
          currentUser.password,
          currentUser.userName,
        );
        await FireAuth.signUp(creds: signUpCreds);
        loginState = true;
      }
      if (loginState == true) {
        goRouter.push(RouteHandler.home);
      } else {
        ScaffoldMessenger.of(widget.parentContext).showSnackBar(snackBar1);
      }
    } catch (e) {
      print(e);
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
                      return null;
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
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await signUp(
                      emailController.text,
                      usernameController.text,
                      passwordController.text,
                      cpasswordController.text,
                    );
                  }
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                child: Text(
                  "Sign Up",
                  style: GoogleFonts.ubuntu(
                    textStyle:
                        TextStyle(color: Colors.grey.shade700, fontSize: 20),
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
                  goRouter.push(RouteHandler.login);
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
