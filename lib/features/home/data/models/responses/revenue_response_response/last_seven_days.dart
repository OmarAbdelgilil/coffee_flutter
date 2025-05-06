class LastSevenDays {
  List<double>? revenues;
  List<double>? expenses;
  List<String>? labels;

  LastSevenDays({this.revenues, this.expenses, this.labels});

  factory LastSevenDays.fromJson(Map<String, dynamic> json) => LastSevenDays(
    revenues: List<double>.from(
      json['revenues']?.map((e) => _parseToDouble(e)) ?? [],
    ),
    expenses: List<double>.from(
      json['expenses']?.map((e) => _parseToDouble(e)) ?? [],
    ),
    labels: List<String>.from(json['labels'] ?? []),
  );

  Map<String, dynamic> toJson() => {
    'revenues': revenues,
    'expenses': expenses,
    'labels': labels,
  };

  // Helper method to safely convert values to double
  static double _parseToDouble(dynamic value) {
    if (value is double) {
      return value;
    } else if (value is String) {
      return double.tryParse(value) ?? 0.0;
    } else {
      return 0.0;
    }
  }
}
