import 'package:hive/hive.dart';

class HiveService {
  static const String userBoxName = 'userBox';

  Future<void> saveUser(String token, Map<String, dynamic> user) async {
    final box = await Hive.openBox(userBoxName);
    await box.put(token, user);
    final cachedUser = box.get(token);
    print('User saved in Hive for token $token: ${cachedUser?.toJson()}');
  }

  Future<Map<String, dynamic>?> getUser(String token) async {
    final box = await Hive.openBox(userBoxName);
    final user = box.get(token);
    await box.close();
    return user;
  }

  Future<void> clearUser(String token) async {
    final box = await Hive.openBox(userBoxName);
    await box.delete(token);
    print('User data cleared for token $token');
  }

  Future<void> clearAllUsers() async {
    final box = await Hive.openBox(userBoxName);
    await box.clear();
    print('All user data cleared');
  }
}
