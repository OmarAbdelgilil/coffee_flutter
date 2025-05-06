import 'package:coffe_front/core/common/api_result.dart';
import 'package:coffe_front/features/shop/data/models/responses/items_response/items_response.dart';
import 'package:coffe_front/features/shop/data/models/responses/order_response.dart';
import 'package:coffe_front/features/shop/presentation/viewmodels/shop_view_model.dart';

abstract class OnlineDataSource {
  Future<Result<ItemsResponse>> getAllItems();
  Future<Result<OrderResponse>> makeOrder(List<OrderItemModel> items);
}
