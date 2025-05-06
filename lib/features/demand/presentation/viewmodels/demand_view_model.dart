import 'package:coffe_front/core/common/api_result.dart';
import 'package:coffe_front/core/di/di.dart';
import 'package:coffe_front/features/demand/data/data_source/online_data_source.dart';
import 'package:coffe_front/features/demand/data/models/responses/top_sold_response/top_sold_response.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';

@injectable
class DemandViewModel extends StateNotifier<DemandStates> {
  final OnlineDataSource _onlineDataSource;
  bool predict = false;
  DemandViewModel(this._onlineDataSource) : super(InitialState());
  var datePicked = '';
  var lastDate = '';
  String _formatDate(String date) {
    final parts = date.split('-');
    final year = int.parse(parts[0]);
    final month = int.parse(parts[1]);
    final day = int.parse(parts[2]);

    final months = [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    String suffix(int day) {
      if (day >= 11 && day <= 13) {
        return 'th';
      }
      switch (day % 10) {
        case 1:
          return 'st';
        case 2:
          return 'nd';
        case 3:
          return 'rd';
        default:
          return 'th';
      }
    }

    return '$day${suffix(day)} of ${months[month]} $year';
  }

  getData(String date, {bool predict = false}) async {
    state = LoadingState();
    Result<TopSoldResponse>? result;
    if (predict) {
      result = await _onlineDataSource.predict();
    } else {
      result = await _onlineDataSource.getTopSold(date);
    }

    switch (result) {
      case Success<TopSoldResponse>():
        final data = result.data!;
        final topItemsLabels = data.itemsLabels!.take(5).toList();
        final topItemsQuantity =
            data.itemsQuantities!.map((e) => e.toDouble()).toList();
        final List<Map<String, dynamic>> itemsList = [];
        for (int i = 0; i < data.itemsLabels!.length; i++) {
          final Map<String, dynamic> itemMap = {};
          itemMap[data.itemsLabels![i]] = data.itemsQuantities![i].toString();
          itemsList.add(itemMap);
        }
        state = SuccessState(
          topItemsLabels,
          topItemsQuantity,
          itemsList,
          data.topUsedIngredients!,
        );
        if (predict) {
          datePicked = "Predicted data";
        } else {
          datePicked = _formatDate(date);
        }

        lastDate = date;
        return;
      case Fail<TopSoldResponse>():
        state = ErrorState(result.exception!);
        return;
    }
  }

  togglePredict() {
    predict = !predict;
    print(datePicked);
    getData(lastDate, predict: predict);
  }
}

final demandProvider = StateNotifierProvider<DemandViewModel, DemandStates>(
  (ref) => getIt<DemandViewModel>()..getData("2024-02-12"),
);

sealed class DemandStates {}

class InitialState extends DemandStates {}

class LoadingState extends DemandStates {}

class SuccessState extends DemandStates {
  List<String> topItemsLabels;
  List<double> topItemsQuantity;
  List<Map<String, dynamic>> itemsMap;
  List<Map<String, dynamic>> ingMap;
  SuccessState(
    this.topItemsLabels,
    this.topItemsQuantity,
    this.itemsMap,
    this.ingMap,
  );
}

class ErrorState extends DemandStates {
  Exception ex;
  ErrorState(this.ex);
}
