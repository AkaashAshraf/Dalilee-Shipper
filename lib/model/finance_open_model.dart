// To parse this JSON data, do
//
//     final financeOpenModel = financeOpenModelFromJson(jsonString);

import 'dart:convert';

FinanceOpenModel financeOpenModelFromJson(String str) =>
    FinanceOpenModel.fromJson(json.decode(str));

String financeOpenModelToJson(FinanceOpenModel data) =>
    json.encode(data.toJson());

class FinanceOpenModel {
  FinanceOpenModel({
    this.success,
    this.data,
  });

  String? success;
  OpenData? data;

  factory FinanceOpenModel.fromJson(Map<String, dynamic> json) =>
      FinanceOpenModel(
        success: json["success"],
        data: OpenData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data!.toJson(),
      };
}

class OpenData {
  OpenData({
    this.remaining,
    this.totalOrdersDelivered,
    this.totalAmountRequest,
    this.deliveryFee = 0,
    this.collectionFee,
  });

  dynamic remaining;
  dynamic totalOrdersDelivered;
  dynamic totalAmountRequest;
  dynamic deliveryFee;
  dynamic collectionFee;

  factory OpenData.fromJson(Map<String, dynamic> json) => OpenData(
        remaining: json["remaining"],
        totalOrdersDelivered: json["total_orders_delivered"],
        totalAmountRequest: json["total_amount_request"],
        deliveryFee: json["delivery_fee"] ?? 0,
        collectionFee: json["collection_fee"],
      );

  Map<String, dynamic> toJson() => {
        "remaining": remaining,
        "total_orders_delivered": totalOrdersDelivered,
        "total_amount_request": totalAmountRequest,
        "delivery_fee": deliveryFee,
        "collection_fee": collectionFee,
      };
}
