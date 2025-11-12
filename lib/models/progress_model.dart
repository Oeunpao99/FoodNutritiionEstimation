class Progress {
  final String id;
  final double weight;
  final double bodyFatPercentage;
  final DateTime date;

  Progress({
    required this.id,
    required this.weight,
    required this.bodyFatPercentage,
    required this.date,
  });

  factory Progress.fromJson(Map<String, dynamic> json) {
    return Progress(
      id: json['id'],
      weight: json['weight'],
      bodyFatPercentage: json['bodyFatPercentage'],
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'weight': weight,
      'bodyFatPercentage': bodyFatPercentage,
      'date': date.toIso8601String(),
    };
  }
}
