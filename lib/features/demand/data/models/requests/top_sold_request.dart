class TopSoldRequest {
  String? date;

  TopSoldRequest({this.date});

  factory TopSoldRequest.fromJson(Map<String, dynamic> json) {
    return TopSoldRequest(date: json['date'] as String?);
  }

  Map<String, dynamic> toJson() => {'date': date};
}
