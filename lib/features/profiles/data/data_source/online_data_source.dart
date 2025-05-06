import 'package:coffe_front/core/common/api_result.dart';
import 'package:coffe_front/features/profiles/data/models/responses/delete_user_response.dart';
import 'package:coffe_front/features/profiles/data/models/responses/users_response/users_response.dart';

abstract class OnlineDataSource {
  Future<Result<UsersResponse>> getAllusers();
  Future<Result<DeleteUserResponse>> deleteUser(String id);
}
