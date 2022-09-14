// To parse this JSON data, do
//
//     final financeMainDashboardModel = financeMainDashboardModelFromJson(jsonString);

import 'dart:convert';

FinanceMainDashboardModel financeMainDashboardModelFromJson(String str) =>
    FinanceMainDashboardModel.fromJson(json.decode(str));

String financeMainDashboardModelToJson(FinanceMainDashboardModel data) =>
    json.encode(data.toJson());

class FinanceMainDashboardModel {
  FinanceMainDashboardModel({
    this.success,
    this.data,
  });

  String? success;
  Data? data;

  factory FinanceMainDashboardModel.fromJson(Map<String, dynamic> json) =>
      FinanceMainDashboardModel(
        success: json["success"] == null ? null : json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "data": data == null ? null : data!.toJson(),
      };
}

class Data {
  Data({
    this.stats,
  });

  FinanceStats? stats;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        stats:
            json["stats"] == null ? null : FinanceStats.fromJson(json["stats"]),
      );

  Map<String, dynamic> toJson() => {
        "stats": stats == null ? null : stats!.toJson(),
      };
}

class FinanceStats {
  FinanceStats(
      {this.totalAmount,
      this.codWithDrivers,
      this.codPending,
      this.codReturned,
      this.paid,
      this.readyToPay,
      this.totalShippingAmount});

  dynamic totalAmount;
  dynamic codWithDrivers;
  dynamic codPending;
  dynamic codReturned;
  dynamic paid;
  dynamic readyToPay;
  dynamic totalShippingAmount;

  factory FinanceStats.fromJson(Map<String, dynamic> json) => FinanceStats(
        totalAmount: json["total_amount"] == null
            ? 0
            : json["total_amount"] == ""
                ? 0
                : json["total_amount"].toDouble(),
        codWithDrivers: json["cod_with_drivers"] == null
            ? 0
            : json["cod_with_drivers"] == ""
                ? 0
                : json["cod_with_drivers"].toDouble(),
        codPending: json["cod_pending"] == null
            ? 0
            : json["cod_pending"] == ""
                ? 0
                : json["cod_pending"],
        codReturned: json["cod_returned"] == null
            ? 0
            : json["cod_returned"] == ""
                ? 0
                : json["cod_returned"],
        paid: json["paid"] == null
            ? 0
            : json["paid"] == ""
                ? 0
                : json["paid"],
        readyToPay: json["ready_to_pay"] == null
            ? 0
            : json["ready_to_pay"] == ""
                ? 0
                : json["ready_to_pay"],
        totalShippingAmount: json["total_shipping_amount"] == null
            ? 0
            : json["total_shipping_amount"],
      );

  Map<String, dynamic> toJson() => {
        "total_amount": totalAmount == null ? 0 : totalAmount,
        "cod_with_drivers": codWithDrivers == null ? 0 : codWithDrivers,
        "cod_pending": codPending == null ? 0 : codPending,
        "cod_returned": codReturned == null ? 0 : codReturned,
        "paid": paid == null ? 0 : paid,
        "ready_to_pay": readyToPay == null ? 0 : readyToPay,
        "total_shipping_amount":
            totalShippingAmount == null ? 0 : totalShippingAmount,
      };
}
