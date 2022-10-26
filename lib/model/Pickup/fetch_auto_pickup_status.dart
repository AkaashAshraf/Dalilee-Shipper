// To parse this JSON data, do
//
//     final fetchAutoPickupResponse = fetchAutoPickupResponseFromJson(jsonString);

import 'dart:convert';

FetchAutoPickupResponse fetchAutoPickupResponseFromJson(String str) =>
    FetchAutoPickupResponse.fromJson(json.decode(str));

String fetchAutoPickupResponseToJson(FetchAutoPickupResponse data) =>
    json.encode(data.toJson());

class FetchAutoPickupResponse {
  FetchAutoPickupResponse({
    this.message,
    this.data,
  });

  String? message;
  Data? data;

  factory FetchAutoPickupResponse.fromJson(Map<String, dynamic> json) =>
      FetchAutoPickupResponse(
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message == null ? null : message,
        "data": data == null ? null : data?.toJson(),
      };
}

class Data {
  Data({
    this.pickupTime,
    this.isActive,
  });

  String? pickupTime;
  bool? isActive;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        pickupTime: json["pickup_time"] == null ? null : json["pickup_time"],
        isActive: json["is_active"] == null ? null : json["is_active"],
      );

  Map<String, dynamic> toJson() => {
        "pickup_time": pickupTime == null ? null : pickupTime,
        "is_active": isActive == null ? null : isActive,
      };
}
