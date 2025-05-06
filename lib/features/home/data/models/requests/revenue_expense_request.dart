class RevenueExpenseRequest {
  String? day;

  RevenueExpenseRequest({this.day});

  factory RevenueExpenseRequest.fromJson(Map<String, dynamic> json) {
    return RevenueExpenseRequest(day: json['day'] as String?);
  }

  Map<String, dynamic> toJson() => {'day': day};
}
