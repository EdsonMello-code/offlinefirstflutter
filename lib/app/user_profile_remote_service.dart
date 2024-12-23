import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:offlinefirstflutter/app/user_profile.dart';
import 'package:offlinefirstflutter/app/user_profile_service.dart';

final class UserProfileRemoteService implements UserProfileService {
  final Dio _dio;

  const UserProfileRemoteService({required Dio dio}) : _dio = dio;

  @override
  Future<UserProfile> getUserProfile() async {
    final response = await _dio.get(
      '/user_profile',
    );

    final userProfile = UserProfile.fromMap(response.data);

    return userProfile;
  }

  @override
  Future<void> updateUserProfile(UserProfile userProfile) async {
    await _dio.post('/user_profile', data: userProfile.toMap());
  }

  Future<void> updateAvatarImage(Uint8List avatar) async {
    final file = MultipartFile.fromBytes(
      avatar,
      filename: 'image',
      // contentType: DioMediaType.parse(DioMediaType.),
    );

    await _dio.post(
      '/user_profile',
      data: file,
    );
  }
}
