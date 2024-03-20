import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:zamzam/models/user.dart';

const storage = FlutterSecureStorage();

class AuthState {
  String token;
  User user;

  AuthState({
    required this.token,
    required this.user,
  });

  AuthState copyWith({String? token, User? user}) {
    return AuthState(
      token: token ?? this.token,
      user: user ?? this.user,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState?> {
  AuthNotifier() : super(null);

  void login(Map user, String token) async {
    await storage.write(key: 'token', value: token);
    state = AuthState(
      token: token,
      user: User.fromJson(user),
    );
  }

  void logout() async {
    await storage.delete(key: 'token');
    state = null;
  }

  void updateUser(Map user) {
    state = state!.copyWith(user: User.fromJson(user));
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState?>(
  (ref) => AuthNotifier(),
);
