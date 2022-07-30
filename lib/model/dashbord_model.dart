// To parse this JSON data, do
//
//     final dashbordModel = dashbordModelFromJson(jsonString);

import 'dart:convert';

DashbordModel dashbordModelFromJson(String str) => DashbordModel.fromJson(json.decode(str));

String dashbordModelToJson(DashbordModel data) => json.encode(data.toJson());

class DashbordModel {
    DashbordModel({
        this.success,
        this.data,
    });

    String? success;
    FinData? data;

    factory DashbordModel.fromJson(Map<String, dynamic> json) => DashbordModel(
        success: json["success"],
        data: FinData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": data!.toJson(),
    };
}

class FinData {
    FinData({
        this.balance,
        this.cod,
        this.ship,
        this.cc,
    });

    dynamic balance;
    dynamic cod;
    dynamic ship;
    dynamic cc;

    factory FinData.fromJson(Map<String, dynamic> json) => FinData(
        balance: json["balance"],
        cod: json["cod"],
        ship: json["ship"],
        cc: json["cc"],
    );

    Map<String, dynamic> toJson() => {
        "balance": balance,
        "cod": cod,
        "ship": ship,
        "cc": cc,
    };
}
