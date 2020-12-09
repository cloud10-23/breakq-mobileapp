class UserModel {
  UserModel(
    this.id,
    this.fullName,
    this.profilePhoto,
    this.phone,
    this.upcomingAppointments,
  );
  factory UserModel.forReview({int id, String name, String image}) {
    return UserModel(id, name, image, '', 0);
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final String _profilePhoto = json['profile_photo'] as String ?? '';

    return UserModel(
      json['user_id'] as int ?? 0,
      json['full_name'] as String ?? '',
      _profilePhoto.isNotEmpty
          ? 'assets/images/data/users/' + _profilePhoto
          : '',
      json['phone'] as String ?? '',
      json['upcoming_appointments'] as int ?? 0,
    );
  }

  final int id;
  final String fullName;
  final String profilePhoto;
  final String phone;
  final int upcomingAppointments;
}
