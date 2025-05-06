class BuyIngResponse {
  String? message;

  BuyIngResponse({this.message});

  factory BuyIngResponse.fromJson(Map<String, dynamic> json) {
    return BuyIngResponse(message: json['message'] as String?);
  }

  Map<String, dynamic> toJson() => {'message': message};
}
