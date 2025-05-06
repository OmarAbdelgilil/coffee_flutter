import 'package:coffe_front/core/common/api_result.dart';
import 'package:coffe_front/core/network/api/api_execution.dart';
import 'package:coffe_front/core/network/api/api_manager.dart';
import 'package:coffe_front/features/home/data/data_source/online_data_source.dart';
import 'package:coffe_front/features/home/data/models/requests/revenue_expense_request.dart';
import 'package:coffe_front/features/home/data/models/responses/revenue_response_response/revenue_response_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: OnlineDataSource)
class OnlineDataSourceImpl extends OnlineDataSource {
  final ApiManager _apiManager;
  OnlineDataSourceImpl(this._apiManager);

  @override
  Future<Result<RevenueResponseResponse>> getHomePage(String date) {
    return executeApi(() async {
      final result = await _apiManager.getRevenueExpense(
        RevenueExpenseRequest(day: date),
      );
      return result;
    });
  }
}
