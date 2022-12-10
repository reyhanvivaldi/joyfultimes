import 'dart:convert';

Mood moodFromJson(String str) => Mood.fromJson(json.decode(str));
String moodToJson(Mood data) => json.encode(data.toJson());

class Mood {
  static List<Mood> moods = [];
  String mood;
  String deskripsi;
  DateTime dateTime;
  DateTime dateTime1;
  double value;

  Mood({
    required this.mood,
    required this.deskripsi,
    required this.dateTime,
    required this.dateTime1,
    required this.value,
  });

  static void addMood({
    required mood,
    required deskripsi,
    required dateTime,
    required dateTime1,
    required value,
  }) {
    moods.add(Mood(
        mood: mood,
        deskripsi: deskripsi,
        dateTime: dateTime,
        dateTime1: dateTime1,
        value: value));
  }

  factory Mood.fromJson(Map<String, dynamic> json) => Mood(
        mood: json["title"],
        deskripsi: json["description"],
        dateTime: json["start_time"],
        dateTime1: json["end_time"],
        value: json["range"],
      );

  Map<String, dynamic> toJson() => {
        "title": mood,
        "description": deskripsi,
        "start_time": dateTime,
        "end_time": dateTime1,
        "range": value,
      };
}
