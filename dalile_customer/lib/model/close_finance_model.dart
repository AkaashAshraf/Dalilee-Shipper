// To parse this JSON Closedata, do
//
//     final closedFinanceListModel = closedFinanceListModelFromJson(jsonString);

import 'dart:convert';

ClosedFinanceListModel closedFinanceListModelFromJson(String str) =>
    ClosedFinanceListModel.fromJson(json.decode(str));

String closedFinanceListModelToJson(ClosedFinanceListModel data) =>
    json.encode(data.toJson());

class ClosedFinanceListModel {
  ClosedFinanceListModel({
    this.success,
    this.data,
  });

  String? success;
  CloseData? data;

  factory ClosedFinanceListModel.fromJson(Map<String, dynamic> json) =>
      ClosedFinanceListModel(
        success: json["success"],
        data: CloseData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data!.toJson(),
      };
}

class CloseData {
  CloseData({
    this.invoices,
  });

  List<Invoice>? invoices;

  factory CloseData.fromJson(Map<String, dynamic> json) => CloseData(
        invoices: List<Invoice>.from(
            json["invoices"].map((x) => Invoice.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "invoices": List<dynamic>.from(invoices!.map((x) => x.toJson())),
      };
}

class Invoice {
  Invoice({
    this.id,
    this.closingDate,
    this.cod,
    this.shippingCost,
    this.totalOrders,
    this.cc,
    this.amountTransferred,
    this.createdAt,
  });

  int? id;
  dynamic closingDate;
  dynamic cod;
  dynamic shippingCost;
  dynamic totalOrders;
  dynamic cc;
  dynamic amountTransferred;
  dynamic createdAt;

  factory Invoice.fromJson(Map<String, dynamic> json) => Invoice(
        id: json["id"],
        closingDate: json["closing_date"],
        cod: json["cod"],
        shippingCost: json["shipping_cost"],
        totalOrders: json["total_orders"],
        cc: json["cc"],
        amountTransferred: json["amount_transferred"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "closing_date": closingDate,
        "cod": cod,
        "shipping_cost": shippingCost,
        "total_orders": totalOrders,
        "cc": cc,
        "amount_transferred": amountTransferred,
        "created_at": createdAt,
      };
}
