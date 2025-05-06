class BuyIngRequest {
  String? ingId;
  String? quantity;

  BuyIngRequest({this.ingId, this.quantity});

  factory BuyIngRequest.fromJson(Map<String, dynamic> json) => BuyIngRequest(
    ingId: json['ing_id'] as String?,
    quantity: json['quantity'] as String?,
  );

  Map<String, dynamic> toJson() => {'ing_id': ingId, 'quantity': quantity};
}
