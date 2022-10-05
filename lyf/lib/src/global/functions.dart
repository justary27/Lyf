import '../models/user_model.dart';
import '../services/firebase/auth_service.dart';
import '../services/init_service.dart';
import '../services/user.dart';
import '../utils/api/user_api.dart';
import 'variables.dart';

Future<void> login(Map<String, String?>? creds) async {
  if (creds == null) {
    loginState = false;
  } else {
    try {
      LyfUser? authenticatedUser = await UserApiClient.logIn(creds);
      if (authenticatedUser != null) {
        currentUser = authenticatedUser;
        UserCredentials.setCredentials(
          currentUser.email,
          currentUser.password,
          currentUser.userName,
        );
        await FireAuth.logIn(creds: creds);
        loginState = true;
      }
    } catch (e) {
      loginState = false;
    }
  }
}

Future<Map<String, String?>?> getCredentials() async {
  Map<String, String?>? response = await UserCredentials.getCredentials();
  if (response != null) {
    return response;
  } else {
    return null;
  }
}

Future<void> initServiceProvider() async {
  await InitService.initializeServices();
}
