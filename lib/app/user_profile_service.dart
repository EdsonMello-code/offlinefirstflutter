import 'package:offlinefirstflutter/app/user_profile.dart';

abstract interface class UserProfileService {
  Future<UserProfile> getUserProfile();

  Future<void> updateUserProfile(UserProfile userProfile);
}
