class Ingredient {
  String? id;
  String? ingId;
  String? ingName;
  int? ingWeight;
  String? ingMeas;
  int? v;
  double? ingPrice;
  int? quantity;

  Ingredient({
    this.id,
    this.ingId,
    this.ingName,
    this.ingWeight,
    this.ingMeas,
    this.v,
    this.ingPrice,
    this.quantity,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) => Ingredient(
    id: json['_id'] as String?,
    ingId: json['ing_id'] as String?,
    ingName: json['ing_name'] as String?,
    ingWeight: json['ing_weight'] as int?,
    ingMeas: json['ing_meas'] as String?,
    v: json['__v'] as int?,
    ingPrice: (json['ing_price'] as num?)?.toDouble(),
    quantity: json['Quantity'] as int?,
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'ing_id': ingId,
    'ing_name': ingName,
    'ing_weight': ingWeight,
    'ing_meas': ingMeas,
    '__v': v,
    'ing_price': ingPrice,
    'Quantity': quantity,
  };
}
