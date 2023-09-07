// To parse this JSON data, do
//
//     final error422Response = error422ResponseFromJson(jsonString);

import 'dart:convert';

Error422Response error422ResponseFromJson(String str) =>
    Error422Response.fromJson(json.decode(str));

String error422ResponseToJson(Error422Response data) =>
    json.encode(data.toJson());

class Error422Response {
  String status;
  String message;

  Error422Response({
    required this.status,
    required this.message,
  });

  factory Error422Response.fromJson(Map<String, dynamic> json) =>
      Error422Response(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
