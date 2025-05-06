class OrderResponse {
  String? message;

  OrderResponse({this.message});

  factory OrderResponse.fromJson(Map<String, dynamic> json) =>
      OrderResponse(message: json['message'] as String?);

  Map<String, dynamic> toJson() => {'message': message};
}
