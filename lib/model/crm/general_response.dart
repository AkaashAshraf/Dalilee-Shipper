// To parse this JSON data, do
//
//     final crmgenralresponse = crmgenralresponseFromJson(jsonString);

import 'dart:convert';

Crmgenralresponse crmgenralresponseFromJson(String str) =>
    Crmgenralresponse.fromJson(json.decode(str));

String crmgenralresponseToJson(Crmgenralresponse data) =>
    json.encode(data.toJson());

class Crmgenralresponse {
  Crmgenralresponse({
    this.messageEn,
    this.messageAr,
    this.status,
  });

  String? messageEn;
  String? messageAr;
  int? status;

  factory Crmgenralresponse.fromJson(Map<String, dynamic> json) =>
      Crmgenralresponse(
        messageEn: json["message_en"],
        messageAr: json["message_ar"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "message_en": messageEn,
        "message_ar": messageAr,
        "status": status,
      };
}
