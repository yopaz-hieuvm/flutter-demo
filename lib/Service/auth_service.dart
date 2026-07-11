import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final supabase = Supabase.instance.client;

  String? get currentUserEmail => supabase.auth.currentUser?.email;
  Future<String?> signUp(String email, String password) async {
    try {
      final response = await supabase.auth.signUp(email: email, password: password);
      return response.user?.id;
    } catch (e) {
      throw Exception(e);
    }
  }
  Future<String?> signIn(String email, String password) async {
    try {
      final response = await supabase.auth.signInWithPassword(email: email, password: password);
      return response.user?.id;
    } catch (e) {
      throw Exception(e);
    }
  }
  Future<void> signOut() async {
    try {
      await supabase.auth.signOut();
    } catch (e) {
      throw Exception(e);
    }
  }
}