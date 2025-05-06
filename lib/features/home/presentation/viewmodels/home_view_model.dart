import 'package:coffe_front/core/common/api_result.dart';
import 'package:coffe_front/core/di/di.dart';
import 'package:coffe_front/features/home/data/data_source/online_data_source.dart';
import 'package:coffe_front/features/home/data/models/responses/revenue_response_response/revenue_response_response.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeViewModel extends StateNotifier<HomeStates> {
  final OnlineDataSource _onlineDataSource;
  HomeViewModel(this._onlineDataSource) : super(InitialState());

  getData(String? date) async {
    state = LoadingState();
    final result = await _onlineDataSource.getHomePage(date ?? "2024-02-17");
    switch (result) {
      case Success<RevenueResponseResponse>():
        state = SuccessState(result.data!);
        return;
      case Fail<RevenueResponseResponse>():
        state = ErrorState(result.exception!);
    }
  }
}

final homeProvider = StateNotifierProvider<HomeViewModel, HomeStates>(
  (ref) => getIt<HomeViewModel>()..getData(null),
);

sealed class HomeStates {}

class InitialState extends HomeStates {}

class LoadingState extends HomeStates {}

class SuccessState extends HomeStates {
  RevenueResponseResponse data;
  SuccessState(this.data);
}

class ErrorState extends HomeStates {
  Exception ex;
  ErrorState(this.ex);
}
