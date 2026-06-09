class ProfileModel {
  final String firstName;
  final String lastName;
  final String email;
  final String? organization;
  final String? phoneNumber;
  final String? address;
  final String? profileImageUrl;
  final String? profilePictureId;

  ProfileModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    this.organization,
    this.phoneNumber,
    this.address,
    this.profileImageUrl,
    this.profilePictureId,
  });

  ProfileModel copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? organization,
    String? phoneNumber,
    String? address,
    String? profileImageUrl,
    String? profilePictureId,
  }) {
    return ProfileModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      organization: organization ?? this.organization,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      profilePictureId: profilePictureId ?? this.profilePictureId,
    );
  }

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    // Support both GET response (profileImage.url) and PUT response (picture.path)
    String? imageUrl;
    final pictureObj = json['picture'];
    if (pictureObj is Map<String, dynamic>) {
      imageUrl = pictureObj['path'] as String?;
    }
    if (imageUrl == null) {
      final profileImageObj = json['profileImage'];
      if (profileImageObj is Map<String, dynamic>) {
        imageUrl = profileImageObj['url'] as String?
            ?? profileImageObj['path'] as String?;
      }
    }

    String? pictureId;
    if (pictureObj is Map<String, dynamic>) {
      pictureId = pictureObj['id'] as String?;
    }

    return ProfileModel(
      firstName: json['name'] ?? json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
      organization: json['organization'],
      phoneNumber: json['phoneNumber'],
      address: json['address'],
      profileImageUrl: imageUrl,
      profilePictureId: pictureId,
    );
  }

  Map<String, dynamic> toJson({String? profilePictureId}) {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'organization': organization,
      'phoneNumber': phoneNumber,
      'address': address,
      if (profilePictureId != null) 'profilePictureId': profilePictureId,
    };
  }

  /// Returns the user's full display name
  String get fullName {
    final first = firstName.trim();
    final last = lastName.trim();
    if (first.isEmpty && last.isEmpty) return 'User';
    return '$first $last'.trim();
  }
}
