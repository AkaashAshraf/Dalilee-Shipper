// To parse this JSON data, do
//
//     final exchangeOrder = exchangeOrderFromJson(jsonString);

import 'dart:convert';

ExchangeOrder exchangeOrderFromJson(String str) =>
    ExchangeOrder.fromJson(json.decode(str));

class ExchangeOrder {
  String status;
  String message;
  Data data;

  ExchangeOrder({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ExchangeOrder.fromJson(Map<String, dynamic> json) => ExchangeOrder(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  NewOrder newOrder;

  Data({
    required this.newOrder,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        newOrder: NewOrder.fromJson(json["newOrder"]),
      );
}

class NewOrder {
  String orderId;

  NewOrder({
    required this.orderId,
  });

  factory NewOrder.fromJson(Map<String, dynamic> json) => NewOrder(
        orderId: json["orderId"],
      );
}
