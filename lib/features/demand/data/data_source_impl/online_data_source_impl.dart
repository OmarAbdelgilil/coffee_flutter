import 'package:coffe_front/core/common/api_result.dart';
import 'package:coffe_front/core/network/api/api_execution.dart';
import 'package:coffe_front/core/network/api/api_manager.dart';
import 'package:coffe_front/features/demand/data/data_source/online_data_source.dart';
import 'package:coffe_front/features/demand/data/models/requests/top_sold_request.dart';
import 'package:coffe_front/features/demand/data/models/responses/top_sold_response/top_sold_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: OnlineDataSource)
class OnlineDataSourceImpl extends OnlineDataSource {
  final ApiManager _apiManager;
  OnlineDataSourceImpl(this._apiManager);

  @override
  Future<Result<TopSoldResponse>> getTopSold(String date) {
    return executeApi(() async {
      final result = await _apiManager.getTopSold(TopSoldRequest(date: date));
      return result;
    });
  }

  @override
  Future<Result<TopSoldResponse>> predict() {
    return executeApi(() async {
      final result = await _apiManager.getPredictions();
      return result;
    });
  }
}
