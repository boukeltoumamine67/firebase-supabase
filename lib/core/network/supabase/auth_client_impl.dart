import 'package:auth_flow_app/core/network/supabase/auth_client.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthClientImpl implements AuthClient {
  final GoTrueClient
  client; // this is the same with Supabase.instance.client.auth
  AuthClientImpl({required this.client});
  @override
  Future<AuthResponse> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    return await client.signUp(
      email: email,
      password: password,
      data: {'name': name},
    );
    //return await Supabase.instance.client.auth.signUp(email: email, password: password);
  }

  @override
  Future<AuthResponse> signIn(String email, String password) async {
    return await client.signInWithPassword(password: password, email: email);
  }

  @override
  Future<void> resetPasswordForEmail({required String email}) async {
    return await client.resetPasswordForEmail(email);
  }

  @override
  Future<AuthResponse> verifyPasswordResetOtp({
    required String email,
    required String otp,
  }) async {
    return await client.verifyOTP(
      type: OtpType.recovery,
      email: email,
      token: otp,
    );
  }

  @override
  Future<UserResponse> updatePassword({required String password}) async {
    return await client.updateUser(UserAttributes(password: password));
  }
}
