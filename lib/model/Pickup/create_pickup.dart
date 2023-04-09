// To parse this JSON data, do
//
//     final createPickUp = createPickUpFromJson(jsonString);

import 'dart:convert';

CreatePickUp createPickUpFromJson(String str) =>
    CreatePickUp.fromJson(json.decode(str));

String createPickUpToJson(CreatePickUp data) => json.encode(data.toJson());

class CreatePickUp {
  CreatePickUp({
    this.status = "",
    this.message = "",
  });

  String status;
  String message;

  factory CreatePickUp.fromJson(Map<String, dynamic> json) => CreatePickUp(
        status: json["status"] ?? "",
        message: json["message"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
