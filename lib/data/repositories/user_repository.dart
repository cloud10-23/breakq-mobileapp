// import 'package:breakq/data/data_provider.dart';
import 'package:breakq/configs/api_urls.dart';
import 'package:breakq/data/data_provider.dart';
import 'package:breakq/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;

  UserRepository({FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<void> sendOtp(
      String phoneNumber,
      Duration timeOut,
      PhoneVerificationFailed phoneVerificationFailed,
      PhoneVerificationCompleted phoneVerificationCompleted,
      PhoneCodeSent phoneCodeSent,
      PhoneCodeAutoRetrievalTimeout autoRetrievalTimeout) async {
    _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: timeOut,
        verificationCompleted: phoneVerificationCompleted,
        verificationFailed: phoneVerificationFailed,
        codeSent: phoneCodeSent,
        codeAutoRetrievalTimeout: autoRetrievalTimeout);
  }

  Future<AuthCredential> getPhoneAuthCredential(
      String verificationId, String smsCode) async {
    AuthCredential authCredential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);

    return authCredential;
  }

  Future<UserCredential> linkCredential(AuthCredential authCred) =>
      _firebaseAuth.currentUser.linkWithCredential(authCred);

  Future<UserCredential> signInCredential(AuthCredential authCred) =>
      _firebaseAuth.signInWithCredential(authCred);

  Future<void> updateProfile(String displayName, String email) async {
    /// Update DisplayName and photoURL
    await _firebaseAuth.currentUser.updateProfile(
      displayName: displayName,
    );

    if ((email?.isNotEmpty ?? false) &&
        _firebaseAuth.currentUser.email != email)
      await _firebaseAuth.currentUser.verifyBeforeUpdateEmail(
        email,
      );
  }

  User getUser() {
    var user = _firebaseAuth.currentUser;
    return user;
  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final UserCredential authResult =
        await _firebaseAuth.signInWithCredential(credential);
    final User user = authResult.user;

    if (user != null) {
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final User currentUser = _firebaseAuth.currentUser;
      assert(user.uid == currentUser.uid);

      print('signInWithGoogle succeeded: ${user.displayName}');

      return authResult;
    }

    return null;
  }

  Future<void> signOutGoogle() async {
    await googleSignIn.signOut();

    print("User Signed Out");
  }

  Future<UserCredential> signInWithFacebook() async {
    // by default the login method has the next permissions ['email','public_profile']
    AccessToken _accessToken =
        (await FacebookAuth.instance.login()).accessToken;
    print(_accessToken.toJson());
    // get the user data
    final userData = await FacebookAuth.instance.getUserData();
    print(userData);
    final OAuthCredential credential = FacebookAuthProvider.credential(
        _accessToken.token); // _token is your facebook access token as a string

// FirebaseUser is deprecated
    final UserCredential userCred =
        await _firebaseAuth.signInWithCredential(credential);

    return userCred;
  }

  Future<void> signOutFacebook() async {
    await FacebookAuth.instance.logOut();
  }

  /// API Server calls:
  /// 1. Register User
  /// 2. Login/Check user is signed in

  Future<String> registerUser(UserModel user) async {
    final Uri uri = Uri.http(apiBase, apiUserRegister);

    final String _result =
        await DataProvider().postByString(uri, user.toJson());
    return _result;
  }

  Future<UserModel> loginUser(String firebaseID) async {
    final Uri uri =
        Uri.http(apiBase, apiUserLogin, {apiFirebaseId: firebaseID});

    final Map<String, dynamic> _rawUser = await DataProvider().getAsMap(uri);

    return UserModel.fromJson(_rawUser);
  }
}
