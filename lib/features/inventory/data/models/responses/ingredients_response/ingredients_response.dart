import 'ingredient.dart';

class IngredientsResponse {
  int? count;
  List<Ingredient>? ingredients;

  IngredientsResponse({this.count, this.ingredients});

  factory IngredientsResponse.fromJson(Map<String, dynamic> json) {
    return IngredientsResponse(
      count: json['count'] as int?,
      ingredients:
          (json['ingredients'] as List<dynamic>?)
              ?.map((e) => Ingredient.fromJson(e as Map<String, dynamic>))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'count': count,
    'ingredients': ingredients?.map((e) => e.toJson()).toList(),
  };
}
