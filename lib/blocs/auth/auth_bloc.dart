import 'dart:async';
import 'dart:io';

import 'package:breakq/blocs/base_bloc.dart';
import 'package:breakq/blocs/cart/cart_bloc.dart';
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

    User user = getIt.get<AppGlobals>().user;

    String result = await _userRepository.registerUser(UserModel(
      name: event.name,
      email: event.email,
      mobileNo: user.phoneNumber,
      firebaseId: user.uid,
    ));

    print(result);

    /// Update the details of the current user with Firebase
    // if (getIt.get<AppGlobals>().user.displayName == null) {
    /// User registered through only mobile login
    // }
    try {
      await _userRepository.updateProfile(event.name, event.email);
      getIt.get<AppGlobals>().user = _userRepository.getUser();
      yield OnboardingCompleteAuthState();
    } catch (e) {
      // TODO: Handle this case
      print(e);
      yield OnboardingCompleteAuthState();
    }
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
    _authCred = await _userRepository.getPhoneAuthCredential(_verID, event.otp);
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
    var userCred;
    User user;
    try {
      userCred = await _userRepository.signInWithGoogle();
      user = userCred?.user;
    } catch (e) {
      user = null;
      yield LoginFailureAuthState('Login with Google Failed! Please try again');
    }
    if (user != null) {
      getIt.get<AppGlobals>().user = user;
      AppCacheManager.instance.emptyCache();

      /// Check whether the user is new or old, or if the phoneNumber is linked
      if (user.phoneNumber == null || userCred.additionalUserInfo.isNewUser)

        /// Is new user, redirect to phone number linking
        yield LinkPhoneAuthState();
      else
        yield LoginSuccessAuthState();
    }
  }

  Stream<AuthState> _mapFacebookLoginAuthEventToState(
      FacebookLoginRequestedAuthEvent event) async* {
    yield LoadingAuthState();

    var userCred;
    User user;
    try {
      userCred = await _userRepository.signInWithFacebook();
      user = userCred?.user;
    } catch (e) {
      user = null;
      yield LoginFailureAuthState(
          'Login with Facebook Failed! Please try again');
    }
    if (user != null) {
      getIt.get<AppGlobals>().user = user;
      AppCacheManager.instance.emptyCache();

      /// Check whether the user is new or old, or if the phoneNumber is linked
      if (user.phoneNumber == null || userCred.additionalUserInfo.isNewUser)

        /// Is new user, redirect to phone number linking
        yield LinkPhoneAuthState();
      else
        yield LoginSuccessAuthState();
    }
  }

  Stream<AuthState> _mapPhoneAuthCredEventToState(
      PhoneAuthCredEvent event) async* {
    AppCacheManager.instance.emptyCache();

    User user;

    /// If social sign-in then link the credential (TODO)
    if (getIt.get<AppGlobals>().user != null) {
      try {
        user = (await _userRepository.linkCredential(event.phoneCred))?.user;
      } catch (e) {
        print(e);
        if (e?.code == 'invalid-credential' ||
            e?.code == 'invalid-verification-code')
          yield LoginFailureAuthState('Invalid OTP!');
        else {
          yield LoginFailureAuthState(
              "Sorry! Couldn't link your social account " +
                  "with phone! Please try again later! " +
                  "Contact the store if this persists.");
        }
      }
      if (user != null) {
        ///Save to Storage phone
        final bool savePreferences =
            await getIt.get<AppPreferences>().setString(
                  PreferenceKey.phoneID,
                  user?.uid?.toString(),
                  // event.user?.phoneId?.toString(),
                );

        if (savePreferences) {
          yield PreferenceSaveSuccessAuthState();
          yield NewUserRegisterAuthState();
          getIt.get<AppGlobals>().user = user;
        }
      }
    } else {
      UserCredential userCred;
      try {
        userCred = await _userRepository.signInCredential(event.phoneCred);
        user = userCred?.user;
      } catch (e1) {
        print(e1);
        yield LoginFailureAuthState('Invalid OTP!');
      }

      /// Check if user in new or old here
      if (user != null) {
        ///Save to Storage phone
        final bool savePreferences =
            await getIt.get<AppPreferences>().setString(
                  PreferenceKey.phoneID,
                  user?.uid?.toString(),
                );
        if (savePreferences) {
          yield PreferenceSaveSuccessAuthState();
          if ((userCred.additionalUserInfo.isNewUser ||
              user.displayName == null)) {
            /// User is new
            yield NewUserRegisterAuthState();
          } else {
            yield LoginSuccessAuthState();
          }

          getIt.get<AppGlobals>().user = user;
        }

        /// We got the User creds over here so set the VerID to null now
        _verID = null;
      }
    }
  }

  Stream<AuthState> _mapSaveUserAuthEventToState(
      UserSavedAuthEvent event) async* {
    // AppCacheManager.instance.emptyCache();

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

    getIt.get<AppGlobals>().user = _userRepository.getUser();
    // User user = _userRepository.getUser();
    // getIt.get<AppGlobals>().user = UserModel(
    //   facebookId: user.uid,
    //   fullName: user.displayName,
    //   email: user.email,
    //   profilePhoto: user.photoURL,
    // );

    yield LoginSuccessAuthState();
  }

  Stream<AuthState> _mapLogoutAuthEventToState() async* {
    yield LoadingAuthState();

    try {
      final bool deletePreferences =
          await getIt.get<AppPreferences>().remove(PreferenceKey.phoneID);

      if (deletePreferences) {
        getIt.get<AppGlobals>().user = null;
        getIt.get<AppGlobals>().isUserOnboarded = false;
        getIt.get<AppGlobals>().selectedStore = null;
        getIt.get<AppGlobals>().stores = null;
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
