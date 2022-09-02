// To parse this JSON data, do
//
//     final financeDashModel = financeDashModelFromJson(jsonString);

import 'dart:convert';

FinanceDashModel financeDashModelFromJson(String str) =>
    FinanceDashModel.fromJson(json.decode(str));

String financeDashModelToJson(FinanceDashModel data) =>
    json.encode(data.toJson());

class FinanceDashModel {
  FinanceDashModel({
    this.success,
    this.data,
  });

  String? success;
  FinanceDashbordData? data;

  factory FinanceDashModel.fromJson(Map<String, dynamic> json) =>
      FinanceDashModel(
        success: json["success"],
        data: FinanceDashbordData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data!.toJson(),
      };
}

class FinanceDashbordData {
  FinanceDashbordData({
    this.totalAmount,
    this.paid,
    this.readyToPay,
    this.codWithDrivers,
    this.codPending,
    this.codReturned,
  });

  dynamic totalAmount;
  dynamic paid;
  dynamic readyToPay;
  dynamic codWithDrivers;
  dynamic codPending;
  dynamic codReturned;

  factory FinanceDashbordData.fromJson(Map<String, dynamic> json) =>
      FinanceDashbordData(
        totalAmount: json["total_amount"],
        paid: json["paid"],
        readyToPay: json["ready_to_pay"],
        codWithDrivers: json["cod_with_drivers"],
        codPending: json["cod_pending"],
        codReturned: json["cod_returned"],
      );

  Map<String, dynamic> toJson() => {
        "total_amount": totalAmount,
        "paid": paid,
        "ready_to_pay": readyToPay,
        "cod_with_drivers": codWithDrivers,
        "cod_pending": codPending,
        "cod_returned": codReturned,
      };
}
