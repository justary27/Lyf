import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../global/variables.dart';
import '../../models/user_model.dart';
import '../../services/firebase/auth_service.dart';
import '../../services/user.dart';
import '../../utils/api/user_api.dart';
import '../../utils/enums/auth_type.dart';

final authStateNotifier = StateNotifierProvider<AuthNotifier, AuthType>((ref) {
  return AuthNotifier(ref.read);
});

class AuthNotifier extends StateNotifier<AuthType> {
  final Reader reader;
  AuthNotifier(this.reader, [AuthType? state])
      : super(state ?? AuthType.unauthenticated);

  Future<void> login(Map<String, String?> userCreds) async {
    if (creds == null) {
      loginState = false;
    } else {
      try {
        LyfUser? authenticatedUser = await UserApiClient.logIn(userCreds);
        await FireAuth.logIn(creds: userCreds);
        if (authenticatedUser != null) {
          currentUser = authenticatedUser;
          UserCredentials.setCredentials(
            currentUser.email,
            currentUser.password,
            currentUser.userName,
          );
          state = AuthType.authenticated;
          loginState = true;
        }
      } catch (e) {
        loginState = false;
        state = AuthType.error;
      }
    }
  }

  Future<void> signup(Map<String, String?> userCreds) async {}
  Future<void> deactivateAccount() async {}
  Future<void> deleteAccount() async {}
}
