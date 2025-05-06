import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class TokenProvider {
  static final TokenProvider _instance = TokenProvider._internal();

  factory TokenProvider() {
    return _instance;
  }

  TokenProvider._internal();

  String? _token;

  String? get token => _token;
  Future<void> init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('auth_token');
  }

  Future<void> setToken(String token) async {
    await clearToken();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
    _token = token;
  }

  Future<void> setTokenTemporary(String token) async {
    await clearToken();
    _token = token;
  }

  Future<void> clearToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    _token = null;
  }
}
