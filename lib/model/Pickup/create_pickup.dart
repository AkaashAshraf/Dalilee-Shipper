// To parse this JSON data, do
//
//     final createPick = createPickFromJson(jsonString);

import 'dart:convert';

CreatePick createPickFromJson(String str) =>
    CreatePick.fromJson(json.decode(str));

String createPickToJson(CreatePick data) => json.encode(data.toJson());

class CreatePick {
  CreatePick({
    required this.status,
    required this.message,
  });

  String status;
  String message;

  factory CreatePick.fromJson(Map<String, dynamic> json) => CreatePick(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
