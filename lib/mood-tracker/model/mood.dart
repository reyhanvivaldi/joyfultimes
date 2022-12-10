import 'dart:convert';

List<Mood> moodFromJson(String str) =>
    List<Mood>.from(json.decode(str).map((x) => Mood.fromJson(x)));

String moodToJson(List<Mood> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Mood {
  Mood({
    required this.model,
    required this.pk,
    required this.fields,
  });

  String model;
  int pk;
  Fields fields;

  factory Mood.fromJson(Map<String, dynamic> json) => Mood(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
      );

  Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
      };
}

class Fields {
  Fields({
    required this.user,
    required this.mood,
    required this.deskripsi,
    required this.dateTime,
    required this.dateTime1,
    required this.range,
  });
  int user;
  String mood;
  String deskripsi;
  DateTime dateTime;
  DateTime dateTime1;
  int range;

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        mood: json["title"],
        deskripsi: json["description"],
        dateTime: DateTime.parse(json["start_time"]),
        dateTime1: DateTime.parse(json["end_time"]),
        range: json["range"],
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "title": mood,
        "description": deskripsi,
        "start_time": dateTime.toIso8601String(),
        "end_time": dateTime1.toIso8601String(),
        "range": range,
      };
}
  // static List<Mood> moods = [];
  // String mood;
  // String deskripsi;
  // DateTime dateTime;
  // DateTime dateTime1;
  // double range;

//   Mood({
    // required this.mood,
    // required this.deskripsi,
    // required this.dateTime,
    // required this.dateTime1,
    // required this.range,
//   });

//   static void addMood({
//     required mood,
//     required deskripsi,
//     required dateTime,
//     required dateTime1,
//     required range,
//   }) {
  //   moods.add(Mood(
  //       mood: mood,
  //       deskripsi: deskripsi,
  //       dateTime: dateTime,
  //       dateTime1: dateTime1,
  //       range: range));
  // }

  // factory Mood.fromJson(Map<String, dynamic> json) => Mood(
  //       mood: json["fields"]["title"],
  //       deskripsi: json["fields"]["description"],
  //       dateTime: json["fields"]["start_time"],
  //       dateTime1: json["fields"]["end_time"],
  //       range: json["fields"]["range"],
  //     );

  // Map<String, dynamic> toJson() => {
  //       "title": mood,
  //       "description": deskripsi,
  //       "start_time": dateTime,
  //       "end_time": dateTime1,
  //       "range": range,
  //     };

