// To parse this JSON data, do
//
//     final mainDashboard = mainDashboardFromJson(jsonString);

import 'dart:convert';

MainDashboard mainDashboardFromJson(String str) =>
    MainDashboard.fromJson(json.decode(str));

String mainDashboardToJson(MainDashboard data) => json.encode(data.toJson());

class MainDashboard {
  MainDashboard({
    this.success,
    this.data,
  });

  String? success;
  Data? data;

  factory MainDashboard.fromJson(Map<String, dynamic> json) => MainDashboard(
        success: json["success"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    this.totalShipments,
    this.deliveredShipments,
    this.toBePickups,
    this.toBeDelivered,
    this.returnedShipments,
    this.cancelShipments,
    this.undeliveredShipments,
    this.ofdShipments,
  });

  int? totalShipments;
  int? deliveredShipments;
  int? toBePickups;
  int? toBeDelivered;
  int? returnedShipments;
  int? cancelShipments;
  int? undeliveredShipments;
  int? ofdShipments;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalShipments: json["total_shipments"],
        deliveredShipments: json["delivered_shipments"],
        toBePickups: json["to_be_pickups"],
        toBeDelivered: json["to_be_delivered"],
        returnedShipments: json["returned_shipments"],
        cancelShipments: json["cancel_shipments"],
        undeliveredShipments: json["undelivered_shipments"],
        ofdShipments: json["ofd_shipments"],
      );

  Map<String, dynamic> toJson() => {
        "total_shipments": totalShipments,
        "delivered_shipments": deliveredShipments,
        "to_be_pickups": toBePickups,
        "to_be_delivered": toBeDelivered,
        "returned_shipments": returnedShipments,
        "cancel_shipments": cancelShipments,
        "undelivered_shipments": undeliveredShipments,
        "ofd_shipments": ofdShipments,
      };
}
