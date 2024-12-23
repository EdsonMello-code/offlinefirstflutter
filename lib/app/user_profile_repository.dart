import 'dart:typed_data';

import 'package:offlinefirstflutter/app/user_profile.dart';
import 'package:offlinefirstflutter/app/user_profile_remote_service.dart';
import 'package:offlinefirstflutter/app/user_profile_service.dart';

class UserProfileRepository {
  final UserProfileService _userProfileLocalService;
  final UserProfileRemoteService _userProfileRemoteService;

  UserProfileRepository(
      {required UserProfileService userProfileLocalService,
      required UserProfileRemoteService userProfileRemoteService})
      : _userProfileLocalService = userProfileLocalService,
        _userProfileRemoteService = userProfileRemoteService;

  Future<UserProfile> getUserProfile() async {
    try {
      final apiUserProfile = await _userProfileRemoteService.getUserProfile();
      await _userProfileLocalService.updateUserProfile(apiUserProfile);

      return apiUserProfile;
    } catch (e) {
      try {
        final databaseUserProfile =
            await _userProfileLocalService.getUserProfile();

        return databaseUserProfile;
      } catch (e) {
        throw Exception('User profile not found');
      }
    }
  }

  Future<UserProfile> updateUserProfile(UserProfile userProfile) async {
    try {
      await _userProfileRemoteService.updateUserProfile(
        userProfile.copyWith(
          syncronized: true,
        ),
      );
      await _userProfileLocalService.updateUserProfile(
        userProfile.copyWith(
          syncronized: true,
        ),
      );
    } catch (e) {
      await _userProfileLocalService.updateUserProfile(
        userProfile.copyWith(
          syncronized: false,
        ),
      );
    }

    return await _userProfileLocalService.getUserProfile();
  }

  Future<void> updateAvatar(Uint8List avatar) async {
    try {
      await _userProfileRemoteService.updateAvatarImage(avatar);
    } catch (e) {
      rethrow;
    }
  }
}
