import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  static final SupabaseClient supabase = Supabase.instance.client;

  // LOGIN EMAIL
  static Future<AuthResponse> login({
    required String email,
    required String password,
  }) async {
    return await supabase.auth.signInWithPassword(
      email: email.trim(),
      password: password,
    );
  }

  // REGISTER
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

  // GOOGLE LOGIN VIA SUPABASE OAUTH
  static Future<bool> loginWithGoogle() async {
    return await supabase.auth.signInWithOAuth(OAuthProvider.google);
  }

  // FORGOT PASSWORD
  static Future<void> forgotPassword(String email) async {
    await supabase.auth.resetPasswordForEmail(email.trim());
  }

  // LOGOUT
  static Future<void> logout() async {
    await supabase.auth.signOut();
  }

  // CURRENT USER
  static User? get currentUser {
    return supabase.auth.currentUser;
  }

  // CEK STATUS LOGIN
  static bool get isLoggedIn {
    return supabase.auth.currentSession != null;
  }
}
