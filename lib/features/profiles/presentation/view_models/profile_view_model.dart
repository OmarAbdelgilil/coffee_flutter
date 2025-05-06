import 'package:coffe_front/core/common/api_result.dart';
import 'package:coffe_front/core/di/di.dart';
import 'package:coffe_front/features/profiles/data/data_source/online_data_source.dart';
import 'package:coffe_front/features/profiles/data/models/responses/delete_user_response.dart';
import 'package:coffe_front/features/profiles/data/models/responses/users_response/user.dart';
import 'package:coffe_front/features/profiles/data/models/responses/users_response/users_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProfileViewModel extends StateNotifier<ProfileStates> {
  final OnlineDataSource _onlineDataSource;
  int lowInStock = 0;
  double lowPercent = 0.0;
  ProfileViewModel(this._onlineDataSource) : super(InitialState());

  getData() async {
    state = LoadingState();
    final result = await _onlineDataSource.getAllusers();
    switch (result) {
      case Success<UsersResponse>():
        state = SuccessState(result.data!.users!);
        return;
      case Fail<UsersResponse>():
        state = ErrorState(result.exception!);
        return;
    }
  }

  deleteUser(String id) async {
    final result = await _onlineDataSource.deleteUser(id);
    switch (result) {
      case Success<DeleteUserResponse>():
        await getData();
        return;
      case Fail<DeleteUserResponse>():
        state = ErrorState(result.exception!);
        return;
    }
  }
}

final profilesProvider = StateNotifierProvider<ProfileViewModel, ProfileStates>(
  (ref) => getIt<ProfileViewModel>()..getData(),
);

sealed class ProfileStates {}

class InitialState extends ProfileStates {}

class LoadingState extends ProfileStates {}

class SuccessState extends ProfileStates {
  List<User> data;
  SuccessState(this.data);
}

class ErrorState extends ProfileStates {
  Exception ex;
  ErrorState(this.ex);
}
