import 'package:flutter/foundation.dart';

class UserProfile {
  final int id;
  final String name;
  @protected
  final String avatarImagePath;
  final Gender gender;
  final bool syncronized;

  const UserProfile({
    required this.name,
    required this.avatarImagePath,
    required this.gender,
    required this.syncronized,
    required this.id,
  });

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
        name: map['name'],
        avatarImagePath: map['avatarImagePath'],
        gender: Gender.fromString(map['gender']),
        syncronized: map['syncronized'] == 1,
        id: map['id']);
  }

  factory UserProfile.empty() {
    return const UserProfile(
      name: '',
      avatarImagePath: '',
      gender: Gender.male,
      syncronized: false,
      id: -1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id == -1 ? null : id,
      'name': name,
      'avatarImagePath': avatarImagePath,
      'gender': gender.toString().toLowerCase(),
      'syncronized': syncronized ? 1 : 0,
    };
  }

  UserProfile copyWith({
    String? name,
    String? avatarImagePath,
    Gender? gender,
    bool? syncronized,
    int? id,
  }) {
    return UserProfile(
      name: name ?? this.name,
      avatarImagePath: avatarImagePath ?? this.avatarImagePath,
      gender: gender ?? this.gender,
      syncronized: syncronized ?? this.syncronized,
      id: id ?? this.id,
    );
  }
}

enum Gender {
  male(message: 'Masculino'),
  female(message: 'Feminino');

  final String message;

  @override
  toString() {
    return message;
  }

  const Gender({required this.message});

  static Gender fromString(String gender) {
    return values.firstWhere(
      (item) => item.toString().toLowerCase().contains(
            gender.toLowerCase(),
          ),
    );
  }
}
