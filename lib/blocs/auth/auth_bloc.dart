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
    } else if (event is OTPVerificationAuthEvent) {
      yield* _mapOTPVerificationAuthEventToState(event);
    } else if (event is UserSavedAuthEvent) {
      yield* _mapSaveUserAuthEventToState(event);
    } else if (event is ProfileLoadedAuthEvent) {
      yield* _mapGetProfileAuthEventToState();
    } else if (event is UserLoggedOutAuthEvent) {
      yield* _mapLogoutAuthEventToState();
    } else if (event is UserClearedAuthEvent) {
      yield* _mapClearUserAuthEventToState();
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

  Stream<AuthState> _mapOTPVerificationAuthEventToState(
      OTPVerificationAuthEvent event) async* {
    ///Notify loading to UI
    yield LoadingAuthState();
    UserCredential user;
    try {
      user = await UserRepository().verifyAndLogin(_verID, event.otp);
    } catch (e) {
      user = null;
      print(e);
    }

    _verID = null;

    if (user == null) {
      yield LoginFailureAuthState('Invalid OTP!');
    } else {
      try {
        getIt.get<AppGlobals>().user = getIt
            .get<AppGlobals>()
            .user
            .copyWith(phoneId: user.user.uid, phone: user.user.phoneNumber);
      } catch (e) {
        getIt.get<AppGlobals>().user = UserModel(
            phoneId: user.user.uid, phoneNumber: user.user.phoneNumber);
      }
      AppCacheManager.instance.emptyCache();

      try {
        add(UserSavedAuthEvent(getIt.get<AppGlobals>().user));

        yield LoginSuccessAuthState();
      } catch (error) {
        yield LoginFailureAuthState(error.toString());
      }
    }
  }

  Stream<AuthState> _mapLoginAuthEventToState(
      LoginRequestedAuthEvent event) async* {
    subscription = sendOtp(event.phone).listen((event) {
      add(event);
    });
    yield VerifyOTPAuthState();
  }

  Stream<AuthState> _mapGoogleLoginAuthEventToState(
      GoogleLoginRequestedAuthEvent event) async* {
    yield LoadingAuthState();

    final user = await _userRepository.signInWithGoogle();
    if (user == null) {
      yield LoginFailureAuthState('Login with Google Failed! Please try again');
    } else {
      try {
        getIt.get<AppGlobals>().user = getIt.get<AppGlobals>().user.copyWith(
              googleId: user.uid,
              fullName: user.displayName,
              email: user.email,
              profilePhoto: user.photoURL,
            );
      } catch (e) {
        getIt.get<AppGlobals>().user = UserModel(
          googleId: user.uid,
          displayName: user.displayName,
          email: user.email,
          photoURL: user.photoURL,
        );
      }
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
      try {
        getIt.get<AppGlobals>().user = getIt.get<AppGlobals>().user.copyWith(
              facebookId: user.uid,
              fullName: user.displayName,
              email: user.email,
              profilePhoto: user.photoURL,
            );
      } catch (e) {
        getIt.get<AppGlobals>().user = UserModel(
          facebookId: user.uid,
          displayName: user.displayName,
          email: user.email,
          photoURL: user.photoURL,
        );
      }
      AppCacheManager.instance.emptyCache();
      yield SocialLoginSuccessAuthState();
    }
  }

  Stream<AuthState> _mapSaveUserAuthEventToState(
      UserSavedAuthEvent event) async* {
    AppCacheManager.instance.emptyCache();

    ///Save to Storage phone
    final bool savePreferences = await getIt.get<AppPreferences>().setString(
          PreferenceKey.phoneID,
          event.user?.phoneId?.toString(),
        );

    if (savePreferences) {
      yield PreferenceSaveSuccessAuthState();
      if (getIt.get<AppGlobals>().user.googleId != null ||
          getIt.get<AppGlobals>().user.facebookId != null)
        yield LoginSuccessWithSocialAuthState();
      else
        yield LoginSuccessAuthState();
    }
  }

  Stream<AuthState> _mapGetProfileAuthEventToState() async* {
    yield LoadingAuthState();

    final bool hasToken =
        await getIt.get<AppPreferences>().containsKey(PreferenceKey.phoneID);

    /// TODO : Implement the way to save the User details in Preferences
    if (hasToken) {
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
      add(UserClearedAuthEvent());

      yield LogoutSuccessAuthState();
    } catch (error) {
      yield LogoutFailureAuthState(error.toString());
    }
  }

  Stream<AuthState> _mapClearUserAuthEventToState() async* {
    final bool deletePreferences =
        await getIt.get<AppPreferences>().remove(PreferenceKey.phoneID);

    if (deletePreferences) {
      getIt.get<AppGlobals>().user = null;
      getIt.get<AppGlobals>().isUserOnboarded = false;
      await getIt.get<AppPreferences>().remove(PreferenceKey.isOnboarded);
      yield AuthenticationFailureAuthState();
    }
  }

  Stream<AuthState> _mapProfileUpdateAuthEventToState(
      ProfileUpdatedAuthEvent event) async* {
    yield LoadingAuthState();

    /// TODO:
    // getIt.get<AppGlobals>().user = _userRepository.getUser();

    // add(UserSavedAuthEvent(getIt.get<AppGlobals>().user));

    yield ProfileUpdateSuccessAuthState();
  }

  Stream<AuthEvent> sendOtp(String phoNo) async* {
    StreamController<AuthEvent> eventStream = StreamController();
    final phoneVerificationCompleted =
        (PhoneAuthCredential authCredential) async {
      /// This is executed when the OTP is Auto verified
      var userCredential =
          await FirebaseAuth.instance.signInWithCredential(authCredential);
      User user = userCredential.user;
      try {
        getIt.get<AppGlobals>().user = getIt.get<AppGlobals>().user.copyWith(
              phoneId: user.uid,
              phone: user.phoneNumber,
            );
      } catch (e) {
        getIt.get<AppGlobals>().user = UserModel(
          phoneId: user.uid,
          phoneNumber: user.phoneNumber,
        );
      }
      AppCacheManager.instance.emptyCache();

      try {
        add(UserSavedAuthEvent(getIt.get<AppGlobals>().user));
      } catch (error) {
        add(LoginFailureAuthEvent(error.toString()));
      }
    };

    final phoneVerificationFailed = (FirebaseAuthException authException) {
      print(authException.message);
      eventStream.add(LoginFailureAuthEvent(authException.message));
      eventStream.close();
    };
    final phoneCodeSent = (String verId, [int forceResent]) {
      this._verID = verId;
    };
    final phoneCodeAutoRetrievalTimeout = (String verid) {
      this._verID = verid;
      eventStream.close();
    };

    await _userRepository.sendOtp(
        phoNo,
        Duration(seconds: 1),
        phoneVerificationFailed,
        phoneVerificationCompleted,
        phoneCodeSent,
        phoneCodeAutoRetrievalTimeout);

    yield* eventStream.stream;
  }
}
