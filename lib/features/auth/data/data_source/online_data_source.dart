import 'package:coffe_front/core/common/api_result.dart';
import 'package:coffe_front/features/auth/data/models/responses/login_response.dart';
import 'package:coffe_front/features/auth/data/models/responses/register_response.dart';

abstract class OnlineDataSource {
  Future<Result<RegisterResponse>> register(
    String email,
    String userName,
    String password,
  );
  Future<Result<LoginResponse>> login(String userName, String password);
}
