import 'package:coffe_front/core/common/api_result.dart';
import 'package:coffe_front/features/demand/data/models/responses/top_sold_response/top_sold_response.dart';

abstract class OnlineDataSource {
  Future<Result<TopSoldResponse>> getTopSold(String date);
  Future<Result<TopSoldResponse>> predict();
}
