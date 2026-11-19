import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  static final supabase = Supabase.instance.client;

  static Future<AuthResponse> register({
    required String name,
    required String email,
    required String password,
  }) async {
    return await supabase.auth.signUp(
      email: email.trim(),
      password: password,
      data: {'full_name': name.trim()},
    );
  }

  static Future<AuthResponse> login({
    required String email,
    required String password,
  }) async {
    return await supabase.auth.signInWithPassword(
      email: email.trim(),
      password: password,
    );
  }

  static Future<bool> loginWithGoogle() async {
    return await supabase.auth.signInWithOAuth(
      OAuthProvider.google,
      redirectTo: 'http://localhost:8080',
    );
  }

  static Future<void> forgotPassword(String email) async {
    await supabase.auth.resetPasswordForEmail(email.trim());
  }

  static Future<void> logout() async {
    await supabase.auth.signOut();
  }
}
