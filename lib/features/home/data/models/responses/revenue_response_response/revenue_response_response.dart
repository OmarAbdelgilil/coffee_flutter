import 'last_seven_days.dart';

class RevenueResponseResponse {
  String? date;
  String? todayRevenue;
  String? todayExpenses;
  int? todayProfit;
  int? todayOrderCount;
  int? totalOrderCount;
  LastSevenDays? lastSevenDays;

  RevenueResponseResponse({
    this.date,
    this.todayRevenue,
    this.todayExpenses,
    this.todayProfit,
    this.todayOrderCount,
    this.totalOrderCount,
    this.lastSevenDays,
  });

  factory RevenueResponseResponse.fromJson(Map<String, dynamic> json) {
    return RevenueResponseResponse(
      date: json['date'] as String?,
      todayRevenue: json['todayRevenue'] as String?,
      todayExpenses: json['todayExpenses'] as String?,
      todayProfit: json['stock'] as int?,
      todayOrderCount: json['todayOrderCount'] as int?,
      totalOrderCount: json['totalOrderCount'] as int?,
      lastSevenDays:
          json['lastSevenDays'] == null
              ? null
              : LastSevenDays.fromJson(
                json['lastSevenDays'] as Map<String, dynamic>,
              ),
    );
  }

  Map<String, dynamic> toJson() => {
    'date': date,
    'todayRevenue': todayRevenue,
    'todayExpenses': todayExpenses,
    'todayProfit': todayProfit,
    'todayOrderCount': todayOrderCount,
    'totalOrderCount': totalOrderCount,
    'lastSevenDays': lastSevenDays?.toJson(),
  };
}
