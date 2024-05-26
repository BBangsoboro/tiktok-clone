import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfileModel {
  final String uid;
  final String email;
  final String displayName;
  final String bio;
  final String link;
  final String username;
  final DateTime birthday;
  final bool hasAvatar;

  UserProfileModel({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.bio,
    required this.link,
    required this.birthday,
    required this.username,
    required this.hasAvatar,
  });

  UserProfileModel.fromJson(Map<String, dynamic> json)
      : uid = json['uid'],
        email = json['email'],
        displayName = json['displayName'],
        bio = json['bio'],
        link = json['link'],
        username = json['username'],
        birthday = json['birthday'].runtimeType == Timestamp
            ? (json['birthday'] as Timestamp).toDate()
            : json['birthday'],
        hasAvatar = json['hasAvatar'];

  UserProfileModel.empty()
      : uid = "",
        email = "",
        displayName = "",
        bio = "",
        link = "",
        username = "",
        birthday = DateTime.now(),
        hasAvatar = false;

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "email": email,
      "displayName": displayName,
      "bio": bio,
      "link": link,
      "username": username,
      "birthday": birthday,
      "hasAvatar": hasAvatar,
    };
  }

  UserProfileModel copyWith({
    String? uid,
    String? email,
    String? displayName,
    String? bio,
    String? link,
    String? username,
    DateTime? birthday,
    bool? hasAvatar,
  }) {
    return UserProfileModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      bio: bio ?? this.bio,
      link: link ?? this.link,
      birthday: birthday ?? this.birthday,
      username: username ?? this.username,
      hasAvatar: hasAvatar ?? this.hasAvatar,
    );
  }
}
