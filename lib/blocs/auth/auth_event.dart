part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {
  @override
  String toString() => '$runtimeType';
}

class ProfileLoadedAuthEvent extends AuthEvent {}

class UserLoggedOutAuthEvent extends AuthEvent {}

class UserClearedAuthEvent extends AuthEvent {}

class NewPasswordRequestedAuthEvent extends AuthEvent {
  NewPasswordRequestedAuthEvent(this.email);

  final String email;
}

class LoginRequestedAuthEvent extends AuthEvent {
  LoginRequestedAuthEvent({this.phone});

  final String phone;
}

class GoogleLoginRequestedAuthEvent extends AuthEvent {
  GoogleLoginRequestedAuthEvent();
}

class OTPGoBackAuthEvent extends AuthEvent {}

class OTPVerificationAuthEvent extends AuthEvent {
  OTPVerificationAuthEvent({this.otp});

  final String otp;
}

class UserRegisteredAuthEvent extends AuthEvent {
  UserRegisteredAuthEvent({
    this.fullName,
    this.email,
    this.password,
  });

  final String fullName;
  final String email;
  final String password;
}

class UserSavedAuthEvent extends AuthEvent {
  UserSavedAuthEvent(this.user);

  final User user;
}

class LoginFailureAuthEvent extends AuthEvent {
  LoginFailureAuthEvent(this.error);

  final String error;
}

class ProfileUpdatedAuthEvent extends AuthEvent {
  ProfileUpdatedAuthEvent({
    this.fullName,
    this.phone,
    this.image,
  });

  final String fullName;
  final String phone;
  final File image;
}
