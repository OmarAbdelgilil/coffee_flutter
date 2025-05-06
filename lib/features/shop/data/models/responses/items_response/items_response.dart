import 'item.dart';

class ItemsResponse {
  List<Item>? items;

  ItemsResponse({this.items});

  factory ItemsResponse.fromJson(Map<String, dynamic> json) => ItemsResponse(
    items:
        (json['items'] as List<dynamic>?)
            ?.map((e) => Item.fromJson(e as Map<String, dynamic>))
            .toList(),
  );

  Map<String, dynamic> toJson() => {
    'items': items?.map((e) => e.toJson()).toList(),
  };
}
