import 'package:coffe_front/core/common/api_result.dart';
import 'package:coffe_front/core/network/api/api_execution.dart';
import 'package:coffe_front/core/network/api/api_manager.dart';
import 'package:coffe_front/features/auth/data/data_source/online_data_source.dart';
import 'package:coffe_front/features/auth/data/models/requests/login_request.dart';
import 'package:coffe_front/features/auth/data/models/requests/register_request.dart';
import 'package:coffe_front/features/auth/data/models/responses/login_response.dart';
import 'package:coffe_front/features/auth/data/models/responses/register_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: OnlineDataSource)
class OnlineDataSourceImpl extends OnlineDataSource {
  final ApiManager _apiManager;
  OnlineDataSourceImpl(this._apiManager);
  @override
  Future<Result<RegisterResponse>> register(
    String email,
    String userName,
    String password,
  ) {
    return executeApi(() {
      return _apiManager.register(
        RegisterRequest(
          userName: userName,
          email: email,
          password: password,
          confirmPassword: password,
        ),
      );
    });
  }

  Future<Result<LoginResponse>> login(String userName, String password) {
    return executeApi(() {
      return _apiManager.login(
        LoginRequest(userName: userName, password: password),
      );
    });
  }
}
