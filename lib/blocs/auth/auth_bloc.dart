import 'dart:async';
import 'dart:io';

import 'package:breakq/blocs/base_bloc.dart';
import 'package:breakq/configs/app_globals.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/data/models/user_model.dart';
import 'package:breakq/data/repositories/user_repository.dart';
import 'package:breakq/main.dart';
import 'package:breakq/utils/app_cache_manager.dart';
import 'package:breakq/utils/app_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends BaseBloc<AuthEvent, AuthState> {
  AuthBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(InitialAuthState());
  // AuthBloc() : super(InitialAuthState());

  final UserRepository _userRepository;
  String _verID = '';

  StreamSubscription subscription;

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is UserRegisteredAuthEvent) {
      yield* _mapOnRegisterAuthEventToState(event);
    } else if (event is LoginRequestedAuthEvent) {
      yield* _mapLoginAuthEventToState(event);
    } else if (event is GoogleLoginRequestedAuthEvent) {
      yield* _mapGoogleLoginAuthEventToState(event);
    } else if (event is FacebookLoginRequestedAuthEvent) {
      yield* _mapFacebookLoginAuthEventToState(event);
    } else if (event is LoginFailureAuthEvent) {
      yield* _mapLoginFailureAuthEventToState(event);
    } else if (event is OTPSentAuthEvent) {
      yield* _mapOTPSentAuthEventToState(event);
    } else if (event is OTPVerificationAuthEvent) {
      yield* _mapOTPVerificationAuthEventToState(event);
    } else if (event is PhoneAuthCredEvent) {
      yield* _mapPhoneAuthCredEventToState(event);
    } else if (event is UserSavedAuthEvent) {
      yield* _mapSaveUserAuthEventToState(event);
    } else if (event is ProfileLoadedAuthEvent) {
      yield* _mapGetProfileAuthEventToState();
    } else if (event is UserLoggedOutAuthEvent) {
      yield* _mapLogoutAuthEventToState();
    } else if (event is ProfileUpdatedAuthEvent) {
      yield* _mapProfileUpdateAuthEventToState(event);
    }
  }

  Future<void> close() async {
    print("Bloc closed");
    subscription.cancel();
    super.close();
  }

  Stream<AuthState> _mapLoginFailureAuthEventToState(
      LoginFailureAuthEvent event) async* {
    // Go back to Initial State
    yield LoginFailureAuthState(event.error);
  }

  Stream<AuthState> _mapOnRegisterAuthEventToState(
      UserRegisteredAuthEvent event) async* {
    ///Notify loading to UI
    yield LoadingAuthState();

    /// Post the name, email, photo to the Server API
    print("<<API CALL>>");
    print("Name: ${event.fullName}\n" +
        "Email: ${event.email}\n" +
        "PhotoUrl: ${event.photoUrl}");

    // subscription = sendOtp(event.email).listen((event) {
    //   add(event);
    // });
    // yield VerifyOTPAuthState();
    yield OnboardingCompleteAuthState();
  }

  Stream<AuthState> _mapOTPSentAuthEventToState(OTPSentAuthEvent event) async* {
    print("OTP has been sent");

    yield OTPSentAuthState();
  }

  Stream<AuthState> _mapOTPVerificationAuthEventToState(
      OTPVerificationAuthEvent event) async* {
    ///Notify loading to UI
    yield LoadingAuthState();
    AuthCredential _authCred;
    _authCred =
        await UserRepository().getPhoneAuthCredential(_verID, event.otp);
    add(PhoneAuthCredEvent(_authCred));
  }

  Stream<AuthState> _mapLoginAuthEventToState(
      LoginRequestedAuthEvent event) async* {
    sendOtp(event.phone);
    yield OTPSentAuthState();
  }

  Stream<AuthState> _mapGoogleLoginAuthEventToState(
      GoogleLoginRequestedAuthEvent event) async* {
    yield LoadingAuthState();

    final user = await _userRepository.signInWithGoogle();
    if (user == null) {
      yield LoginFailureAuthState('Login with Google Failed! Please try again');
    } else {
      getIt.get<AppGlobals>().user = user;
      // try {
      //   getIt.get<AppGlobals>().user = getIt.get<AppGlobals>().user.copyWith(
      //         googleId: user.uid,
      //         fullName: user.displayName,
      //         email: user.email,
      //         profilePhoto: user.photoURL,
      //       );
      // } catch (e) {
      //   getIt.get<AppGlobals>().user = UserModel(
      //     googleId: user.uid,
      //     displayName: user.displayName,
      //     email: user.email,
      //     photoURL: user.photoURL,
      //   );
      // }
      AppCacheManager.instance.emptyCache();
      yield SocialLoginSuccessAuthState();
    }
  }

  Stream<AuthState> _mapFacebookLoginAuthEventToState(
      FacebookLoginRequestedAuthEvent event) async* {
    yield LoadingAuthState();

    final user = await _userRepository.signInWithFacebook();
    if (user == null) {
      yield LoginFailureAuthState(
          'Login with Facebook Failed! Please try again');
    } else {
      getIt.get<AppGlobals>().user = user;
      // try {
      //   getIt.get<AppGlobals>().user = getIt.get<AppGlobals>().user.copyWith(
      //         facebookId: user.uid,
      //         fullName: user.displayName,
      //         email: user.email,
      //         profilePhoto: user.photoURL,
      //       );
      // } catch (e) {
      //   getIt.get<AppGlobals>().user = UserModel(
      //     facebookId: user.uid,
      //     displayName: user.displayName,
      //     email: user.email,
      //     photoURL: user.photoURL,
      //   );
      // }
      AppCacheManager.instance.emptyCache();
      yield SocialLoginSuccessAuthState();
    }
  }

  Stream<AuthState> _mapPhoneAuthCredEventToState(
      PhoneAuthCredEvent event) async* {
    AppCacheManager.instance.emptyCache();

    User user;
    try {
      user = (await UserRepository().linkCredential(event.phoneCred)).user;
    } catch (e) {
      try {
        user = (await UserRepository().signInCredential(event.phoneCred)).user;
      } catch (e1) {
        print(e1);
        yield LoginFailureAuthState('Invalid OTP!');
      }
    }

    if (user != null) {
      ///Save to Storage phone
      final bool savePreferences = await getIt.get<AppPreferences>().setString(
            PreferenceKey.phoneID,
            user?.uid?.toString(),
            // event.user?.phoneId?.toString(),
          );

      if (savePreferences) {
        yield PreferenceSaveSuccessAuthState();

        /// TODO
        if (getIt.get<AppGlobals>().user != null) {
          // if (getIt.get<AppGlobals>().usergoogleId != null ||
          //     getIt.get<AppGlobals>().user.facebookId != null)
          yield LoginSuccessWithSocialAuthState();
        } else
          yield LoginSuccessAuthState();

        getIt.get<AppGlobals>().user = user;
      }

      /// We got the User creds over here so set the VerID to null now
      _verID = null;
    }
  }

  Stream<AuthState> _mapSaveUserAuthEventToState(
      UserSavedAuthEvent event) async* {
    AppCacheManager.instance.emptyCache();

    ///Save to Storage phone
    final bool savePreferences = await getIt.get<AppPreferences>().setString(
          PreferenceKey.phoneID,
          event.user?.uid?.toString(),
        );

    if (savePreferences) {
      yield PreferenceSaveSuccessAuthState();
      yield LoginSuccessAuthState();
    }
  }

  Stream<AuthState> _mapGetProfileAuthEventToState() async* {
    yield LoadingAuthState();

    final bool hasToken =
        await getIt.get<AppPreferences>().containsKey(PreferenceKey.phoneID);

    if (hasToken) {
      getIt.get<AppGlobals>().user = _userRepository.getUser();
      // User user = _userRepository.getUser();
      // getIt.get<AppGlobals>().user = UserModel(
      //   facebookId: user.uid,
      //   fullName: user.displayName,
      //   email: user.email,
      //   profilePhoto: user.photoURL,
      // );

      add(UserSavedAuthEvent(getIt.get<AppGlobals>().user));
    } else {
      yield AuthenticationFailureAuthState();
    }
  }

  Stream<AuthState> _mapLogoutAuthEventToState() async* {
    yield LoadingAuthState();

    try {
      final bool deletePreferences =
          await getIt.get<AppPreferences>().remove(PreferenceKey.phoneID);

      if (deletePreferences) {
        getIt.get<AppGlobals>().user = null;
        getIt.get<AppGlobals>().isUserOnboarded = false;
        await getIt.get<AppPreferences>().remove(PreferenceKey.isOnboarded);
        yield AuthenticationFailureAuthState();
      }
      yield LogoutSuccessAuthState();
    } catch (error) {
      yield LogoutFailureAuthState(error.toString());
    }
  }

  Stream<AuthState> _mapProfileUpdateAuthEventToState(
      ProfileUpdatedAuthEvent event) async* {
    yield LoadingAuthState();

    getIt.get<AppGlobals>().user = _userRepository.getUser();

    add(UserSavedAuthEvent(getIt.get<AppGlobals>().user));

    yield ProfileUpdateSuccessAuthState();
  }

  Future<void> sendOtp(String phoNo) async {
    final phoneVerificationCompleted =
        (PhoneAuthCredential authCredential) async {
      /// This is executed when the OTP is Auto verified
      // var userCredential =
      //     await FirebaseAuth.instance.signInWithCredential(authCredential);
      // User user = userCredential.user;
      // getIt.get<AppGlobals>().user = user;
      // try {
      //   getIt.get<AppGlobals>().user = getIt.get<AppGlobals>().user.copyWith(
      //         phoneId: user.uid,
      //         phone: user.phoneNumber,
      //       );
      // } catch (e) {
      //   getIt.get<AppGlobals>().user = UserModel(
      //     phoneId: user.uid,
      //     phoneNumber: user.phoneNumber,
      //   );
      // }
      // AppCacheManager.instance.emptyCache();

      // try {
      add(PhoneAuthCredEvent(authCredential));
      // } catch (error) {
      //   add(LoginFailureAuthEvent(error.toString()));
      // }
    };

    final phoneVerificationFailed = (FirebaseAuthException authException) {
      print(authException.message);
      add(LoginFailureAuthEvent(authException.message));
    };
    final phoneCodeSent = (String verId, [int forceResent]) {
      _verID = verId;
    };
    final phoneCodeAutoRetrievalTimeout = (String verid) {
      /// TODO: Is this really needed?
      _verID = verid;
    };

    await _userRepository.sendOtp(
        phoNo,
        Duration(seconds: 60),
        phoneVerificationFailed,
        phoneVerificationCompleted,
        phoneCodeSent,
        phoneCodeAutoRetrievalTimeout);
  }
}
