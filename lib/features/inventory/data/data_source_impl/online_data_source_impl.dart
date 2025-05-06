import 'package:coffe_front/core/common/api_result.dart';
import 'package:coffe_front/core/network/api/api_execution.dart';
import 'package:coffe_front/core/network/api/api_manager.dart';
import 'package:coffe_front/features/inventory/data/data_source/online_data_source.dart';
import 'package:coffe_front/features/inventory/data/models/requests/buy_ing_request.dart';
import 'package:coffe_front/features/inventory/data/models/responses/buy_ing_response.dart';
import 'package:coffe_front/features/inventory/data/models/responses/ingredients_response/ingredients_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: OnlineDataSource)
class OnlineDataSourceImpl extends OnlineDataSource {
  final ApiManager _apiManager;
  OnlineDataSourceImpl(this._apiManager);

  @override
  Future<Result<IngredientsResponse>> getAllIngredients() {
    return executeApi(() async {
      final result = await _apiManager.getAllIngredients();
      return result;
    });
  }

  @override
  Future<Result<BuyIngResponse>> buyIng(String id, int q) {
    return executeApi(() async {
      final result = await _apiManager.buyIngredient(
        BuyIngRequest(ingId: id, quantity: q.toString()),
      );
      return result;
    });
  }
}
