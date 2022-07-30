// To parse this JSON data, do
//
//     final financeDashModel = financeDashModelFromJson(jsonString);

import 'dart:convert';

FinanceDashModel financeDashModelFromJson(String str) => FinanceDashModel.fromJson(json.decode(str));

String financeDashModelToJson(FinanceDashModel data) => json.encode(data.toJson());

class FinanceDashModel {
    FinanceDashModel({
        this.success,
        this.data,
    });

    String? success;
    FinanceDashbordData? data;

    factory FinanceDashModel.fromJson(Map<String, dynamic> json) => FinanceDashModel(
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
        this.totalOrders,
        this.totalToBePaid,
        this.totalToBeCollected,
        this.codPending,
        this.totalWithDrivers,
        this.totalReturned,
      
    });

    dynamic totalOrders;
    dynamic totalToBePaid;
    dynamic totalToBeCollected;
    dynamic codPending;
    dynamic totalWithDrivers;
    dynamic totalReturned;
  

    factory FinanceDashbordData.fromJson(Map<String, dynamic> json) => FinanceDashbordData(
        totalOrders: json["total_orders"],
        totalToBePaid: json["total_to_be_paid"],
        totalToBeCollected: json["total_to_be_collected"],
        codPending: json["cod_pending"],
        totalWithDrivers: json["total_with_drivers"],
        totalReturned: json["total_returned"],
       
    );

    Map<String, dynamic> toJson() => {
        "total_orders": totalOrders,
        "total_to_be_paid": totalToBePaid,
        "total_to_be_collected": totalToBeCollected,
        "cod_pending": codPending,
        "total_with_drivers": totalWithDrivers,
        "total_returned": totalReturned,
     
    };
}
