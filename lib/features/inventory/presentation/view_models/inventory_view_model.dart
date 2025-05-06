import 'package:coffe_front/core/common/api_result.dart';
import 'package:coffe_front/core/di/di.dart';
import 'package:coffe_front/features/inventory/data/data_source/online_data_source.dart';
import 'package:coffe_front/features/inventory/data/models/responses/buy_ing_response.dart';
import 'package:coffe_front/features/inventory/data/models/responses/ingredients_response/ingredients_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';

@injectable
class InventoryViewModel extends StateNotifier<InventoryStates> {
  final OnlineDataSource _onlineDataSource;
  int lowInStock = 0;
  double lowPercent = 0.0;
  InventoryViewModel(this._onlineDataSource) : super(InitialState());

  getData() async {
    state = LoadingState();
    final result = await _onlineDataSource.getAllIngredients();
    List<IngredientModel> data = [];

    switch (result) {
      case Success<IngredientsResponse>():
        lowInStock = 0;
        final total = (result).data!.count;
        for (final i in result.data!.ingredients!) {
          int totalW = i.ingWeight! * i.quantity!;
          int quantityNeeded = 0;
          int quantityToOrder = 0;
          if (i.quantity != null && i.ingWeight != null && i.quantity! < 5) {
            quantityNeeded = (5 * i.ingWeight!) - totalW;
            quantityToOrder = 5 - i.quantity!;
            lowInStock++;
          }
          final maxToOrder = 50 - i.quantity!;
          data.add(
            IngredientModel(
              ingId: i.ingId,
              ingMeas: i.ingMeas,
              ingName: i.ingName,
              ingTotalWeight: totalW,
              quantityNeed: quantityNeeded,
              quantityToOrder: quantityToOrder,
              maxOrder: maxToOrder,
              price: i.ingPrice,
            ),
          );
        }
        lowPercent = (total! - lowInStock) / total;
        state = SuccessState(data);
        return;
      case Fail<IngredientsResponse>():
        state = ErrorState(result.exception!);
        return;
    }
  }

  orderIng(IngredientModel item) async {
    final result = await _onlineDataSource.buyIng(
      item.ingId!,
      item.quantityToOrder!,
    );
    switch (result) {
      case Success<BuyIngResponse>():
        await getData();
        return;
      case Fail<BuyIngResponse>():
        state = ErrorState(result.exception!);
        result;
    }
  }
}

final inventoryProvider =
    StateNotifierProvider<InventoryViewModel, InventoryStates>(
      (ref) => getIt<InventoryViewModel>()..getData(),
    );

sealed class InventoryStates {}

class InitialState extends InventoryStates {}

class LoadingState extends InventoryStates {}

class SuccessState extends InventoryStates {
  List<IngredientModel> data;
  SuccessState(this.data);
}

class ErrorState extends InventoryStates {
  Exception ex;
  ErrorState(this.ex);
}

class IngredientModel {
  String? ingId;
  String? ingName;
  int? ingTotalWeight;
  String? ingMeas;
  int? quantityNeed;
  int? quantityToOrder;
  double? price;
  int? maxOrder;

  IngredientModel({
    this.ingId,
    this.ingName,
    this.ingTotalWeight,
    this.ingMeas,
    this.quantityNeed,
    this.quantityToOrder,
    this.price,
    this.maxOrder,
  });
}
