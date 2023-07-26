// To parse this JSON data, do
//
//     final closedFinanceListModel = closedFinanceListModelFromJson(jsonString);

import 'dart:convert';

ClosedFinanceListModel closedFinanceListModelFromJson(String str) =>
    ClosedFinanceListModel.fromJson(json.decode(str));

String closedFinanceListModelToJson(ClosedFinanceListModel data) =>
    json.encode(data.toJson());

class ClosedFinanceListModel {
  ClosedFinanceListModel({
    this.data,
  });

  ClosingData? data;

  factory ClosedFinanceListModel.fromJson(Map<String, dynamic> json) =>
      ClosedFinanceListModel(
        data: json["data"] == null ? null : ClosingData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class ClosingData {
  ClosingData({
    this.totalInvoices,
    this.closingRequests,
  });

  int? totalInvoices;
  List<ClosingRequest>? closingRequests;

  factory ClosingData.fromJson(Map<String, dynamic> json) => ClosingData(
        totalInvoices: json["total_invoices"],
        closingRequests: json["closing_requests"] == null
            ? []
            : List<ClosingRequest>.from(json["closing_requests"]!
                .map((x) => ClosingRequest.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total_invoices": totalInvoices,
        "closing_requests": closingRequests == null
            ? []
            : List<dynamic>.from(closingRequests!.map((x) => x.toJson())),
      };
}

class ClosingRequest {
  ClosingRequest({
    this.id = 0,
    this.closingDate = "",
    this.cod = 0,
    this.shipping = 0,
    this.totalOrders = 0,
    this.cc = 0,
    this.amountTransferred = 0,
    this.createdAt = "",
    this.currency = "",
  });

  int? id;
  String? closingDate;
  dynamic cod;
  dynamic shipping;
  dynamic totalOrders;
  dynamic cc;
  dynamic amountTransferred;
  String? createdAt;
  String currency;

  factory ClosingRequest.fromJson(Map<String, dynamic> json) => ClosingRequest(
        id: json["id"] ?? 0,
        closingDate: json["closing_date"] ?? "",
        cod: json["cod"] ?? 0,
        shipping: json["shipping"] ?? 0,
        totalOrders: json["total_orders"] ?? 0,
        cc: json["cc"] ?? 0,
        amountTransferred: json["amount_transferred"] ?? 0,
        createdAt: json["created_at"] ?? "",
        currency: json["currency"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "closing_date": closingDate,
        "cod": cod,
        "shipping": shipping,
        "total_orders": totalOrders,
        "cc": cc,
        "currency": currency,
        "amount_transferred": amountTransferred,
        "created_at": createdAt,
      };
}
