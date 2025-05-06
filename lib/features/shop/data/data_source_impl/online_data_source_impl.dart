import 'dart:math';

import 'package:coffe_front/core/common/api_result.dart';
import 'package:coffe_front/core/network/api/api_execution.dart';
import 'package:coffe_front/core/network/api/api_manager.dart';
import 'package:coffe_front/features/shop/data/data_source/online_data_source.dart';
import 'package:coffe_front/features/shop/data/models/requests/order_request/item.dart';
import 'package:coffe_front/features/shop/data/models/requests/order_request/order_request.dart';
import 'package:coffe_front/features/shop/data/models/responses/items_response/items_response.dart';
import 'package:coffe_front/features/shop/data/models/responses/order_response.dart';
import 'package:coffe_front/features/shop/presentation/viewmodels/shop_view_model.dart';

import 'package:injectable/injectable.dart';

@Injectable(as: OnlineDataSource)
class OnlineDataSourceImpl extends OnlineDataSource {
  final ApiManager _apiManager;
  OnlineDataSourceImpl(this._apiManager);

  @override
  Future<Result<ItemsResponse>> getAllItems() async {
    return await executeApi(() async {
      final result = await _apiManager.getAllItems();
      return result;
    });
  }

  String generateUniqueOrderId() {
    final rand = Random();
    List<int> digits = List.generate(10, (i) => i);
    digits.shuffle(rand);
    String uniqueDigits = digits.take(6).join();
    return 'ORD_$uniqueDigits';
  }

  @override
  Future<Result<OrderResponse>> makeOrder(List<OrderItemModel> items) async {
    List<Item> itemsList =
        items.map((e) => Item(itemId: e.id, quantity: 1)).toList();

    return await executeApi(() {
      final request = OrderRequest(
        custName: "Sytem",
        items: itemsList,
        orderId: generateUniqueOrderId(),
      );
      final result = _apiManager.makeOrder(request);
      return result;
    });
  }
}
