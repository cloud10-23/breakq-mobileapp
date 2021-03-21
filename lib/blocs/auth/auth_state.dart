part of 'auth_bloc.dart';

@immutable
abstract class AuthState {
  @override
  String toString() => '$runtimeType';
}

class InitialAuthState extends AuthState {}

/// Existing User when they login, to directly complete login process
class LoginSuccessAuthState extends AuthState {}

/// For showing phone number verification after social login
class LinkPhoneAuthState extends AuthState {}

/// For showing profile details and for them to verify it
class NewUserRegisterAuthState extends AuthState {}

/// For showing OTP screen after the phone number is given
class OTPSentAuthState extends AuthState {}

class LoadingAuthState extends AuthState {}

class PreferenceSaveSuccessAuthState extends AuthState {}

/// When the user registration completed succesfully, if the user was new
class OnboardingCompleteAuthState extends AuthState {}

class AuthenticationFailureAuthState extends AuthState {}

class LogoutSuccessAuthState extends AuthState {}

class ProfileUpdateSuccessAuthState extends AuthState {}

abstract class ApiFailureAuthState extends AuthState {
  ApiFailureAuthState(this.message);

  final String message;
}

class LoginFailureAuthState extends ApiFailureAuthState {
  LoginFailureAuthState(String message) : super(message);
}

class RegistrationFailureAuthState extends ApiFailureAuthState {
  RegistrationFailureAuthState(String message) : super(message);
}

class LogoutFailureAuthState extends ApiFailureAuthState {
  LogoutFailureAuthState(String message) : super(message);
}

class ProfileUpdateFailureAuthState extends ApiFailureAuthState {
  ProfileUpdateFailureAuthState(String message) : super(message);
}
