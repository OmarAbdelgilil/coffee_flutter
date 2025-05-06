import 'package:coffe_front/core/common/api_result.dart';
import 'package:coffe_front/features/inventory/data/models/responses/buy_ing_response.dart';
import 'package:coffe_front/features/inventory/data/models/responses/ingredients_response/ingredients_response.dart';

abstract class OnlineDataSource {
  Future<Result<IngredientsResponse>> getAllIngredients();
  Future<Result<BuyIngResponse>> buyIng(String id, int q);
}
