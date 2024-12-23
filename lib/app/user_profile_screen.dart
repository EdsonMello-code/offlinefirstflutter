import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:offlinefirstflutter/app/user_profile_view_model.dart';
import 'package:offlinefirstflutter/main.dart';

class UserProfileScreen extends StatefulWidget {
  final UserProfileViewModel _userProfileViewModel;

  const UserProfileScreen({
    super.key,
    required UserProfileViewModel userProfileViewModel,
  }) : _userProfileViewModel = userProfileViewModel;

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  void initState() {
    super.initState();
    widget._userProfileViewModel.loadUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: ListenableBuilder(
        listenable: widget._userProfileViewModel,
        builder: (context, child) {
          final userProfile = widget._userProfileViewModel.userProfile;

          return SizedBox(
            width: MediaQuery.sizeOf(context).width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleAvatar(
                  key: Key(userProfile.avatarImagePath),
                  radius: (MediaQuery.sizeOf(context).width * .8) / 2,
                  backgroundImage: userProfile.avatarImagePath.isEmpty
                      ? null
                      : CachedNetworkImageProvider(
                          baseUrl + userProfile.avatarImagePath),
                ),
                ElevatedButton(
                  onPressed: widget._userProfileViewModel.editImage,
                  child: const Text('Editar'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
