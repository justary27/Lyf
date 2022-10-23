import 'package:firebase_auth/firebase_auth.dart';

class FireAuth {
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static late UserCredential userCredential;

  static Future<int> logIn({
    required Map<String, String?> creds,
  }) async {
    try {
      userCredential = await auth.signInWithEmailAndPassword(
        email: creds['email']!,
        password: creds['password']!,
      );
      return 0;
    } catch (e) {
      return -1;
    }
  }

  static Future<int> signUp({
    required Map<String, String?> creds,
  }) async {
    try {
      userCredential = await auth.createUserWithEmailAndPassword(
        email: creds['email']!,
        password: creds['password']!,
      );
      return 0;
    } catch (e) {
      return -1;
    }
  }

  static Future<int> logOut() async {
    try {
      auth.signOut();
      return 0;
    } catch (e) {
      print(e);
      return -1;
    }
  }
}
