class TopSoldResponse {
  List<String>? itemsLabels;
  List<int>? itemsQuantities;
  List<Map<String, dynamic>>? topUsedIngredients;

  TopSoldResponse({
    this.itemsLabels,
    this.itemsQuantities,
    this.topUsedIngredients,
  });

  factory TopSoldResponse.fromJson(Map<String, dynamic> json) {
    return TopSoldResponse(
      itemsLabels: List<String>.from(json['itemsLabels'] ?? []),
      itemsQuantities: List<int>.from(
        json['itemsQuantities'] ?? json["neededItemsQuantities"] ?? [],
      ),
      topUsedIngredients:
          (json['topUsedIngredients'] as List<dynamic>? ??
                  json["neededIngredients"] as List<dynamic>?)
              ?.map((e) => Map<String, dynamic>.from(e as Map))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'itemsLabels': itemsLabels,
    'itemsQuantities': itemsQuantities,
    'topUsedIngredients': topUsedIngredients,
  };
}
