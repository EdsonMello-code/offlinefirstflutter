import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:offlinefirstflutter/app/user_profile_local_service.dart';
import 'package:offlinefirstflutter/app/user_profile_remote_service.dart';
import 'package:offlinefirstflutter/app/user_profile_repository.dart';
import 'package:offlinefirstflutter/app/user_profile_screen.dart';
import 'package:offlinefirstflutter/app/user_profile_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserProfileLocalService().initializeDatabase();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UserProfileScreen(
        userProfileViewModel: userProfileViewModel,
      ),
    );
  }
}

final UserProfileViewModel userProfileViewModel = UserProfileViewModel(
  userProfileRepository: UserProfileRepository(
    userProfileLocalService: UserProfileLocalService(),
    userProfileRemoteService: UserProfileRemoteService(
      dio: Dio(
        BaseOptions(
          baseUrl: baseUrl,
        ),
      ),
    ),
  ),
);

const baseUrl = 'http://192.168.1.145:3000';
