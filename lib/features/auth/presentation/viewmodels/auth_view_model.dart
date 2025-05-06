import 'package:coffe_front/core/common/api_result.dart';
import 'package:coffe_front/core/di/di.dart';
import 'package:coffe_front/core/providers/token_provider.dart';
import 'package:coffe_front/features/auth/data/data_source/online_data_source.dart';
import 'package:coffe_front/features/auth/data/models/responses/login_response.dart';
import 'package:coffe_front/features/auth/data/models/responses/register_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';

@injectable
class AuthViewModel extends StateNotifier<AuthStates> {
  final OnlineDataSource _onlineDataSource;
  AuthViewModel(this._onlineDataSource) : super(InitialState());
  void register(String userName, String email, String password) async {
    state = LoadingState();
    final result = await _onlineDataSource.register(email, userName, password);
    switch (result) {
      case Success<RegisterResponse>():
        state = RegisterSuccessState(result.data!.message!);
        return;
      case Fail<RegisterResponse>():
        state = ErrorState(result.exception!);
        return;
    }
  }

  void login(String userName, String password, bool remember) async {
    state = LoadingState();
    final result = await _onlineDataSource.login(userName, password);
    switch (result) {
      case Success<LoginResponse>():
        if (remember) {
          await TokenProvider().setToken(result.data!.token!);
        } else {
          await TokenProvider().setTokenTemporary(result.data!.token!);
        }
        state = LoginSuccessState(result.data!.message!);
        return;
      case Fail<LoginResponse>():
        state = ErrorState(result.exception!);
        return;
    }
  }

  void resetState() {
    state = InitialState();
  }
}

final authProvider = StateNotifierProvider<AuthViewModel, AuthStates>(
  (ref) => getIt<AuthViewModel>(),
);

sealed class AuthStates {}

class InitialState extends AuthStates {}

class LoadingState extends AuthStates {}

class RegisterSuccessState extends AuthStates {
  String message;
  RegisterSuccessState(this.message);
}

class LoginSuccessState extends AuthStates {
  String message;
  LoginSuccessState(this.message);
}

class ErrorState extends AuthStates {
  Exception ex;
  ErrorState(this.ex);
}
