class UserModel {
  UserModel({
    this.phoneId,
    this.googleId,
    this.facebookId,
    this.displayName,
    this.email,
    this.photoURL,
    this.phoneNumber,
  });

  UserModel copyWith(
      {String phoneId,
      String googleId,
      String facebookId,
      String fullName,
      String email,
      String profilePhoto,
      String phone}) {
    return UserModel(
      phoneId: phoneId ?? this.phoneId,
      googleId: googleId ?? this.googleId,
      facebookId: facebookId ?? this.facebookId,
      displayName: fullName ?? this.displayName,
      email: email ?? this.email,
      photoURL: profilePhoto ?? this.photoURL,
      phoneNumber: phone ?? this.phoneNumber,
    );
  }

  final String phoneId;
  final String googleId;
  final String facebookId;
  final String displayName;
  final String email;
  final String photoURL;
  final String phoneNumber;
}
