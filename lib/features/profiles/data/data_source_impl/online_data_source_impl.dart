import 'package:coffe_front/core/common/api_result.dart';
import 'package:coffe_front/core/network/api/api_execution.dart';
import 'package:coffe_front/core/network/api/api_manager.dart';
import 'package:coffe_front/features/profiles/data/data_source/online_data_source.dart';
import 'package:coffe_front/features/profiles/data/models/requests/delete_user_request.dart';
import 'package:coffe_front/features/profiles/data/models/responses/delete_user_response.dart';
import 'package:coffe_front/features/profiles/data/models/responses/users_response/users_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: OnlineDataSource)
class OnlineDataSourceImpl extends OnlineDataSource {
  final ApiManager _apiManager;
  OnlineDataSourceImpl(this._apiManager);

  @override
  Future<Result<UsersResponse>> getAllusers() {
    return executeApi(() {
      return _apiManager.getAllUsers();
    });
  }

  @override
  Future<Result<DeleteUserResponse>> deleteUser(String id) async {
    return await executeApi(() async {
      return await _apiManager.deleteUser(DeleteUserRequest(userId: id));
    });
  }
}
