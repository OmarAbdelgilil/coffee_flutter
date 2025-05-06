import 'item.dart';

class OrderRequest {
  String? custName;
  String? orderId;
  List<Item>? items;

  OrderRequest({this.custName, this.orderId, this.items});

  factory OrderRequest.fromJson(Map<String, dynamic> json) => OrderRequest(
    custName: json['cust_name'] as String?,
    orderId: json['order_id'] as String?,
    items:
        (json['items'] as List<dynamic>?)
            ?.map((e) => Item.fromJson(e as Map<String, dynamic>))
            .toList(),
  );

  Map<String, dynamic> toJson() => {
    'cust_name': custName,
    'order_id': orderId,
    'items': items?.map((e) => e.toJson()).toList(),
  };
}
