import 'package:flutter/foundation.dart';
import 'package:offlinefirstflutter/app/pick_image_mixin.dart';
import 'package:offlinefirstflutter/app/user_profile.dart';
import 'package:offlinefirstflutter/app/user_profile_repository.dart';

class UserProfileViewModel extends ChangeNotifier with PickImageMixin {
  final UserProfileRepository _userProfileRepository;

  UserProfileViewModel({
    required UserProfileRepository userProfileRepository,
  }) : _userProfileRepository = userProfileRepository;

  UserProfile get userProfile => _userProfile;

  set userProfile(UserProfile user) {
    _userProfile = user;
    notifyListeners();
  }

  UserProfile _userProfile = UserProfile.empty();

  Future<void> loadUser() async {
    final response = await _userProfileRepository.getUserProfile();

    userProfile = response;
  }

  Future<void> editImage() async {
    final image = await chooseFile();

    if (image == null) return;

    _userProfileRepository.updateAvatar(image);

    userProfile = userProfile.copyWith();
  }
}
