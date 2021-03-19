part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {
  @override
  String toString() => '$runtimeType';
}

class ProfileLoadedAuthEvent extends AuthEvent {}

class UserLoggedOutAuthEvent extends AuthEvent {}

class LoginRequestedAuthEvent extends AuthEvent {
  LoginRequestedAuthEvent({this.phone});

  final String phone;
}

class GoogleLoginRequestedAuthEvent extends AuthEvent {
  GoogleLoginRequestedAuthEvent();
}

class FacebookLoginRequestedAuthEvent extends AuthEvent {
  FacebookLoginRequestedAuthEvent();
}

class OTPSentAuthEvent extends AuthEvent {
  OTPSentAuthEvent();
}

class OTPVerificationAuthEvent extends AuthEvent {
  OTPVerificationAuthEvent({this.otp});

  final String otp;
}

class UserRegisteredAuthEvent extends AuthEvent {
  UserRegisteredAuthEvent({this.fullName, this.email, this.photoUrl});

  final String fullName;
  final String email;
  final String photoUrl;
}

class UserSavedAuthEvent extends AuthEvent {
  UserSavedAuthEvent(this.user);

  final User user;
}

class PhoneAuthCredEvent extends AuthEvent {
  PhoneAuthCredEvent(this.phoneCred);

  final AuthCredential phoneCred;
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
