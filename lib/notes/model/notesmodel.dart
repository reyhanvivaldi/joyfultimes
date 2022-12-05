// To parse this JSON data, do
//
//     final notesModel = notesModelFromJson(jsonString);

import 'dart:convert';

List<NotesModel> notesModelFromJson(String str) => List<NotesModel>.from(json.decode(str).map((x) => NotesModel.fromJson(x)));

String notesModelToJson(List<NotesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NotesModel {
    NotesModel({
        required this.pk,
        required this.fields,
    });

    int pk;
    Fields fields;

    factory NotesModel.fromJson(Map<String, dynamic> json) => NotesModel(
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
    );

    Map<String, dynamic> toJson() => {
        "pk": pk,
        "fields": fields.toJson(),
    };
}

class Fields {
    Fields({
        required this.user,
        required this.sender,
        required this.title,
        required this.notes,
        required this.date,
    });

    int user;
    String sender;
    String title;
    String notes;
    DateTime date;

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        sender: json["sender"],
        title: json["title"],
        notes: json["notes"],
        date: DateTime.parse(json["date"]),
    );

    Map<String, dynamic> toJson() => {
        "user": user,
        "sender": sender,
        "title": title,
        "notes": notes,
        "date": date.toIso8601String(),
    };
}
