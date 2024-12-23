import 'package:offlinefirstflutter/app/user_profile.dart';
import 'package:offlinefirstflutter/app/user_profile_service.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final class UserProfileLocalService implements UserProfileService {
  late final Database _database;

  UserProfileLocalService._();

  static final _userProfileLocalService = UserProfileLocalService._();

  factory UserProfileLocalService() {
    return _userProfileLocalService;
  }

  Future<void> initializeDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'demo.db');

    final database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE IF NOT EXISTS user_profile (
    id INTERGER PRIMARY KEY,
    name TEXT,
    avatarImagePath TEXT,
    gender TEXT,
    syncronized INT
  )''');
      },
    );

    _database = database;
  }

  @override
  Future<UserProfile> getUserProfile() async {
    final response = await _database.query('user_profile');

    if (response.isEmpty) {
      throw Exception('User not found');
    }

    final userProfile = UserProfile.fromMap(
      Map<String, dynamic>.of(response.first),
    );

    return userProfile;
  }

  @override
  Future<void> updateUserProfile(UserProfile userProfile) async {
    try {
      await _database.delete('user_profile');
      await _database.insert('user_profile', userProfile.toMap());
    } catch (e) {
      print('sfsdfds');
    }
  }
}
