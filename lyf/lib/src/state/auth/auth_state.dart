import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../utils/enums/auth_type.dart';

final authStateNotifier = StateNotifierProvider<AuthNotifier, AuthType>((ref) {
  return AuthNotifier(ref.read);
});

class AuthNotifier extends StateNotifier<AuthType> {
  final Reader reader;
  AuthNotifier(this.reader, [AuthType? state])
      : super(state ?? AuthType.unauthenticated);

  Future<void> login(Map<String, String?> userCreds) async {}
  Future<void> signup(Map<String, String?> userCreds) async {}
  Future<void> deactivateAccount() async {}
  Future<void> deleteAccount() async {}
}
