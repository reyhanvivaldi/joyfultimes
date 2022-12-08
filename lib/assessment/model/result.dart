import 'dart:convert';

class Result {
  Result({
    required this.date,
    required this.result,
  });

  final DateTime date;
  final String result;

  factory Result.fromJson(String str) => Result.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Result.fromMap(Map<String, dynamic> json) => Result(
        date: DateTime.parse(json["date"]),
        result: json["result"],
      );

  Map<String, dynamic> toMap() => {
        "date": date.toIso8601String(),
        "result": result,
      };
}