// To parse this JSON data, do
//
//     final addOrderResponse = addOrderResponseFromJson(jsonString);

import 'dart:convert';

AddOrderResponse addOrderResponseFromJson(String str) =>
    AddOrderResponse.fromJson(json.decode(str));

String addOrderResponseToJson(AddOrderResponse data) =>
    json.encode(data.toJson());

class AddOrderResponse {
  AddOrderResponse({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  Data? data;

  factory AddOrderResponse.fromJson(Map<String, dynamic> json) =>
      AddOrderResponse(
        status: json["status"] == null ? "" : json["status"],
        message: json["message"] == null ? "" : json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? "" : status,
        "message": message == null ? "" : message,
        "data": data == null ? null : data!.toJson(),
      };
}

class Data {
  Data({
    this.totalOrdersAdded,
  });

  int? totalOrdersAdded;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalOrdersAdded:
            json["total_orders_added"] == null ? 0 : json["total_orders_added"],
      );

  Map<String, dynamic> toJson() => {
        "total_orders_added": totalOrdersAdded == null ? 0 : totalOrdersAdded,
      };
}
