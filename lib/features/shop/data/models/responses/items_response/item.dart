import 'size.dart';

class Item {
  String? item;
  List<Size>? sizes;

  Item({this.item, this.sizes});

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    item: json['item'] as String?,
    sizes:
        (json['sizes'] as List<dynamic>?)
            ?.map((e) => Size.fromJson(e as Map<String, dynamic>))
            .toList(),
  );

  Map<String, dynamic> toJson() => {
    'item': item,
    'sizes': sizes?.map((e) => e.toJson()).toList(),
  };
}
