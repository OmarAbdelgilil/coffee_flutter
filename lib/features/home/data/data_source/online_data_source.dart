import 'package:coffe_front/core/common/api_result.dart';
import 'package:coffe_front/features/home/data/models/responses/revenue_response_response/revenue_response_response.dart';

abstract class OnlineDataSource {
  Future<Result<RevenueResponseResponse>> getHomePage(String date);
}
