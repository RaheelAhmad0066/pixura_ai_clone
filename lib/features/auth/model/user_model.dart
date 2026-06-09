import 'package:pixura_ai/core/utils/date_utils.dart';

class UserModel {
  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.countryCode,
    required this.dateOfBirth,
    required this.role,
    required this.specialty,
    required this.profileImage,
  });

  final int? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;
  final String? countryCode;
  final DateTime? dateOfBirth;
  final List<String> role;
  final String? specialty;
  final ProfileImage? profileImage;

  UserModel copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? countryCode,
    DateTime? dateOfBirth,
    List<String>? role,
    String? specialty,
    ProfileImage? profileImage,
  }) {
    return UserModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      countryCode: countryCode ?? this.countryCode,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      role: role ?? this.role,
      specialty: specialty ?? this.specialty,
      profileImage: profileImage ?? this.profileImage,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      email: json["email"],
      phone: json["phone"],
      countryCode: json["countryCode"],
      dateOfBirth: AppDateUtils.parseApiDate(json["dateOfBirth"]),
      role: json["role"] == null
          ? []
          : List<String>.from(json["role"]!.map((x) => x)),
      specialty: json["specialty"],
      profileImage: json["profileImage"] == null
          ? null
          : ProfileImage.fromJson(json["profileImage"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "phone": phone,
    "countryCode": countryCode,
    "dateOfBirth": dateOfBirth?.toIso8601String(),
    "role": role.map((x) => x).toList(),
    "specialty": specialty,
    "profileImage": profileImage?.toJson(),
  };
}

class ProfileImage {
  ProfileImage({
    required this.id,
    required this.alt,
    required this.prefix,
    required this.updatedAt,
    required this.createdAt,
    required this.url,
    required this.thumbnailUrl,
    required this.filename,
    required this.mimeType,
    required this.filesize,
    required this.width,
    required this.height,
    required this.focalX,
    required this.focalY,
    required this.sizes,
  });

  final int? id;
  final String? alt;
  final String? prefix;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  final String? url;
  final dynamic thumbnailUrl;
  final String? filename;
  final String? mimeType;
  final int? filesize;
  final int? width;
  final int? height;
  final int? focalX;
  final int? focalY;
  final Sizes? sizes;

  ProfileImage copyWith({
    int? id,
    String? alt,
    String? prefix,
    DateTime? updatedAt,
    DateTime? createdAt,
    String? url,
    dynamic thumbnailUrl,
    String? filename,
    String? mimeType,
    int? filesize,
    int? width,
    int? height,
    int? focalX,
    int? focalY,
    Sizes? sizes,
  }) {
    return ProfileImage(
      id: id ?? this.id,
      alt: alt ?? this.alt,
      prefix: prefix ?? this.prefix,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
      url: url ?? this.url,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      filename: filename ?? this.filename,
      mimeType: mimeType ?? this.mimeType,
      filesize: filesize ?? this.filesize,
      width: width ?? this.width,
      height: height ?? this.height,
      focalX: focalX ?? this.focalX,
      focalY: focalY ?? this.focalY,
      sizes: sizes ?? this.sizes,
    );
  }

  factory ProfileImage.fromJson(Map<String, dynamic> json) {
    return ProfileImage(
      id: json["id"],
      alt: json["alt"],
      prefix: json["prefix"],
      updatedAt: AppDateUtils.parseApiDate(json["updatedAt"]),
      createdAt: AppDateUtils.parseApiDate(json["createdAt"]),
      url: json["url"],
      thumbnailUrl: json["thumbnailURL"],
      filename: json["filename"],
      mimeType: json["mimeType"],
      filesize: json["filesize"],
      width: json["width"],
      height: json["height"],
      focalX: json["focalX"],
      focalY: json["focalY"],
      sizes: json["sizes"] == null ? null : Sizes.fromJson(json["sizes"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "alt": alt,
    "prefix": prefix,
    "updatedAt": updatedAt?.toIso8601String(),
    "createdAt": createdAt?.toIso8601String(),
    "url": url,
    "thumbnailURL": thumbnailUrl,
    "filename": filename,
    "mimeType": mimeType,
    "filesize": filesize,
    "width": width,
    "height": height,
    "focalX": focalX,
    "focalY": focalY,
    "sizes": sizes?.toJson(),
  };
}

class Sizes {
  Sizes({required this.card, required this.tablet, required this.thumbnail});

  final Card? card;
  final Card? tablet;
  final Card? thumbnail;

  Sizes copyWith({Card? card, Card? tablet, Card? thumbnail}) {
    return Sizes(
      card: card ?? this.card,
      tablet: tablet ?? this.tablet,
      thumbnail: thumbnail ?? this.thumbnail,
    );
  }

  factory Sizes.fromJson(Map<String, dynamic> json) {
    return Sizes(
      card: json["card"] == null ? null : Card.fromJson(json["card"]),
      tablet: json["tablet"] == null ? null : Card.fromJson(json["tablet"]),
      thumbnail: json["thumbnail"] == null
          ? null
          : Card.fromJson(json["thumbnail"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "card": card?.toJson(),
    "tablet": tablet?.toJson(),
    "thumbnail": thumbnail?.toJson(),
  };
}

class Card {
  Card({
    required this.width,
    required this.height,
    required this.filename,
    required this.filesize,
    required this.mimeType,
    required this.url,
  });

  final int? width;
  final int? height;
  final String? filename;
  final int? filesize;
  final String? mimeType;
  final String? url;

  Card copyWith({
    int? width,
    int? height,
    String? filename,
    int? filesize,
    String? mimeType,
    String? url,
  }) {
    return Card(
      width: width ?? this.width,
      height: height ?? this.height,
      filename: filename ?? this.filename,
      filesize: filesize ?? this.filesize,
      mimeType: mimeType ?? this.mimeType,
      url: url ?? this.url,
    );
  }

  factory Card.fromJson(Map<String, dynamic> json) {
    return Card(
      width: json["width"],
      height: json["height"],
      filename: json["filename"],
      filesize: json["filesize"],
      mimeType: json["mimeType"],
      url: json["url"],
    );
  }

  Map<String, dynamic> toJson() => {
    "width": width,
    "height": height,
    "filename": filename,
    "filesize": filesize,
    "mimeType": mimeType,
    "url": url,
  };
}
