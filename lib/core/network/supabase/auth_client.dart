import 'package:supabase_flutter/supabase_flutter.dart';

/*
import 'package:gotrue/src/types/auth_response.dart';
*/
abstract class AuthClient {
  Future<AuthResponse> signUp({
    required String email,
    required String password,
    required String name,
  });
  Future<AuthResponse> signIn(String email, String password);
  Future<void> resetPasswordForEmail({required String email});
  Future<AuthResponse> verifyPasswordResetOtp(String email, String otp);
  Future<UserResponse> updatePassword(String password);
}
