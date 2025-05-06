import 'package:coffe_front/core/common/api_result.dart';
import 'package:coffe_front/core/di/di.dart';
import 'package:coffe_front/features/shop/data/data_source/online_data_source.dart';
import 'package:coffe_front/features/shop/data/models/responses/items_response/item.dart';
import 'package:coffe_front/features/shop/data/models/responses/items_response/items_response.dart';
import 'package:coffe_front/features/shop/data/models/responses/order_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';

@injectable
class ShopViewModel extends StateNotifier<ShopStates> {
  final List<OrderItemModel> cart = [];
  List<Item> items = [];
  final OnlineDataSource _onlineDataSource;
  int lowInStock = 0;
  double lowPercent = 0.0;
  ShopViewModel(this._onlineDataSource) : super(InitialState());

  getData() async {
    state = LoadingState();
    final result = await _onlineDataSource.getAllItems();
    switch (result) {
      case Success<ItemsResponse>():
        items = result.data!.items!;
        state = SuccessState();
        return;
      case Fail<ItemsResponse>():
        state = ErrorState(result.exception!);
        return;
    }
  }

  addtoCart(OrderItemModel order) {
    cart.add(order);
    state = CartUpdated();
  }

  removeFromCart(int index) {
    cart.removeAt(index);
    state = CartUpdated();
  }

  placeOrder() async {
    state = CartLoading();
    final result = await _onlineDataSource.makeOrder(cart);
    switch (result) {
      case Success<OrderResponse>():
        state = CartUpdated(message: result.data!.message);
        cart.clear();
        return;
      case Fail<OrderResponse>():
        state = CartError("Insufficient inventory to make order");
        return;
    }
  }
}

final shopProvider = StateNotifierProvider<ShopViewModel, ShopStates>(
  (ref) => getIt<ShopViewModel>()..getData(),
);

sealed class ShopStates {}

class InitialState extends ShopStates {}

class LoadingState extends ShopStates {}

class SuccessState extends ShopStates {
  SuccessState();
}

class CartUpdated extends ShopStates {
  final String? message;
  CartUpdated({this.message});
}

class CartLoading extends ShopStates {}

class CartError extends ShopStates {
  String error;
  CartError(this.error);
}

class ErrorState extends ShopStates {
  Exception ex;
  ErrorState(this.ex);
}

class OrderItemModel {
  final String name;
  final String id;
  final double price;
  OrderItemModel(this.name, this.id, this.price);
}
