class Size {
  String? itemId;
  String? size;
  double? price;

  Size({this.itemId, this.size, this.price});

  factory Size.fromJson(Map<String, dynamic> json) => Size(
    itemId: json['itemId'] as String?,
    size: json['size'] as String?,
    price: (json['price'] as num?)?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    'itemId': itemId,
    'size': size,
    'price': price,
  };
}
