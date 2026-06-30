import 'dart:async';

import 'package:auth_flow_app/features/auth/domain/repositories/email_auth_repository.dart';
import 'package:auth_flow_app/features/auth/presentation/bloc/email_auth/email_auth_event.dart';
import 'package:auth_flow_app/features/auth/presentation/bloc/email_auth/email_auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmailAuthBloc extends Bloc<EmailAuthEvent, EmailAuthState> {
  final EmailAuthRepository emailAuthRepository;

  EmailAuthBloc({required this.emailAuthRepository})
    : super(const EmailAuthInitial()) {
    on<SignUpWithEmailEvent>(_onSignUpWithEmail);
    on<SignInWithEmailEvent>(_onSignInWithEmail);
    on<SendPasswordResetOtpEvent>(_onResetPassword);
    on<VerifyPasswordSentOtpEvent>(_eventVerifyResetOtp);
    on<UpdatePasswordEvent>(_updatePassword);
    on<SendMagicLinkEvent>(_onSendMagicLink);
  }

  Future<void> _onSignUpWithEmail(
    SignUpWithEmailEvent event,
    Emitter<EmailAuthState> emit,
  ) async {
    emit(const EmailAuthLoading());

    final result = await emailAuthRepository.signUpWithEmail(
      email: event.email,
      password: event.password,
      name: event.name,
    );

    result.fold(
      (failure) => emit(EmailAuthError(message: failure.message)),
      (user) => emit(EmailAuthSuccess(user: user)),
    );
  }

  Future<void> _onSignInWithEmail(
    SignInWithEmailEvent event,
    Emitter<EmailAuthState> emit,
  ) async {
    emit(const EmailAuthLoading());

    final result = await emailAuthRepository.signInWithEmail(
      email: event.email,
      password: event.password,
    );

    result.fold(
      (failure) => emit(EmailAuthError(message: failure.message)),
      (user) => emit(EmailAuthSuccess(user: user)),
    );
  }

  Future<void> _onResetPassword(
    SendPasswordResetOtpEvent event,
    Emitter<EmailAuthState> emit,
  ) async {
    emit(const EmailAuthLoading());

    final result = await emailAuthRepository.resetPassword(email: event.email);

    result.fold(
      (failure) => emit(EmailAuthError(message: failure.message)),
      (_) => emit(
        PasswordResetOtpSent(
          message: 'reset code sent to ${event.email}',
          email: event.email,
        ),
      ),
    );
  }

  FutureOr<void> _eventVerifyResetOtp(
    VerifyPasswordSentOtpEvent event,
    Emitter<EmailAuthState> emit,
  ) async {
    emit(EmailAuthLoading());
    final response = await emailAuthRepository.verifyPasswordResetOtp(
      email: event.email,
      token: event.otp,
    );
    response.fold(
      (failure) {
        emit(EmailAuthError(message: failure.message));
      },
      (_) {
        emit(PasswordResetOtpVerify());
      },
    );
  }

  FutureOr<void> _updatePassword(
    UpdatePasswordEvent event,
    Emitter<EmailAuthState> emit,
  ) async {
    emit(EmailAuthLoading());
    final respose = await emailAuthRepository.updatePassword(
      password: event.password,
    );
    respose.fold(
      (left) {
        emit(EmailAuthError(message: left.message));
      },
      (right) {
        emit(PasswordUpdated(message: 'password updated succesfully'));
      },
    );
  }

  Future<void> _onSendMagicLink(
    SendMagicLinkEvent event,
    Emitter<EmailAuthState> emit,
  ) async {
    emit(const EmailAuthLoading());

    final result = await emailAuthRepository.sendMagicLink(email: event.email);

    result.fold(
      (failure) => emit(EmailAuthError(message: failure.message)),
      (_) => emit(
        PasswordResetOtpSent(
          message: 'Magic link sent to your email',
          email: event.email,
        ),
      ),
    );
  }
}
