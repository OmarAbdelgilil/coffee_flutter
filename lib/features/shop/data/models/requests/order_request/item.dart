class Item {
  String? itemId;
  int? quantity;

  Item({this.itemId, this.quantity});

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    itemId: json['item_id'] as String?,
    quantity: json['quantity'] as int?,
  );

  Map<String, dynamic> toJson() => {'item_id': itemId, 'quantity': quantity};
}
